#!/bin/bash
tag=community-7.2.4
image="registry.0x42.in/library/docker/couchbase"

docker buildx build --push --platform linux/amd64 -t ${image}:${tag}-amd64 .
docker buildx build --push --platform linux/arm64 -t ${image}:${tag}-arm64 .
docker buildx imagetools create -t ${image}:${tag} \
    ${image}:${tag}-amd64 \
    ${image}:${tag}-arm64
