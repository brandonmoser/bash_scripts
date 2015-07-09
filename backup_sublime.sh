#!/usr/bin/env bash

# This script should add all files from within the Sublime Text 3 configuration directory
# to a git commit and push them to github.com (origin)
echo "Checking Sublime Configuration for changes..."

RUN_DATE=$(date +"%Y%m%d_%H%M%S")
LOCATION="/dev/null"

# echo "Home: $HOME"
case "$(uname -s)" in
    "Darwin") #Mac OSX
        # echo "This is Mac OSX"
        LOCATION="$HOME/Library/Application\ Support/Sublime\ Text\ 3/"
        ;;
    "Linux")
        # echo "This is Linux"
        LOCATION="$HOME/.config/sublime-text-3/"
        ;;
esac

## Switch to the local location based upon OS
cd $LOCATION
# pwd

## Commit anything outstanding
if [ "$(git status -s)" != "" ]; then
    echo "Things to update and push to github"
    git add .
    echo "Committing everything"
    git commit -a -m "Update for $RUN_DATE"
fi

function check_github {
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u})
    BASE=$(git merge-base @ @{u})
}
check_github

if [ $LOCAL = $REMOTE ]; then
    echo "Nothing to do, all up-to-date"
else
    while [ "$LOCAL" != "$REMOTE" ];
    do
        echo "Local: $LOCAL"
        echo "Remote: $REMOTE"
        echo "Base: $BASE"
        if [ $LOCAL = $BASE ]; then
            echo "Need to pull"
            git pull --rebase
        elif [ $REMOTE = $BASE ]; then
            echo "Need to push"
            git push origin
        else
            echo "Diverged, exiting"
            LOCAL=$REMOTE
        fi
        check_github
    done
fi

exit 0