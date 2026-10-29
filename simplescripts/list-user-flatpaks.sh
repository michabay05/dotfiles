#! /usr/bin/bash

OUT_FILE="autogen-user-flatpaks.txt"
echo "# AUTO-GENERATED FILE (mabay)" > $OUT_FILE
flatpak list --app >> $OUT_FILE
