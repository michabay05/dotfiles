#! /usr/bin/python

from pathlib import Path
import filecmp, os, shutil, sys


def usage(program_name: str) -> None:
    print(f"Usage:")
    print(f"    {program_name} ACTION [OPTIONS]\n")
    print("ACTION:")
    print("    detect - Provide a list of out-of-date configs (system -> local)")
    print("    update - Sync out-of-date configs in system and in this directory")
    print("     setup - Copy configs from this directory to the system\n")
    print("OPTIONS:")
    print("    --help - Show list of command line options\n")

SYS_CONFIG_PATHS: list[tuple[str, str]] = [
    ("~/.config/alacritty", "alacritty"),
    ("~/.config/nvim", "nvim"),
    ("~/.config/zed", "zed"),
    ("~/.vimrc", ".vimrc"),
    ("~/.tmux.conf", ".tmux.conf"),
]

def detect_out_of_date(act: bool) -> None:
    """Find a list of out of date config and maybe act upon them.

        NOTE: The config found on the user's system is considered the source of truth. This
              means that the files from the system are copied over into this directory.
    """
    diff_found: bool = False

    for sys_path, local_path in SYS_CONFIG_PATHS:
        if sys_path.startswith('~'):
            sys_path = f"{Path.home()}{sys_path[1:]}"

        print(f"Checking '{sys_path}' vs '{local_path}'...")
        sys_is_dir: bool = os.path.isdir(sys_path)
        local_is_dir: bool = os.path.isdir(local_path)

        if sys_is_dir ^ local_is_dir:
            print(
                f"[ERROR] Both sys_path and local_path should of the same type: either a file or directory"
            )
            sys.exit(1)

        if sys_is_dir:
            dcmp = filecmp.dircmp(sys_path, local_path)
            diffs: list[tuple[str, str]] = []
            if not diff_found and len(diffs) > 0:
                diff_found = True

            find_diff_files(dcmp, diffs, act=act)
            for src, dst in diffs:
                if act:
                    print(f"[INFO]     Updated: {src} -> {dst}")
                else:
                    print(f"[INFO]     Diff: {src} -> {dst}")
        else:
            # If sys_path and local_path are not the same, then...
            if not filecmp.cmp(sys_path, local_path):
                diff_found = True
                if act:
                    shutil.copyfile(sys_path, local_path)
                    print(f"[INFO]     Updated: {sys_path} -> {local_path}")
                else:
                    print(f"[INFO]     Diff: {sys_path} -> {local_path}")

    if not diff_found:
        print("[INFO] No difference found. Config found here is the same as the ones that exist on the system.")


def find_diff_files(dcmp: filecmp.dircmp, diffs: list[tuple[str, str]], act: bool) -> None:
    for name in dcmp.diff_files:
        src_path = f"{dcmp.left}/{name}"
        dst_path = f"{dcmp.right}/{name}"
        diffs.append((src_path, dst_path))
        if act:
            shutil.copyfile(src_path, dst_path)

    for name in dcmp.left_only:
        src_path = f"{dcmp.left}/{name}"
        diffs.append((src_path, "???"))
        if act:
            if os.path.isdir(src_path):
                shutil.copytree(src_path, f"{dcmp.right}/{name}")
            else:
                shutil.copy2(src_path, f"{dcmp.right}/{name}")

    for name in dcmp.right_only:
        dst_path = f"{dcmp.right}/{name}"
        diffs.append(("???", dst_path))
        if act:
            os.remove(f"{dcmp.right}/{name}")

    for sub_dcmp in dcmp.subdirs.values():
        find_diff_files(sub_dcmp, diffs, act=act)



if __name__ == "__main__":
    args = sys.argv
    program_name = args[0]
    if len(args) <= 1:
        usage(program_name)
        print("[INFO] Please provide the correct parameters according to the usage above.")
        sys.exit(1)

    curr_dir = os.getcwd()
    print(f"[INFO] Current working directory: '{curr_dir}'")
    print("================")

    action = args[1]
    match action:
        case "detect":
            detect_out_of_date(act=False)
        case "update":
            detect_out_of_date(act=True)
        case "setup":
            raise NotImplementedError()
        case _:
            print(f"[ERROR] Unknown action type: '{action}'")
            print(f"[INFO] Refer the help list to find out the list of valid actions.")
            sys.exit(1)
