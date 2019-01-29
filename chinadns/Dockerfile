FROM alpine

ENV DNS_CN=119.29.29.29
ENV DNS=208.67.222.222:5353

ARG BUILD_DEPS=".build-deps build-base gcc git make bash g++ automake autoconf curl"

# China mirrors
# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN set -ex && \
        apk add --no-cache --virtual $BUILD_DEPS && \
    git clone https://github.com/shadowsocks/ChinaDNS.git /chinadns && \
    cd /chinadns && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    rm -rf /chinadns && \
    mkdir /chinadns && \
    cd /chinadns && \
    curl 'https://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > chnroute.txt && \
    apk del $BUILD_DEPS

ADD entrypoint.sh /chinadns
RUN chmod +x /chinadns/entrypoint.sh
ENTRYPOINT ["/chinadns/entrypoint.sh"]
