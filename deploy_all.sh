#!/bin/bash

set -e
set -o pipefail 

docker login -u $DOCKER_USER -p $DOCKER_PASS
docker push levibostian/fastlane:latest    
docker push levibostian/danger:latest     
docker push levibostian/pgdump-s3:latest   