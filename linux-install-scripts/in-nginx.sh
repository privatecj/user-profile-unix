#!/bin/bash

# https://phoenixnap.com/kb/how-to-install-nginx-on-ubuntu-20-04
# https://stackoverflow.com/questions/58626546/shell-script-to-make-site-https-using-certbot-and-nginx
# https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/

sudo apt-get -y install nginx certbot python3-certbot-nginx

sudo rm /etc/nginx/sites-enabled/cloud.conf

sudo certbot run -n --nginx --agree-tos --expand -m srikrishna.cj@gmail.com --redirect -d test.cjcj.in
sudo certbot run -n --nginx --agree-tos --expand -m srikrishna.cj@gmail.com --redirect -d maven.cjcj.in

echo >> /
echo '
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
	worker_connections 768;
}

http {
    client_max_body_size 100M;
	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;
	keepalive_timeout 65;
	types_hash_max_size 2048;
	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
	ssl_prefer_server_ciphers on;

	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	gzip on;

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;
}
' > /tmp/ng.conf
sudo cp -f /tmp/ng.conf /etc/nginx/nginx.conf


echo >> /tmp/cloud.conf
echo '
# Docker Test Web Application
server {
    listen 80;
    listen [::]:80;
    listen 443 ssl; # managed by Certbot
    root /var/www/html;
    server_name  test.cjcj.in;
    
    location / {
    	proxy_pass http://localhost:8888;
    }

    # RSA certificate
    ssl_certificate /etc/letsencrypt/live/test.cjcj.in/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/test.cjcj.in/privkey.pem; # managed by Certbot

    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot

    # Redirect non-https traffic to https
    if ($scheme != "https") {
        return 301 https://$host$request_uri;
    } # managed by Certbot
}


# Nexus Maven Repository
server {
    listen 80;
    listen [::]:80;
    listen 443 ssl; # managed by Certbot
    root /var/www/html;
    server_name  maven.cjcj.in;
    
    location / {
    	proxy_pass http://localhost:8090;
    }

    # RSA certificate
    ssl_certificate /etc/letsencrypt/live/maven.cjcj.in/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/maven.cjcj.in/privkey.pem; # managed by Certbot

    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot

    # Redirect non-https traffic to https
    if ($scheme != "https") {
        return 301 https://$host$request_uri;
    } # managed by Certbot
}
' > /tmp/cloud.conf
sudo cp -f /tmp/cloud.conf /etc/nginx/sites-enabled/cloud.conf

sudo nginx -s reload
