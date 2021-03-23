#!/bin/bash

source="."
destination="."
projects="latest"

while getopts s:d:la flag
do
    case "${flag}" in
        s) source=${OPTARG};;
        d) destination=${OPTARG};;
		l) projects="latest";;
		a) projects="all" ;;
    esac
done

all_projects=""

for i in $(find $source -type f -name '*.RPP' | sed -r 's|/[^/]+$||' |sort |uniq); do
    
	if [ $projects = "latest" ]; then
		result=`ls -t $i/*.RPP | head -1`
	    all_projects="$all_projects\n$result"
	else
		result=`ls -1 $i/*.RPP`
	    all_projects="$all_projects\n$result"
	fi
done

project_list=`echo -e "$all_projects"`

while IFS= read -r line; do

	if [ ! -z "$line" ]
	then
	      echo "Rendering: $line"
	      /Applications/REAPER64.app/Contents/MacOS/REAPER -renderproject "$line"
	fi

done <<< "$project_list"
