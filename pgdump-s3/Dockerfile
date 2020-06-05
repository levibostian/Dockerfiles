FROM alpine:3

LABEL maintainer="Levi Bostian levi.bostian@gmail.com" 
# Inspired from: https://github.com/schickling/dockerfiles/tree/master/postgres-backup-s3

ADD install.sh install.sh
RUN sh install.sh && rm install.sh && mkdir -p /home/dumps

ENV POSTGRES_DATABASE **None**
ENV POSTGRES_HOST **None**
ENV POSTGRES_PORT 5432
ENV POSTGRES_USER **None**
ENV POSTGRES_PASSWORD **None**
ENV S3_ACCESS_KEY **None**
ENV S3_SECRET_KEY **None**
ENV S3_BUCKET_NAME **None**
ENV S3_REGION us-west-1
ENV S3_ENDPOINT **None**
ENV S3_BUCKET_PATH /
ENV S3_EXTRA_OPTIONS ''

ADD run.sh run.sh

CMD ["run", "run.sh"]