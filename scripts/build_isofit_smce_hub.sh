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
echo "Build, tag, and push new ISOFIT image: ${CI_COMMIT_TAG_DOCKER}"
echo "************************************************************************************"
sleep 1

# Build the ISOFIT docker image without the embedded datasets
#docker buildx build --push -t serbinsh/isofit_smce:$CI_COMMIT_TAG_DOCKER --no-cache \
#--platform linux/amd64 -f docker/Dockerfile_standalone_smce .

# Setup AWS
#aws-mfa airborne # Have to run this beforehand. Need to make this something that runs as needed
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/u1d0n1w0

# Short-term hack - ignoring versioning and using "latest" as the tag to match smce deployment assumptions
#docker buildx create --name multibuilder --use
#docker buildx create --use

docker buildx build --push -t public.ecr.aws/u1d0n1w0/isofit-test:latest --no-cache \
--platform linux/amd64 -f docker/Dockerfile_smce_hub .

#echo ""
#echo ""
#echo "Tag the new ISOFIT image"
#echo "************************************************************************************"
#sleep 1
# After the build completes, tag your image so you can push the image to this repository:
#docker tag isofit-test:latest public.ecr.aws/u1d0n1w0/isofit-test:latest

#echo ""
#echo ""
#echo "Push the new ISOFIT image to the AWS repo"
#echo "************************************************************************************"
#sleep 1
# Run the following command to push this image to your newly created AWS repository:
#docker push public.ecr.aws/u1d0n1w0/isofit-test:latest

## EOF