container_registry := quay.io/nordstrom
container_name := vault
vault_version := 0.6.0
vault_sha256 := 283b4f591da8a4bf92067bf9ff5b70249f20705cc963bea96ecaf032911f27c2
container_release := $(vault_version)

.PHONY: build/image tag/image push/image

build/image:
	docker build \
		--build-arg http_proxy=http://webproxy.nordstrom.net:8181 \
		--build-arg https_proxy=http://webproxy.nordstrom.net:8181 \
		--build-arg VAULT_VERSION=$(vault_version) \
		--build-arg VAULT_SHA256=$(vault_sha256) \
		-t $(container_name) .

tag/image: build/image
	docker tag $(container_name) $(container_registry)/$(container_name):$(container_release)

push/image: tag/image
	docker push $(container_registry)/$(container_name):$(container_release)
