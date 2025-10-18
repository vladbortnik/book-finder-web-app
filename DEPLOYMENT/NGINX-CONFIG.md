# Nginx Configuration for Student Book Exchange Platform

## Configuration File Location
`/etc/nginx/sites-available/bookfinder`

---

## Basic HTTP Configuration

```nginx
server {
    listen 80;
    listen [::]:80;

    server_name bookfinder.vladbortnik.dev;

    # Logging
    access_log /var/log/nginx/bookfinder_access.log;
    error_log /var/log/nginx/bookfinder_error.log;

    # Proxy settings
    location / {
        proxy_pass http://127.0.0.1:5001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Timeouts
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }

    # Static files (optional - can be served directly by Nginx)
    location /static/ {
        alias /opt/book-finder/book-finder-web-app/static/;
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript
               application/x-javascript application/xml+rss
               application/json application/javascript;

    # File upload size limit
    client_max_body_size 10M;
}
```

---

## HTTPS Configuration (SSL/TLS)

### Using Let's Encrypt (Certbot)

#### Install Certbot
```bash
sudo apt install certbot python3-certbot-nginx -y
```

#### Obtain Certificate
```bash
sudo certbot --nginx -d bookfinder.vladbortnik.dev
```

#### Auto-generated HTTPS Configuration
```nginx
server {
    listen 80;
    listen [::]:80;
    server_name bookfinder.vladbortnik.dev;

    # Redirect HTTP to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    server_name bookfinder.vladbortnik.dev;

    # SSL Configuration
    ssl_certificate /etc/letsencrypt/live/bookfinder.vladbortnik.dev/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/bookfinder.vladbortnik.dev/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    # HSTS (HTTP Strict Transport Security)
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

    # Logging
    access_log /var/log/nginx/bookfinder_access.log;
    error_log /var/log/nginx/bookfinder_error.log;

    # Proxy settings
    location / {
        proxy_pass http://127.0.0.1:5001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }

    # Static files
    location /static/ {
        alias /opt/book-finder/book-finder-web-app/static/;
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_proxied any;
    gzip_types text/plain text/css text/xml text/javascript
               application/x-javascript application/xml+rss
               application/json application/javascript;

    # File upload size limit
    client_max_body_size 10M;
}
```

---

## Advanced Configuration Options

### Rate Limiting

Add to prevent abuse:

```nginx
# Define rate limit zone (add to http block in /etc/nginx/nginx.conf)
limit_req_zone $binary_remote_addr zone=bookfinder_limit:10m rate=10r/s;

# In server block
location / {
    limit_req zone=bookfinder_limit burst=20 nodelay;
    # ... rest of proxy settings
}
```

### Custom Error Pages

```nginx
# Custom error pages
error_page 404 /404.html;
error_page 500 502 503 504 /50x.html;

location = /404.html {
    root /opt/book-finder/book-finder-web-app/templates/errors;
    internal;
}

location = /50x.html {
    root /opt/book-finder/book-finder-web-app/templates/errors;
    internal;
}
```

### Caching Static Content

```nginx
# Cache configuration
proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=bookfinder_cache:10m max_size=100m inactive=60m;

location /static/ {
    alias /opt/book-finder/book-finder-web-app/static/;

    # Cache control
    expires 30d;
    add_header Cache-Control "public, immutable";

    # Enable caching in Nginx
    proxy_cache bookfinder_cache;
    proxy_cache_valid 200 30d;
}
```

---

## Testing Configuration

```bash
# Test syntax
sudo nginx -t

# Reload without downtime
sudo systemctl reload nginx

# Full restart
sudo systemctl restart nginx

# Check status
sudo systemctl status nginx

# View error log
sudo tail -f /var/log/nginx/bookfinder_error.log

# View access log
sudo tail -f /var/log/nginx/bookfinder_access.log
```

---

## SSL Certificate Renewal

Certbot auto-renews certificates. Test renewal:

```bash
# Dry run
sudo certbot renew --dry-run

# Force renewal
sudo certbot renew --force-renewal

# Check auto-renewal timer
sudo systemctl status certbot.timer
```

---

## Security Best Practices

1. **Always use HTTPS** in production
2. **Enable HSTS** to force HTTPS
3. **Hide Nginx version**: Add to http block in `/etc/nginx/nginx.conf`:
   ```nginx
   server_tokens off;
   ```
4. **Implement rate limiting** to prevent DDoS
5. **Keep SSL certificates updated** (Certbot auto-renews)
6. **Regular security audits** using tools like:
   ```bash
   sudo nginx -V  # Check Nginx version
   openssl version  # Check OpenSSL version
   ```

---

## Firewall Configuration (UFW)

```bash
# Allow HTTP
sudo ufw allow 80/tcp

# Allow HTTPS
sudo ufw allow 443/tcp

# Allow SSH (be careful!)
sudo ufw allow 22/tcp

# Enable firewall
sudo ufw enable

# Check status
sudo ufw status
```

---

## Performance Tuning

### Worker Processes

Edit `/etc/nginx/nginx.conf`:

```nginx
# Set to number of CPU cores
worker_processes auto;

# Maximum connections per worker
events {
    worker_connections 1024;
}
```

### Buffer Sizes

```nginx
# In http block
client_body_buffer_size 128k;
client_max_body_size 10m;
client_header_buffer_size 1k;
large_client_header_buffers 4 4k;
output_buffers 1 32k;
postpone_output 1460;
```

---

## Monitoring

### Access Logs Analysis

```bash
# Most visited pages
awk '{print $7}' /var/log/nginx/bookfinder_access.log | sort | uniq -c | sort -rn | head -10

# Top IP addresses
awk '{print $1}' /var/log/nginx/bookfinder_access.log | sort | uniq -c | sort -rn | head -10

# Response codes
awk '{print $9}' /var/log/nginx/bookfinder_access.log | sort | uniq -c | sort -rn
```

---

## Troubleshooting

### Common Issues

1. **502 Bad Gateway**
   - Docker container not running
   - Application crashed
   - Port mismatch

2. **403 Forbidden**
   - File permissions issue
   - SELinux blocking (if enabled)

3. **504 Gateway Timeout**
   - Application taking too long to respond
   - Increase proxy timeouts

### Debug Mode

```nginx
# Enable debug logging
error_log /var/log/nginx/bookfinder_debug.log debug;
```

---

*Configuration for http://bookfinder.vladbortnik.dev*
*Last Updated: October 2024*
