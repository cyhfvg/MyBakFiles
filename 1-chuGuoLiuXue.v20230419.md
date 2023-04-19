# 出国留学

[不良林视频 ref](https://www.youtube.com/watch?v=s90feRmdr9A&list=PLD4NhM_IqBXWgPipuLewPNWzQam6g0xZ_&index=7)
[不良林教程 ref1](https://bulianglin.com/g/node/)
[不良林教程 ref2](https://telegra.ph/node-03-10)

## backup

1. bwg vps
1. 设置域名解析
1. install OS ubuntu
1. unminimize
1. update system

    ```bash
    apt update
    ```
1. bbr (bwg ubuntu ignore)

    ```bash
    #启用 BBR TCP 拥塞控制算法
    echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
    sysctl -p
    ```

1. install x-ui

    ```bash
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
    ```

1. install nginx

    ```bash
    apt install nginx -y
    ```

1. install acme.sh

    ```bash
    # install
    curl https://get.acme.sh | sh

    # create link
    ln -s  /root/.acme.sh/acme.sh /usr/local/bin/acme.sh

    #切换CA机构
    acme.sh --set-default-ca --server letsencrypt
    ```

1. 申请证书

    ```bash
    # changeme: 你的域名
    acme.sh  --issue -d 你的域名 -k ec-256 --webroot  /var/www/html
    ```

1. 安装证书

    ```bash
    # changeme: 你的域名
    acme.sh --install-cert -d 你的域名 --ecc --key-file /etc/x-ui/server.key  --fullchain-file /etc/x-ui/server.crt --reloadcmd "systemctl force-reload nginx"
    ```

1. 寻找适合的伪装站

    google, intext:登录 Cloudreve ; 个人网盘符合单节点大流量特征

1. 写nginx 配置

    ```nginx /etc/nginx/nginx.conf
    user www-data;
    worker_processes auto;
    pid /run/nginx.pid;
    include /etc/nginx/modules-enabled/*.conf;

    events {
        worker_connections 1024;
    }

    http {
        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;
        gzip on;

        server {
            listen 443 ssl;
            # changeme: 你的域名
            server_name XXXX.XXXX.XXX;  #你的域名
            ssl_certificate       /etc/x-ui/server.crt;  #证书位置
            ssl_certificate_key   /etc/x-ui/server.key; #私钥位置
            
            ssl_session_timeout 1d;
            ssl_session_cache shared:MozSSL:10m;
            ssl_session_tickets off;
            ssl_protocols    TLSv1.2 TLSv1.3;
            ssl_prefer_server_ciphers off;

            location / {
                # changeme: google 的伪装网站
                proxy_pass https://www.fan-2000.com; #伪装网址
                proxy_redirect off;
                proxy_ssl_server_name on;
                sub_filter_once off;
                # changeme: google 的伪装网站
                sub_filter "www.fan-2000.com" $server_name;
                # changeme: google 的伪装网站
                proxy_set_header Host "www.fan-2000.com";
                proxy_set_header Referer $http_referer;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header User-Agent $http_user_agent;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto https;
                proxy_set_header Accept-Encoding "";
                proxy_set_header Accept-Language "zh-CN";
            }


            # x-ui 面板中添加的节点
            location /f9af2f93-05b1-4986-9bcc-57b3a981a386 {   #分流路径
                proxy_redirect off;
                # changeme: 节点的端口
                proxy_pass http://127.0.0.1:50500; #Xray端口
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            }

            # x-ui 面板设置
            location /f9af2f93-05b1-4986-9bcc-57b3a981a386-xui {   #xui路径
                proxy_redirect off;
                # changeme: x-ui 服务监听端口
                proxy_pass http://127.0.0.1:26000;  #xui监听端口
                proxy_http_version 1.1;
                proxy_set_header Host $host;
            }
        }

        server {
            listen 80;
            location /.well-known/ {
                   root /var/www/html;
                }
            location / {
                    rewrite ^(.*)$ https://$host$1 permanent;
                }
        }
    }
    ```

1. reload nginx

    ```bash
    systemctl reload nginx
    ```
