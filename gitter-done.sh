#!/bin/bash

# Config
# ##############################

OCCURRENCES=5
OUT_OF=7
COMMIT_MESSAGES=("Minor changes" "Changed configuration"  "Bug fixes"  "Resolved caching issue"  "Bug fixed."  "Small changes"  "Added documentation."  "Organized code"  "Rewrote section")

# Logic
# ##############################

(( decision = RANDOM % OUT_OF + 1 ))
if (( decision <= OCCURRENCES )); then

	messages_length=${#COMMIT_MESSAGES[@]} 

	script_dir="$( cd "$( /usr/bin/dirname "$0" )" && pwd )"
	script_name=`basename $0`

	random_index=$RANDOM
	let "random_index %= $messages_length"

	cp $script_dir/$script_name $script_dir/$script_name.tmp
	sed '$ d' $script_dir/$script_name.tmp > $script_dir/$script_name
	rm -f $script_dir/$script_name.tmp

	echo "#$RANDOM $RANDOM $RANDOM $RANDOM" >> $script_dir/$script_name

	cd $script_dir
	git add -A
	git commit -m "${COMMIT_MESSAGES[$random_index]}"
	git push origin master
fi

#24582 11866 10615 24597
