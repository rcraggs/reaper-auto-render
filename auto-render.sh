#!/bin/bash

function render {

	TEMP=$(mktemp /tmp/tmp.XXXXXXXX)	
	cp "$1" "$TEMP.RPP"

	if [ ! -z "$preview" ]
	then
		sed -i.bak 's/RENDER_RANGE.*/RENDER_RANGE 0 0 30 16 1000/' "$TEMP.RPP"
	fi

	/Applications/REAPER64.app/Contents/MacOS/REAPER -renderproject "$TEMP.RPP"
}

source="."
destination="."
projects="latest"
preview=""

while getopts s:d:lap flag
do
    case "${flag}" in
        s) source=${OPTARG};;
        d) destination=${OPTARG};;
		l) projects="latest";;
		a) projects="all" ;;
		p) preview="true" ;;
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
	      render "$line"
	fi

done <<< "$project_list"
