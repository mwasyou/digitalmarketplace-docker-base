VERSION := $(shell cat VERSION)
PY2VERSION := $(shell cat PY2VERSION)

define build-image
	docker pull digitalmarketplace/base
	docker build --cache-from digitalmarketplace/base -t digitalmarketplace/base -f base${BASE_IMAGE_SUFFIX}.docker .
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

.PHONY: build-all
build-all: build-py2 build-py3

.PHONY: build-py3
build-py3:
	$(eval export BUILD_VERSION=${VERSION})
	$(call build-image)

.PHONY: build-py2
build-py2:
	$(eval export BUILD_VERSION=${PY2VERSION})
	$(eval export BASE_IMAGE_SUFFIX=-py2)
	$(call build-image)

.PHONY: push-all
push-all: push-py2 push-py3

.PHONY: push-py3
push-py3:
	$(eval export BUILD_VERSION=${VERSION})
	$(call push-image)

.PHONY: push-py2
push-py2:
	$(eval export BUILD_VERSION=${PY2VERSION})
	$(call push-image)
