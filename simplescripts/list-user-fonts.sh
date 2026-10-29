#! /usr/bin/bash

OUT_FILE="autogen-user-fonts.txt"
echo "# AUTO-GENERATED FILE (mabay)" > $OUT_FILE
ls -1 ~/.local/share/fonts/ | sed 's/\(.*\)-\(.*\).ttf/\1/' | uniq | sort >> $OUT_FILE
