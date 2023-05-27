#! /bin/sh

set -xe

update_nvim_config() {
    rm -rf ./nvim_config
    cp -r ~/.config/nvim . 
    mv nvim nvim_config
    git add .
    git commit -m "Another update to my nvim config"
    git push
}

update_nvim_config
