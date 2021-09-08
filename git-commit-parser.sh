#!/bin/bash

#デリミタを改行に指定
IFS=$'\n'

function usage() {
cat <<_EOT_
Usage:
  `basename $0` <target>

Example:
  `basename $0` v2.0.0

_EOT_
exit 1
}

if [ $# != 1 ]; then
  echo "ERROR: <target> is not specified"
  usage
  exit 1
fi

COMMENTS=($(git --no-pager log --merges --reverse --pretty=format:"%b" $1..HEAD))
PR_NUMBERS=($(git --no-pager log --merges --reverse --pretty=format:"%s" $1..HEAD | awk '{print $4}'))

for i in "${!COMMENTS[@]}"
do
  echo ${COMMENTS[$i]} ${PR_NUMBERS[$i]}
done
