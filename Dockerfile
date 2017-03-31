FROM golang:1.8-alpine

RUN set -x \
    && apk add --no-cache \
    git \
    build-base \
    mysql-client \
    tar \
    gzip

ENV GOPATH /go
ENV APP_DIR ${GOPATH}/src/github.com

RUN set -x \
    && adduser -D -u 1000 go \
    && echo 'go:password' | chpasswd \
    && mkdir -p ${APP_DIR} \
    && chown -R go:go /go

WORKDIR ${APP_DIR}
USER go

RUN go get -u github.com/mattn/gom
RUN go get -u github.com/jteeuwen/go-bindata/...

EXPOSE 9090:9090
