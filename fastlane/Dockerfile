FROM ruby:alpine

MAINTAINER Levi Bostian levi.bostian@gmail.com
# Inspired from: https://hub.docker.com/r/chrsep/fastlane-docker/

RUN apk add --update g++ make git

RUN gem install fastlane
RUN fastlane -v
