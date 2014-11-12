#!/bin/bash

IFS="="
while read -r name value
do
  if [ "$2" = "$name" ]; then
    echo "${value//\"/}"
  fi
done < $1
