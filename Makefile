.PHONY: update-socialstore-me

workspace/socialstore-me:
	git clone --depth=1 -- git@github.com:sudorandom/socialstore-me.git workspace/socialstore-me

update-socialstore-me: workspace/socialstore-me
	cd workspace/socialstore-me; git fetch origin; git reset --hard origin/main

workspace/kmcd.dev:
	git clone --depth=1 -- git@github.com:sudorandom/kmcd.dev.git workspace/kmcd.dev

update-kmcd.dev: workspace/kmcd.dev
	cd workspace/kmcd.dev; git fetch origin; git reset --hard origin/main

copy-from-mastodon: update-socialstore-me
	@mkdir -p workspace/kmcd.dev/assets/mastodon workspace/kmcd.dev/data/mastodon
	cp -r workspace/socialstore-me/media/* workspace/kmcd.dev/assets/mastodon/
	cp -r workspace/socialstore-me/statuses/* workspace/kmcd.dev/data/mastodon/

deploy: update-kmcd.dev copy-from-mastodon
	./deploy.sh

sync-mastodon: update-socialstore-me
	./sync-mastodon.sh
