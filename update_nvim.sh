#! /bin/sh

set -xe

rm -rf ./nvim_config
cp -r ~/.config/nvim . 
mv nvim nvim_config
git add .
git commit -m "Another update to my nvim config"
git push
