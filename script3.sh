#!/bin/bash

FILENAME=$1
LOG=$2

cat $FILENAME | grep $LOG > "${LOG}_${FILENAME}"
cat "${LOG}_${FILENAME}" | wc -l