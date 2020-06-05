#! /bin/sh

set -e
set -o pipefail

##### pgdump

# The official docs for pg_dump are readable. https://www.postgresql.org/docs/9.3/app-pgdump.html
# 

# example: 2020-06-04_19:02.dump
DUMP_FILENAME="$(date +%Y-%m-%d_%H:%M).dump"
DUMP_LOCATION="/home/dumps/$DUMP_FILENAME"

echo "Creating dump of ${POSTGRES_DATABASE} database from ${POSTGRES_HOST}..."

export PGPASSWORD=$POSTGRES_PASSWORD
pg_dump -Fc -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER $POSTGRES_DATABASE > "$DUMP_LOCATION"

#### upload 

if [ "${S3_ENDPOINT}" == "**None**" ]; then
  ENDPOINT=""
else
  ENDPOINT="--host=${S3_ENDPOINT}"
fi

S3_FULL_PATH="$S3_BUCKET_NAME$S3_BUCKET_PATH"
S3_FULL_FILE_PATH="$S3_FULL_PATH$DUMP_FILENAME"

echo "Uploading backup to $S3_FULL_FILE_PATH"

s3cmd --ssl "$ENDPOINT" "$S3_EXTRA_OPTIONS" --access_key="$S3_ACCESS_KEY" --secret_key="$S3_SECRET_KEY" put "$DUMP_LOCATION" s3://"$S3_FULL_PATH"

echo "Upload complete. Setting $S3_FULL_FILE_PATH file to be private."

s3cmd "$ENDPOINT" setacl s3://"$S3_FULL_FILE_PATH" --acl-private

echo "Success!"