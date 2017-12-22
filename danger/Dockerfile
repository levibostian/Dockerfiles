FROM ruby:alpine
MAINTAINER Levi Bostian <levi.bostian@gmail.com> 

RUN apk add --update git
RUN gem install danger

ENV WORK_DIR="/danger" 

RUN danger --version

VOLUME ${WORK_DIR}
WORKDIR ${WORK_DIR}

ENTRYPOINT ["danger", "--fail-on-errors=true"]
