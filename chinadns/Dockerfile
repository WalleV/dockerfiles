FROM centos

ENV DNS_CN=119.29.29.29
ENV DNS=208.67.222.222:5353

# build tools
RUN yum update -y && \
    yum install git epel-release gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto c-ares-devel libev-devel libsodium-devel mbedtls-devel -y && \
    git clone https://github.com/shadowsocks/ChinaDNS.git /chinadns && \
    cd /chinadns && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    yum remove -y git epel-release gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto c-ares-devel libev-devel libsodium-devel mbedtls-devel -y


RUN curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > chnroute.txt
ADD entrypoint.sh /chinadns
RUN chmod +x /chinadns/entrypoint.sh
ENTRYPOINT ["/chinadns/entrypoint.sh"]
