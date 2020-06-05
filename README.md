# Dockerfiles

Collection of Dockerfiles I have created to create images from. 

# Collection

### ci-testing

Image designed for running tests inside of it via a CI server. 

### nodedev

Image designed for running Nodejs applications inside of them for local development pursposes.

### fastlane 

Docker image that has Fastlane installed as well as a few other utilities. Used primarily with CircleCi to run Fastlane builds for deploying apps

## pgdump-s3

Run `pg_dump` to create a backup of a Postgres database and upload the dump to a S3 bucket. 