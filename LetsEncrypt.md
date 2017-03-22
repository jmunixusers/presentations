# Let's Encrypt Introduction

This will assume that you have a server on which you are able to
successfully run commands as the root user, either through `sudo` or by
signing in to the root account. It also assumes that you have Apache
installed and are running Ubuntu 16.04. If this does not match your
configuration, you can probably modify this document to work for you by
reading the [Certbot](https://certbot.eff.org) webpage and entering your
configuration. The end of this document does include some sample
configurations for nginx.

## Apache

### Installing the Apache plugin for Certbot

    # apt install python-letsencrypt-apache

### Preparing Apache

You need to have some Apache modules enabled ahead of time.

    # a2enmod ssl
    # a2enmod rewrite
    # systemctl reload apache2

### Running certbox

This is super easy.

    # letsencrypt --apache

Choose the "secure" option and all HTTP traffic will be redirected to HTTPS.

### Checking it worked

Try to access your site over HTTPS. If it works, you have successfully
configured Let's Encrypt.

### Setting up automatic renewals

The certbot webpage recommends checking for renewals twice daily at a random
minute within the hour. As part of the renewal process you will need to run
the renewal command and then reload your Apache configs.

#### Preparation

Run:

    # letsencrypt renew --dry-run --agree-tos

This will do a dry-run of the renewal process and will not touch your
certificates. It paves the way for renewal in the future.

#### Automating

To automate the process, you can either modify your crontab or add a systemd
timer. For simplicity, we will just do a crontab entry.

Execute:

    # vim /etc/crontab

And add the following:

    46 4,19 * * * root letsencrypt renew --quiet && systemctl reload apache2

Replace 46, 4, and 19 on that line with your own numbers. The 46 is the
random minute within the two hours (4 and 19) to run.

### Congratulations

You have successfully set up Let's Encrypt for Apache on Ubuntu 16.04.a

## Nginx

This assumes that you have successfully followed the certbot instructions and
that you have received your certificates. You will need to replace
`domain.tld` with your domain and potentially adjust some paths as
necessary.

### Generate a DH group

    # openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

### SSL Params

Place the following text in `/etc/nginx/snippets/ssl-params.conf`

    # Adapted from https://cipherli.st/
    # and https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html

    # Add more protocols here as you wish
    ssl_protocols TLSv1.2;
    ssl_prefer_server_ciphers on;
    ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256';
    ssl_ecdh_curve secp384r1;
    ssl_session_timeout 1d;
    ssl_session_cache shared:SSL:50m;
    ssl_session_tickets off;
    ssl_stapling on;
    ssl_stapling_verify on;
    resolver 8.8.8.8 8.8.4.4 valid=300s;
    resolver_timeout 5s;
    # Disable preloading HSTS for now.  You can use the commented out header line that includes
    # the "preload" directive if you understand the implications.
    #add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
    #add_header Strict-Transport-Security "max-age=63072000; includeSubdomains";
    add_header Strict-Transport-Security "max-age=63072000";
    add_header X-Frame-Options DENY;
    add_header X-Content-Type-Options nosniff;

    ssl_dhparam /etc/ssl/certs/dhparam.pem;

Add more entries to the ssl\_protocols line as necessary. By default, this will
only support TLSv1.2.

### SSL/TLS Certificate

Place the following text in `/etc/nginx/snippets/ssl-domain.tld.conf`

    ssl_certificate /etc/letsencrypt/live/domain.tld-0001/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/domain.tld-0001/privkey.pem

This will tell nginx where to find your certs.

### Site SSL/TLS configuration

In the file where you have the `server` blocks for your site, replace the
content with the following:

    # Adapted from:
    #    https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-16-04

    # Redirects non-https to https
    server {
        server_name www.domain.tld domain.tld;
        return 301 https://domain.tld$request_uri;
    }

    # Redirects www to non-www
    server {
        listen 443 ssl http2;
        listen [::]:443 ssl http2;
        server_name www.domain.tld;
        return 301 https://domain.tld$request_uri;
    }

    # Configuration for https non-www (intended uri)
    server {
        listen 443 ssl http2 default_server;
        listen [::]:443 ssl http2 default_server;
        include snippets/ssl-domain.tld.conf;
        include snippets/ssl-params.conf;
        server_name domain.tld;

    # Put the rest of your configuration here

    }

### Renewal

Add renewal to your crontab as Certbot recommends. Be sure to add a command
to reload nginx.
