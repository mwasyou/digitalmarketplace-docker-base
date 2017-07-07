VERSION := $(shell cat VERSION)
PY2VERSION := $(shell cat PY2VERSION)

.PHONY: build-all
build-all: build-py3 build-py2

.PHONY: build-py3
build-py3:
	docker pull digitalmarketplace/base
	docker build --cache-from digitalmarketplace/base -t digitalmarketplace/base -f base.docker .
	docker tag digitalmarketplace/base digitalmarketplace/base:${VERSION}

	docker build -t digitalmarketplace/base-api -f api.docker .
	docker tag digitalmarketplace/base-api digitalmarketplace/base-api:${VERSION}

	docker build -t digitalmarketplace/base-frontend -f frontend.docker .
	docker tag digitalmarketplace/base-frontend digitalmarketplace/base-frontend:${VERSION}

.PHONY: build-py2
build-py2:
	docker pull digitalmarketplace/base
	docker build --cache-from digitalmarketplace/base -t digitalmarketplace/base -f base-py2.docker .
	docker tag digitalmarketplace/base digitalmarketplace/base:${PY2VERSION}

	docker build -t digitalmarketplace/base-api -f api.docker .
	docker tag digitalmarketplace/base-api digitalmarketplace/base-api:${PY2VERSION}

	docker build -t digitalmarketplace/base-frontend -f frontend.docker .
	docker tag digitalmarketplace/base-frontend digitalmarketplace/base-frontend:${PY2VERSION}

.PHONY: push-all
push-all: push-py3 push-py2

.PHONY: push-py3
push-py3:
	docker push digitalmarketplace/base:${VERSION}
	docker push digitalmarketplace/base:latest

	docker push digitalmarketplace/base-api:${VERSION}
	docker push digitalmarketplace/base-api:latest

	docker push digitalmarketplace/base-frontend:${VERSION}
	docker push digitalmarketplace/base-frontend:latest

.PHONY: push-py2
push-py2:
	docker push digitalmarketplace/base:${PY2VERSION}
	docker push digitalmarketplace/base:latest

	docker push digitalmarketplace/base-api:${PY2VERSION}
	docker push digitalmarketplace/base-api:latest

	docker push digitalmarketplace/base-frontend:${PY2VERSION}
	docker push digitalmarketplace/base-frontend:latest
