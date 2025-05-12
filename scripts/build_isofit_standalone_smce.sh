#!/bin/bash

cd isofit
echo $PWD
CI_COMMIT_TAG=$(git describe --tags --abbrev=0)
echo "Latest ISOFIT release: ${CI_COMMIT_TAG}"
cd ..
echo $PWD

# Create tag
CI_COMMIT_TAG_DOCKER="smce_"${CI_COMMIT_TAG}
echo "Docker ISOFIT tag: ${CI_COMMIT_TAG_DOCKER}"

echo ""
echo ""
echo "Building new ISOFIT image: ${CI_COMMIT_TAG_DOCKER}"
echo "************************************************************************************"
sleep 1

# Build the ISOFIT docker image without the embedded datasets
docker buildx build --push -t serbinsh/isofit_smce:$CI_COMMIT_TAG_DOCKER --no-cache \
--platform linux/amd64 -f docker/Dockerfile_standalone_smce .

## EOF