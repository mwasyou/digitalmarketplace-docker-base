VERSION := $(shell cat VERSION)

define build-image
	docker pull digitalmarketplace/base
	docker build --cache-from digitalmarketplace/base -t digitalmarketplace/base -f base.docker .
	docker tag digitalmarketplace/base digitalmarketplace/base:${BUILD_VERSION}

	docker build -t digitalmarketplace/base-api -f api.docker .
	docker tag digitalmarketplace/base-api digitalmarketplace/base-api:${BUILD_VERSION}

	docker build -t digitalmarketplace/base-frontend -f frontend.docker .
	docker tag digitalmarketplace/base-frontend digitalmarketplace/base-frontend:${BUILD_VERSION}
endef

define push-image
	docker push digitalmarketplace/base:${BUILD_VERSION}
	if [ "$${BUILD_VERSION:0:1}" -ne "1" ]; then docker push digitalmarketplace/base:latest; fi

	docker push digitalmarketplace/base-api:${BUILD_VERSION}
	if [ "$${BUILD_VERSION:0:1}" -ne "1" ]; then docker push digitalmarketplace/base-api:latest; fi

	docker push digitalmarketplace/base-frontend:${BUILD_VERSION}
	if [ "$${BUILD_VERSION:0:1}" -ne "1" ]; then docker push digitalmarketplace/base-frontend:latest; fi
endef

.PHONY: build
build:
	$(eval export BUILD_VERSION=${VERSION})
	$(call build-image)

.PHONY: push
push:
	$(eval export BUILD_VERSION=${VERSION})
	$(call push-image)
