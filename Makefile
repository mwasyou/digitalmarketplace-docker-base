.PHONY: build
build:
	docker build -t digitalmarketplace/base -f base.docker .
	docker build -t digitalmarketplace/base-api -f api.docker .
	docker build -t digitalmarketplace/base-frontend -f api.docker .

.PHONY: push
push:
	docker push digitalmarketplace/base
	docker push digitalmarketplace/base-api
	docker push digitalmarketplace/base-frontend
