#!/usr/bin/env bash

ROOT_DIR="/volume1/docker/kmcd"
ETAG_LOCATION="${ROOT_DIR}/mastodon.etag"

OLDETAG=$(cat $ETAG_LOCATION || echo "0")
ETAG=$(curl -I "${SERVER_ENDPOINT}/@sudorandom.rss" | grep etag)
if [ "$OLDETAG" != "$ETAG" ]
then
    docker run --rm --env-file=/volume1/docker/kmcd/env -v "${ROOT_DIR}/workspace:/usr/app/workspace" -v "${ROOT_DIR}/ssh:/root/.ssh" sudorandom/deploy.kmcd.dev:main make sync-mastodon
fi

echo $ETAG > $ETAG_LOCATION

docker run --rm --env-file=/volume1/docker/kmcd/env -v "${ROOT_DIR}/workspace:/usr/app/workspace" -v "${ROOT_DIR}/ssh:/root/.ssh" sudorandom/deploy.kmcd.dev:main make deploy
