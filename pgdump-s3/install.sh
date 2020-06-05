#! /bin/sh

# exit if a command fails
set -e

apk update

# install pg_dump
apk add postgresql

# install s3 tools. pypi currently has up-to-date releases with GitHub of the project. 
apk add py-pip && pip install s3cmd 

# cleanup
rm -rf /var/cache/apk/*