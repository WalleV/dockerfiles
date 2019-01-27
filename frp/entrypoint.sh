#!/bin/sh

if [ "$MODULE"  = "server" ]; then
  /frp/frps -c /frp/frps.ini
else
  /frp/frpc -c /frp/frpc.ini
fi