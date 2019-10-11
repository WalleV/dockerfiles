FROM golang:1.10.8-alpine as builder

ARG HOME=/root
ARG FRP_VERSION=0.29.0
ARG GOPATH=$HOME/.golang/path
ARG PATH=$PATH:$HOME/.golang/go/bin
ARG FRP_PATH=$GOPATH/src/github.com/fatedier

ARG BUILD_DEPS="build-base gcc git make bash g++ wget musl-dev"
ARG FRP_SOURCE_URL=https://github.com/fatedier/frp/archive/v${FRP_VERSION}.tar.gz

# China mirrors
# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN set -ex && \

    mkdir ~/.golang && \

    apk add --no-cache --virtual $BUILD_DEPS && \
    apk add --no-cache libc6-compat && \

    mkdir -p ${FRP_PATH} && \
    wget -qO- $FRP_SOURCE_URL | tar zxf - -C ${FRP_PATH} && \
    mv ${FRP_PATH}/frp-${FRP_VERSION} ${FRP_PATH}/frp && \
    cd $FRP_PATH/frp && \

    make && \
    mkdir /frp && \

    cp -r $FRP_PATH/frp/bin/frp* /frp && \
    cp -r $FRP_PATH/frp/conf/* /frp

FROM alpine
COPY --from=builder /frp /frp
ENV MODULE=server

ADD entrypoint.sh /frp
RUN ["chmod", "+x", "/frp/entrypoint.sh"]
ENTRYPOINT ["/frp/entrypoint.sh"]
