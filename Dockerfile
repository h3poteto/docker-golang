FROM golang:1.15.1-alpine3.12

RUN set -x \
    && apk add --no-cache \
    git \
    build-base \
    mysql-client \
    tar \
    gzip \
    curl

ENV GOPATH /go
ENV APP_DIR ${GOPATH}/src/github.com

RUN set -x \
    && adduser -D -u 1000 go \
    && echo 'go:password' | chpasswd \
    && mkdir -p ${APP_DIR} \
    && chown -R go:go /go

WORKDIR ${APP_DIR}
USER go

RUN set -x \
    && go get -u github.com/jessevdk/go-assets \
    && go get -u github.com/jessevdk/go-assets-builder \
    && go get -u bitbucket.org/liamstask/goose/cmd/goose \
    && go get -u github.com/onsi/ginkgo/ginkgo \
    && go get -u github.com/onsi/gomega
