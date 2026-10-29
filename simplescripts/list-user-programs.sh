#! /usr/bin/bash

OUT_FILE="autogen-user-programs.txt"
echo "# AUTO-GENERATED FILE (mabay)" > $OUT_FILE
ls -1 ~/opt/ >> $OUT_FILE

OUT_FILE="autogen-user-symlinks.txt"
echo "# AUTO-GENERATED FILE (mabay)" > $OUT_FILE
ls -1 ~/opt/symbins/ >> $OUT_FILE
