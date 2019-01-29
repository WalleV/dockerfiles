FROM alpine

ARG HOME=/root
ARG GOROOT=$HOME/.golang/go
ARG GOPATH=$HOME/.golang/path
ARG PATH=$PATH:$HOME/.golang/go/bin
ARG GOROOT_BOOTSTRAP=$HOME/.golang/go1.4
ENV MODULE=server

ARG BUILD_DEPS=".build-deps build-base gcc git make bash g++"

# China mirrors
# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN set -ex && \
    apk add --no-cache --virtual $BUILD_DEPS && \
    git clone https://github.com/golang/go.git $GOROOT && \
    cd $GOROOT/.. && \
    cp -r go go1.4 && \
    cd $GOROOT_BOOTSTRAP && \
    git checkout release-branch.go1.4 && \
    cd src && \
    ./make.bash && \
    cd $GOROOT && \
    git checkout release-branch.go1.11 && \
    cd src && \
    ./make.bash && \
    export PATH=$PATH:$HOME/.golang/go/bin && \
    git clone https://github.com/fatedier/frp.git $GOPATH/src/github.com/fatedier/frp && \
    cd $GOPATH/src/github.com/fatedier/frp && \
    make && \
    apk del $BUILD_DEPS && \
    mkdir /frp && \
    cp $GOPATH/src/github.com/fatedier/frp/bin/frp* /frp && \
    cp $GOPATH/src/github.com/fatedier/frp/conf/* /frp && \
    rm -rf $HOME/.golang

ADD entrypoint.sh /frp
RUN ["chmod", "+x", "/frp/entrypoint.sh"]
ENTRYPOINT ["/frp/entrypoint.sh"]
