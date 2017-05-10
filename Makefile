.PHONY: build
build:
	docker pull digitalmarketplace/base
	docker build --cache-from digitalmarketplace/base -t digitalmarketplace/base -f base.docker .
	docker build -t digitalmarketplace/base-api -f api.docker .
	docker build -t digitalmarketplace/base-frontend -f frontend.docker .

.PHONY: push
push:
	docker push digitalmarketplace/base
	docker push digitalmarketplace/base-api
	docker push digitalmarketplace/base-frontend
