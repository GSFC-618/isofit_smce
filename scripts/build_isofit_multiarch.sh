#!/bin/bash

cd isofit
echo $PWD
#CI_COMMIT_TAG=$(git describe --tags --abbrev=0)
CI_COMMIT_TAG=$(git tag -l --sort=-creatordate | head -n 1)
echo "Latest ISOFIT release: ${CI_COMMIT_TAG}"
cd ..
echo $PWD

# Create tag
CI_COMMIT_TAG_DOCKER="multiarch_"${CI_COMMIT_TAG}
echo "Docker ISOFIT tag: ${CI_COMMIT_TAG_DOCKER}"

echo ""
echo ""
echo "Building new ISOFIT image: ${CI_COMMIT_TAG_DOCKER}"
echo "************************************************************************************"
sleep 1

#docker buildx inspect --bootstrap

# Build the ISOFIT docker image without the embedded datasets
# Multi-arch version - what additional architectures should be included here?
#docker buildx build --push -t serbinsh/isofit_smce:multiarch --no-cache \
#--platform linux/amd64,linux/arm64 -f docker/Dockerfile_standalone .
docker buildx build --push -t serbinsh/isofit_smce:$CI_COMMIT_TAG_DOCKER --no-cache \
--platform linux/amd64,linux/arm64 -f docker/Dockerfile_standalone .

## EOF