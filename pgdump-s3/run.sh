#! /bin/sh

set -e
set -o pipefail

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

S3_FULL_FILE_PATH="$S3_BUCKET_NAME$S3_BUCKET_PATH"

echo "Uploading backup to $S3_FULL_FILE_PATH"

s3cmd --ssl "$ENDPOINT" "$S3_EXTRA_OPTIONS" --access_key="$S3_ACCESS_KEY" --secret_key="$S3_SECRET_KEY" put "$DUMP_LOCATION" s3://"$S3_FULL_FILE_PATH"
