function fish_prompt
        set -l last_status $status

        set -l normal (set_color --reset)
        set -l usercolor (set_color $fish_color_user)

        set -l delim "\$ "

        fish_is_root_user; and set delim "#"

        set -l cwd (set_color $fish_color_cwd)

        # Prompt status only if it's not 0
        set -l prompt_status
        test $last_status -ne 0; and set prompt_status (set_color $fish_color_status)"[$last_status]$normal"
        # Shorten pwd if prompt is too long
        set -l pwd (basename $PWD)

        echo -n -s " " $cwd $pwd " " $normal $prompt_status $delim
end
