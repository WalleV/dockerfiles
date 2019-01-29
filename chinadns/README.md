# ChinaDNS build on docker

This project is base [ChinaDNS](https://github.com/shadowsocks/ChinaDNS), build on docker.


### How to use
```bash
docker pull coolcoffee/chinadns:beta

docker run --name dns -p 53:53/udp -p 53:53/tcp -d chinadns:beta
```

