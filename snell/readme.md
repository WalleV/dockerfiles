command:
``` bash
# run
docker run --name snell2 -p 80:80 coolcoffee/snell:snell-v2.0.0

#get psk
docker logs snell2 | grep PSK
```