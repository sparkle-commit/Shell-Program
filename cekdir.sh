#!/bin/bash
#Author : Mohammad Riza Al Fahri

if test $# -ne 0; then
  echo "Usage: $0 <The command you entered caused an error>"
  exit 1
fi


file=$1

for file in *;
do

if test -d "$file"; then
  echo "$file is a directory"
else
  if test -h "$file"; then
    echo "$file is a symbolic link"
  else
    if test -f "$file"; then
      echo "$file is a file"
    else
      echo "$file is of unknown type"
    fi
  fi
fi
done

