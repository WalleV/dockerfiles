#!/bin/sh
export FILE='/snell/snell-server.conf';
if [[ ! -f "$FILE" ]]
then
    echo "This is first run, ready to create config file"
    export PSK=$(openssl rand -base64 24)
    echo [snell-server] >> ${FILE}
    echo listen = 0.0.0.0:${LOCAL_PORT} >> ${FILE}
    echo psk = ${PSK} >> ${FILE}
    echo obfs = http >> ${FILE}
    echo PSK is: ${PSK}
fi

/snell/snell-server -c ${FILE}
