function fish_prompt
    set -l last_status $status
    set -l normal (set_color normal)

    set -l delim '$ '
    set -l cwd_color (set_color $fish_color_cwd)

    if fish_is_root_user
        set delim '# '
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
    end

    # Show exit status only when non-zero
    set -l prompt_status
    if test $last_status -ne 0
        set prompt_status (set_color $fish_color_status)"[$last_status]$normal "
    end

    # Git: show only branch name and dirty state using theme colors
    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_color_branch $fish_color_param
    set -g __fish_git_prompt_color_dirtystate $fish_color_status
    set -g __fish_git_prompt_color_stagedstate $fish_color_status
    set -g __fish_git_prompt_char_dirtystate 'x'
    set -g __fish_git_prompt_char_stagedstate 'x'
    set -e __fish_git_prompt_showuntrackedfiles __fish_git_prompt_showupstream __fish_git_prompt_use_informative_chars

    set -l git_info (fish_git_prompt '(%s) ')

    # Show '~' for home, otherwise just the current folder name
    set -l pwd (basename (prompt_pwd))

    echo -n -s ' ' $cwd_color $pwd ' ' $normal $git_info $prompt_status $delim
end
