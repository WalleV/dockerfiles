FROM alpine
ARG HOME=/root
ARG GO_VERSION=1.11.5
ARG FRP_VERSION=0.27.0
ARG TEMP=$HOME/.golang/temp
ARG GOROOT_NEW=$HOME/.golang/go
ARG GOPATH=$HOME/.golang/path
ARG PATH=$PATH:$HOME/.golang/go/bin
ARG FRP_PATH=$GOPATH/src/github.com/fatedier/frp
ARG BUILD_DEPS=".build-deps build-base gcc git make bash g++ wget musl-dev go"

ARG GO_URL=https://github.com/golang/go/archive/go${GO_VERSION}.tar.gz

ENV MODULE=server


# China mirrors
# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN set -ex && \
    apk add --no-cache --virtual $BUILD_DEPS && \

    export \
            # set GOROOT_BOOTSTRAP such that we can actually build Go
    		GOROOT_BOOTSTRAP="$(go env GOROOT)" \
            # ... and set "cross-building" related vars to the installed system's values so that we create a build targeting the proper arch
            # (for example, if our build host is GOARCH=amd64, but our build env/image is GOARCH=386, our build needs GOARCH=386)
            GOOS="$(go env GOOS)" \
    		GOARCH="$(go env GOARCH)" \
    		GOHOSTOS="$(go env GOHOSTOS)" \
            GOHOSTARCH="$(go env GOHOSTARCH)" && \

    mkdir -p $TEMP && \

    wget -qO- $GO_URL | tar xvz -C $TEMP && \
    mv ${TEMP}/go-go$GO_VERSION $GOROOT_NEW && \

    cd $GOROOT_NEW/src && ./make.bash && \

    git clone https://github.com/fatedier/frp.git $FRP_PATH && \
    cd $FRP_PATH && \
    git checkout tags/v$FRP_VERSION && \
    make && \

    apk del $BUILD_DEPS && \

    mkdir /frp && \
    cp $FRP_PATH/bin/frp* /frp && \
    cp $FRP_PATH/conf/* /frp && \
    rm -rf $HOME/.golang

ADD entrypoint.sh /frp
RUN ["chmod", "+x", "/frp/entrypoint.sh"]
ENTRYPOINT ["/frp/entrypoint.sh"]
