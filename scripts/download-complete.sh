#!/bin/sh
 
# $1 is gid.
# $2 is the number of files.
# $3 is the path of the first file.
 
DOWNLOAD=/media/extraDisk/aria2c/downloading # no trailing slash!
COMPLETE=/media/extraDisk/aria2c/done # no trailing slash!
LOG=/media/extraDisk/aria2c/logs/mvcompleted.log
SRC=$3
 
if [ "$2" == "0" ]; then
  echo `date` "INFO  no file to move for" "$1". >> "$LOG"
  exit 0
fi
 
while true; do
  DIR=`dirname "$SRC"`
  if [ "$DIR" == "$DOWNLOAD" ]; then
    echo `date` "INFO " "$3" moved as "$SRC". >> "$LOG"
    mv --backup=t "$SRC" "$COMPLETE" >> "$LOG" 2>&1
    exit $?
  elif [ "$DIR" == "/" -o "$DIR" == "." ]; then
    echo `date` ERROR "$3" not under "$DOWNLOAD". >> "$LOG"
    exit 1
  else
    SRC=$DIR
  fi
done
