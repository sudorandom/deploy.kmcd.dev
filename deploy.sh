#!/usr/bin/env bash

set -ex

pushd workspace/kmcd.dev
    # Normal site
    make build
    if diff --exclude=pagefind --exclude=mastodon -q -r live live.old; then
        echo "no changes detected, do nothing"
    else
        echo "changes detected!"
        npx -y wrangler pages deploy --project-name=kmcd-dev ./live
    fi
    rm -rf live.old; cp -r live live.old

    # Future site
    make build-future
    if diff -q -r --exclude=pagefind --exclude=mastodon future future.old; then
        echo "no changes detected, do nothing"
    else
        echo "changes detected!"
        npx -y wrangler pages deploy --project-name=kmcd-dev-future ./future
    fi
    rm -rf future.old; cp -r future future.old
popd