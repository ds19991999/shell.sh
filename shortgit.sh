#!/bin/bash
# usage: wget https://git.io/shortgit.sh
#     bash shortgit.sh url shortcode
#     bash shortgit.sh url
if [ -n "$2" ]; then
    curl -i https://git.io -F url="$1" -F code="$2";
else
    curl -i http://git.io -F url="$1";
fi
