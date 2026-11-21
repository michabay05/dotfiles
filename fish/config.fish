if status is-interactive
    # Commands to run in interactive sessions can go here
end

# symbins
fish_add_path /home/mabayneh/opt/symbins

~/opt/zoxide-v0.10.0/zoxide init fish | source
~/opt/fzf-v0.74.2/fzf --fish | source

# opencode
fish_add_path /home/mabayneh/opt/opencode

# Convenient aliases
alias l="ls -lah --color"
