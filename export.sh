#!/usr/bin/env bash

git add .

DATE=$(date)

git commit -m "changes made on $DATE"

git push

echo"Pushed to remote"
