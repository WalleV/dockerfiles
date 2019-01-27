# Frp build on docker

#### install
```
docker pull coolcoffee/frp
```

## frp server
#### frps.ini
```
[common]                                                                                bind_port = 7000
vhost_http_port = 7080

dashboard_port = 7500
dashboard_user = <youruser>
dashboard_pwd = <yourpassword>

token = <any str>
subdomain_host = <frp.xxx.com>
```

#### server run

```
docker run -d --name frp-server \
           -p 7000:7000/tcp \
           -p 7000:7000/udp \
           -p 7080:7080/udp \
           -p 7500:7500/tcp \
           -v <config path>/frps.ini:/frp/frps.ini \
           coolcoffee/frp
```

## frp client

### frpc.ini
```
[common]
server_addr = <your server address>
server_port = 7000
token = <any str>

[web]
type = http
local_ip = <192.168.1.1>
local_port = 80
remote_port = 6080
subdomain = <vm>
```

### client run 
```
docker run -d --name frp-test \
           -v <config path>/frp/frpc.ini:/frp/frpc.ini \
           -e MODULE=client \
           --restart always \
           coolcoffee/frp
```

When you use configuration, now you can open your browser: http://vm.frp.xxx.com:7080

more configuration you can see: [https://github.com/fatedier/frp](https://github.com/fatedier/frp)