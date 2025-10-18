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

FILENAME="../diff_report_${BRANCH1}_vs_${BRANCH2}.txt"

echo "================================
Репозиторий:    ${REPO}
Ветка 1:        ${BRANCH1}
Ветка 2:        ${BRANCH2}
Дата генерации: $(date +"%Y-%m-%d %H-%M-%S")
================================

СПИСОК ИЗМЕНЕННЫХ ФАЙЛОВ:" > $FILENAME

git diff $BRANCH1 $BRANCH2 --name-status >> $FILENAME

echo "
СТАТИСТИКА:" >> $FILENAME

M_COUNT=$(cat $FILENAME |  awk '/^M\t/' | wc -l)
A_COUNT=$(cat $FILENAME |  awk '/^A\t/' | wc -l)
D_COUNT=$(cat $FILENAME |  awk '/^D\t/' | wc -l)
ALL_COUNT=$(($M_COUNT + $A_COUNT + $D_COUNT))
echo "Всего измененных файлов: ${ALL_COUNT}
Добавлено (A): $A_COUNT
Удалено (D): $D_COUNT
Изменено (M): $M_COUNT" >> $FILENAME


