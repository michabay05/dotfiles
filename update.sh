#!/usr/bin/bash

update_vim_config() {
    rm -rf ./vim_config/*
    cp ~/.vimrc vim_config 
    echo "Updated vim config..."
}

update_nvim_config() {
    rm -rf ./nvim_config
    cp -r ~/.config/nvim . 
    mv nvim nvim_config
    echo "Updated nvim config..."
}

update_alacritty_config() {
    rm -rf ./alacritty_config
    cp -r ~/.config/alacritty . 
    mv alacritty alacritty_config
    echo "Updated alacritty config..."
}

update_i3_config() {
    rm -rf ./i3_config
    cp -r ~/.config/i3 . 
    mv i3 i3_config
    echo "Updated i3 config..."
}

update_i3status_config() {
    rm -rf ./i3status_config
    cp -r ~/.config/i3status . 
    mv i3status i3status_config
    echo "Updated i3status config..."
}

all() {
    update_vim_config
    update_nvim_config
    update_i3_config
    update_i3status_config
}

if [[ -z "$1" ]]; then
    echo "Please input type of argument: [ all, alacritty, i3, i3status, nvim, vim ]"
    exit 1
fi

cd ~/dotfiles

if [[ "$1" == "all" ]]; then
    all
elif [[ "$1" == "alacritty" ]]; then
    update_alacritty_config
elif [[ "$1" == "i3" ]]; then
    update_i3_config
elif [[ "$1" == "i3status" ]]; then
    update_i3status_config
elif [[ "$1" == "nvim" ]]; then
    update_nvim_config
elif [[ "$1" == "vim" ]]; then
    update_vim_config
fi

echo "Finished updating..."

git add .
git commit -m "Another update to my configs"
git push

echo "Committed and pushed changes."
