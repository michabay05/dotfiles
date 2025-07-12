#! /usr/bin/python

from pathlib import Path
from datetime import datetime
from typing import Iterator
from filecmp import dircmp
import os, shutil, sys


def usage(program_name: str) -> None:
    print(f"Usage:")
    print(f"    {program_name} ACTION [OPTIONS]\n")
    print("ACTION:")
    print("    detect - Provide a list of out-of-date configs")
    print("    update - Sync out-of-date configs in system and in this directory")
    print("     setup - Copy configs from this directory to the system\n")
    print("OPTIONS:")
    print("    --help - Show list of command line options\n")

SYS_CONFIG_PATHS: list[tuple[str, str]] = [
    ("~/.config/alacritty", "alacritty"),
    ("~/.config/nvim", "nvim"),
    ("~/.config/zed", "zed"),
]

def detect_out_of_date(act: bool) -> None:
    curr_dir: Path = Path(__file__).parent
    print(f"[INFO] Current working directory: '{curr_dir}'")
    for sys_path, local_path in SYS_CONFIG_PATHS:
        if sys_path.startswith('~'):
            sys_path = f"{Path.home()}{sys_path[1:]}"

        dcmp = dircmp(sys_path, local_path)
        diffs: list[tuple[str, str]] = []
        find_diff_files(dcmp, diffs, act=act)
        for src, dst in diffs:
            print(f"[INFO] Diff: {src} -> {dst}")


def find_diff_files(dcmp: dircmp, diffs: list[tuple[str, str]], act: bool) -> None:
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

    action = args[1]
    match action:
        case "detect":
            detect_out_of_date(act=False)
        case "update":
            detect_out_of_date(act=True)
        case "setup":
            pass
        case _:
            print(f"[ERROR] Unknown action type: '{action}'")
            print(f"[INFO] Refer the help list to find out the list of valid actions.")
            sys.exit(1)
