#!/bin/bash

set -e
set -x
set -o pipefail 

docker build -t levibostian/pgdump-s3:latest pgdump-s3 