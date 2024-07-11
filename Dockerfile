# syntax=docker/dockerfile:1

ARG VERSION=0.23.0

###
FROM alpine:3.20 AS builder
RUN apk add --no-cache bash file git make

ARG VERSION
ARG HOSTOS
ARG HOSTARCH

WORKDIR /app
# https://kind.sigs.k8s.io/docs/user/quick-start/#installation
RUN git clone https://github.com/kubernetes-sigs/kind.git /app
RUN git checkout -b v${VERSION} v${VERSION}

#
ENV VERSION=${VERSION}
ENV GOOS=${HOSTOS}
ENV GOARCH=${HOSTARCH}

RUN INSTALL_DIR=/egress make install

#
CMD [ "bash" ]
