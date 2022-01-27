#!/bin/bash
# hash=$(git log -1 --format='%h')
title=$(git log -1 --format='%s')
title_tag=$(git log -1 --format='%f')
body=$(git log -1 --format='%b')
echo title="$title" >> "$GITHUB_ENV"
echo title_tag="$title_tag" >> "$GITHUB_ENV"

if [[ $title =~ ^release ]]; then echo pre=false >> "$GITHUB_ENV";
    elif [[ $title =~ ^pre-release ]]; then echo pre=true >> "$GITHUB_ENV";
else echo "::notice Not_Release";exit 1;fi

tmp=commit.tmp.txt
echo Auto Generated Release > $tmp
echo >> $tmp
echo "$body" >> $tmp