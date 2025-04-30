#!/bin/bash

# Build the ISOFIT docker image without the embedded datasets
docker buildx build --push -t serbinsh/isofit_smce --no-cache \
--platform linux/amd64,linux/arm64 -f docker/Dockerfile .

