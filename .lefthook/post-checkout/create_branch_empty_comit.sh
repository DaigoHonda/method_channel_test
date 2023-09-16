#!/bin/bash

# $1 = Previous HEAD ref
# $2 = New HEAD ref
# $3 = Flag (1 if branch checkout, 0 if file checkout)
if [ $3 -eq 1 ]; then
  if [ $1 == $2 ]; then
    git commit --allow-empty -m "create new branch"
  fi
fi