#!/bin/bash

set -e
set -x
set -o pipefail 

docker push levibostian/pgdump-s3:latest   
docker push levibostian/debian10-ansible-testing:latest