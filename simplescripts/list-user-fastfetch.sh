#! /usr/bin/bash

OUT_FILE="autogen-user-fastfetch.txt"
echo "# AUTO-GENERATED FILE (mabay)" > $OUT_FILE
fastfetch >> $OUT_FILE
