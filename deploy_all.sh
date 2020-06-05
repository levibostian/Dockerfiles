#!/bin/bash

set -e
set -x
set -o pipefail 

docker push levibostian/fastlane:latest    
docker push levibostian/danger:latest     
docker push levibostian/pgdump-s3:latest   