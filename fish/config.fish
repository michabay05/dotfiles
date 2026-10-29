if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init fish | source
fzf --fish | source


# Added by Antigravity CLI installer
set -gx PATH "/home/mabayneh/opt/antigravity" $PATH

# opencode
fish_add_path /home/mabayneh/opt/opencode
