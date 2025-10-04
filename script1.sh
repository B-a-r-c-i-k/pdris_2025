#!/bin/bash

REPO=$1
BRANCH1=$2
BRANCH2=$3

DIR_NAME=$(basename "$REPO" ".git")

echo $DIR_NAME

git clone $REPO

cd $DIR_NAME

git checkout $BRANCH1
git checkout $BRANCH2

git branch

git diff $BRANCH1 $BRANCH2 --name-status > ../diff_report_${BRANCH1}_vs_${BRANCH2}.txt


