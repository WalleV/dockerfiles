#!/bin/sh

if [ "$MODULE" = "ss-local" ];then
    $MODULE -s $SERVER_ADDR \
            -p $SERVER_PORT \
            -k $PASSWORD \
            -b $LOCAL_ADDR \
            -l $LOCAL_PORT \
            -m $METHOD \
            -t $TIMEOUT \
            --fast-open  \
            -a $USER \
            --plugin v2ray-plugin \
            --plugin-opts "host=intl.aliyun.com" \
            $ARGS

else
   $MODULE  -s $SERVER_ADDR \
            -p $SERVER_PORT \
            -k ${PASSWORD:-$(hostname)} \
            -m $METHOD \
            -t $TIMEOUT \
            --fast-open \
            -d $DNS_ADDR \
            -d $DNS_ADDR_2 \
            -u \
            -a $USER \
            --plugin v2ray-plugin \
            --plugin-opts "server;host=intl.aliyun.com" \
            $ARGS
fi
