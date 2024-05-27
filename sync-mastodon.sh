#!/usr/bin/env bash

set -ex

pushd workspace/socialstore-me
    # update socialstore
    go run main.go

    # if there are updates, push new change to github
    if git status -s; then
        git add .
        git commit -m "Update database"
        git push origin main  
    else
        echo "no new changes from mastodon"
    fi
popd
