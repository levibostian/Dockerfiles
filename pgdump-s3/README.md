# pgdump-s3

Run `pg_dump` to create a backup of a Postgres database and upload the dump to a S3 bucket. 

Goals of this Dockerfile
* Stay as slim as possible. 
* Only run `pg_dump` and then upload to S3, one time. No scheduler/cronjob. 
* Be compatible with all types of S3 like storage. AWS, DigitalOcean, and others. 
* All you need to use this image is provide environment variables. 
* No need for error checking or anything like that. The bash scripts are meant to be small for reading and maintaining. It's assumed that as long as you provide all of the environment variables, it should work good. 
* This Dockerfile may be a little bias towards the way I prefer to run backups and store them. Read the docs here and the source code to find out for yourself if it will work for you. 

# Getting started

To use this Docker image, all you need to do is set some environment variables. 

```
POSTGRES_DATABASE - name of your database to backup
POSTGRES_HOST - host of where your database is located 
POSTGRES_PORT - optional, default to 5432
POSTGRES_USER - username of your postgres role to login to the database
POSTGRES_PASSWORD - password of your postgres role to login to the database
S3_ACCESS_KEY - S3 access key. your s3 provider provides this to you. 
S3_SECRET_KEY - S3 secret key. your s3 provider provides this to you. 
S3_BUCKET_NAME - name of your S3 bucket
S3_BUCKET_PATH - full path inside of your bucket you would like to store the file. (Example: /backups/) Default is: /
S3_EXTRA_OPTIONS - optional, provide extra arguments to s3cmd. The instructions in this doc cover some places you might need this. Default is: '' 
```

# S3 providers 

Below I have instructions for some S3 providers. I may be missing the provider you use.

## AWS S3

* Create an IAM user account to get an access key and secret. Make sure this IAM account has permissions to upload files to the bucket! Populate `S3_ACCESS_KEY` and `S3_SECRET_KEY` with this information. 
* Use the name of your bucket for `S3_BUCKET_NAME` environment variable. 
* Set the `S3_REGION` value. Default to `us-west-1`

## DigitalOcean spaces

*Note:* All instructions taken from [the official doc](https://www.digitalocean.com/docs/spaces/resources/s3cmd/)

* Create an [access key pair (name and key)](https://www.digitalocean.com/docs/spaces/how-to/manage-access/#access-keys) for your space. Populate `S3_ACCESS_KEY` and `S3_SECRET_KEY` with this information. 
* Use value `nyc3.digitaloceanspaces.com` for `S3_ENDPOINT` environment variable. 
* Use the name of your space for `S3_BUCKET_NAME` environment variable. 
* Use value `--host-bucket=%(bucket)s.nyc3.digitaloceanspaces.com` for `$S3_EXTRA_OPTIONS` environment variable. 
