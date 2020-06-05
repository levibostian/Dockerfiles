#!/bin/bash

set -e
set -o pipefail 

docker build -t levibostian/fastlane:latest fastlane   
docker build -t levibostian/danger:latest danger
docker build -t levibostian/pgdump-s3:latest pgdump-s3 