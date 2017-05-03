.PHONY: build
build:
	docker build --pull -t digitalmarketplace/base -f base.docker .
	docker build --pull -t digitalmarketplace/base-api -f api.docker .
	docker build --pull -t digitalmarketplace/base-frontend -f frontend.docker .

.PHONY: push
push:
	docker push digitalmarketplace/base
	docker push digitalmarketplace/base-api
	docker push digitalmarketplace/base-frontend
