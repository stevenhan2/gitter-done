#!/bin/bash

# Config
# ##############################

OCCURRENCES=4
OUT_OF=7
COMMIT_MESSAGES=("Minor changes" "Changed configuration"  "Bug fixes"  "Resolved caching issue"  "Bug fixed."  "Small changes"  "Added documentation."  "Organized code"  "Rewrote section")
SSH_KEY=/root/.ssh/git_rsa

# Logic
# ##############################

(( decision = RANDOM % OUT_OF + 1 ))
if (( decision <= OCCURRENCES )); then
        eval `ssh-agent`
        ssh-add $SSH_KEY

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
exit 0

#16892 7016 24512 20597
