# Student Book Exchange Platform - Deployment Guide

## Overview

The Student Book Exchange Platform is deployed at **http://bookfinder.vladbortnik.dev** using a Docker containerized approach with Gunicorn as the WSGI server and Nginx as the reverse proxy.

---

## Deployment Architecture

```
Internet
    ↓
Nginx (Reverse Proxy) :80
    ↓
Docker Container (book-finder-web-app)
    ↓
Gunicorn WSGI Server :5001
    ↓
Flask Application
    ↓
SQLite Database
```

---

## Production Stack

| Component | Technology | Purpose |
|-----------|-----------|---------|
| **Web Server** | Nginx | Reverse proxy, SSL termination, static files |
| **WSGI Server** | Gunicorn | Python WSGI HTTP server |
| **Application** | Flask 2.0+ | Web application framework |
| **Database** | SQLite | Data persistence |
| **Container** | Docker | Application containerization |
| **OS** | Ubuntu 22.04 LTS | Server operating system |

---

## Deployment Steps

### 1. Server Preparation

```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Nginx
sudo apt install nginx -y

# Install Git
sudo apt install git -y
```

### 2. Clone Repository

```bash
cd /opt
sudo git clone https://github.com/vladbortnik/book-finder.git
cd book-finder/book-finder-web-app
```

### 3. Generate Secret Key

```bash
python3 -c "import secrets; print(secrets.token_hex(16))"
# Save the generated key for use in Docker run command
```

### 4. Build Docker Image

```bash
sudo docker build -t book-finder-web-app .
```

### 5. Run Docker Container

```bash
sudo docker run -d \
  -p 5001:5001 \
  --name book-finder-web-app \
  --restart unless-stopped \
  -e SECRET_KEY='your_generated_secret_key_here' \
  -v /opt/book-finder/book-finder-web-app/instance:/app-server/instance \
  book-finder-web-app
```

**Command Breakdown:**
- `-d` : Run in detached mode (background)
- `-p 5001:5001` : Map host port 5001 to container port 5001
- `--name` : Name the container for easy management
- `--restart unless-stopped` : Auto-restart on server reboot
- `-e SECRET_KEY` : Pass secret key as environment variable
- `-v` : Mount volume for persistent database storage

### 6. Configure Nginx

Create Nginx configuration file:
```bash
sudo nano /etc/nginx/sites-available/bookfinder
```

Add configuration (see NGINX-CONFIG.md for full config)

Enable the site:
```bash
sudo ln -s /etc/nginx/sites-available/bookfinder /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

### 7. Configure DNS

Point your domain to the server IP:
```
A Record: bookfinder → Your.Server.IP.Address
```

### 8. Verify Deployment

```bash
# Check Docker container status
sudo docker ps

# View application logs
sudo docker logs book-finder-web-app

# Check Nginx status
sudo systemctl status nginx

# Test the application
curl http://localhost:5001
curl http://bookfinder.vladbortnik.dev
```

---

## Container Management

### View Running Containers
```bash
sudo docker ps
```

### Stop Container
```bash
sudo docker stop book-finder-web-app
```

### Start Container
```bash
sudo docker start book-finder-web-app
```

### Restart Container
```bash
sudo docker restart book-finder-web-app
```

### View Logs
```bash
# Real-time logs
sudo docker logs -f book-finder-web-app

# Last 100 lines
sudo docker logs --tail 100 book-finder-web-app
```

### Access Container Shell
```bash
sudo docker exec -it book-finder-web-app /bin/bash
```

### Remove Container
```bash
sudo docker stop book-finder-web-app
sudo docker rm book-finder-web-app
```

---

## Updates and Redeployment

### Update Application Code

```bash
# Navigate to repository
cd /opt/book-finder/book-finder-web-app

# Pull latest changes
sudo git pull origin main

# Stop and remove old container
sudo docker stop book-finder-web-app
sudo docker rm book-finder-web-app

# Rebuild image
sudo docker build -t book-finder-web-app .

# Run new container
sudo docker run -d \
  -p 5001:5001 \
  --name book-finder-web-app \
  --restart unless-stopped \
  -e SECRET_KEY='your_secret_key_here' \
  -v /opt/book-finder/book-finder-web-app/instance:/app-server/instance \
  book-finder-web-app
```

---

## Database Management

### Backup Database

```bash
# Create backup directory
mkdir -p ~/backups

# Copy database file
sudo docker cp book-finder-web-app:/app-server/instance/site.db \
  ~/backups/site-$(date +%Y%m%d-%H%M%S).db
```

### Restore Database

```bash
sudo docker cp ~/backups/site-20241017.db \
  book-finder-web-app:/app-server/instance/site.db

sudo docker restart book-finder-web-app
```

---

## Monitoring

### System Resources

```bash
# Docker container stats
sudo docker stats book-finder-web-app

# Disk usage
df -h

# Memory usage
free -h
```

### Application Health Check

```bash
# Check if application is responding
curl -I http://localhost:5001

# Check specific endpoints
curl http://localhost:5001/about
```

---

## Security Considerations

1. **Secret Key**: Never commit the SECRET_KEY to version control
2. **Environment Variables**: Use `.env` files or Docker secrets in production
3. **Database**: Regular backups scheduled via cron
4. **Nginx**: Configured to prevent direct access to sensitive files
5. **Firewall**: UFW configured to allow only ports 80, 443, and 22
6. **Updates**: Regular system and dependency updates

---

## Performance Tuning

### Gunicorn Workers

Current configuration uses 4 workers. Adjust based on server resources:

```dockerfile
# In Dockerfile
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5001", "app:app"]
```

Formula: `(2 × CPU_cores) + 1`

### Database Optimization

For production with high traffic, consider migrating to PostgreSQL:

```python
# app.py
app.config["SQLALCHEMY_DATABASE_URI"] = "postgresql://user:pass@localhost/dbname"
```

---

## Troubleshooting

### Container Won't Start

```bash
# Check logs
sudo docker logs book-finder-web-app

# Common issues:
# - Missing SECRET_KEY
# - Port 5001 already in use
# - Insufficient permissions
```

### Application Errors

```bash
# Access container shell
sudo docker exec -it book-finder-web-app /bin/bash

# Check Flask logs
cat /var/log/gunicorn.log  # if configured

# Verify environment variables
env | grep SECRET_KEY
```

### Nginx Issues

```bash
# Test configuration
sudo nginx -t

# Check error logs
sudo tail -f /var/log/nginx/error.log

# Reload configuration
sudo systemctl reload nginx
```

---

## Rollback Procedure

If deployment fails:

```bash
# Stop current container
sudo docker stop book-finder-web-app
sudo docker rm book-finder-web-app

# Run previous image version
sudo docker run -d \
  -p 5001:5001 \
  --name book-finder-web-app \
  --restart unless-stopped \
  -e SECRET_KEY='your_secret_key' \
  -v /opt/book-finder/book-finder-web-app/instance:/app-server/instance \
  book-finder-web-app:previous-tag

# Restore database from backup
sudo docker cp ~/backups/site-backup.db \
  book-finder-web-app:/app-server/instance/site.db
```

---

## Maintenance Schedule

| Task | Frequency | Command |
|------|-----------|---------|
| System updates | Weekly | `sudo apt update && sudo apt upgrade -y` |
| Database backup | Daily | See backup section |
| Log rotation | Weekly | Configure logrotate |
| Security patches | As needed | System updates |
| Docker image cleanup | Monthly | `sudo docker system prune -a` |

---

## Contact & Support

For deployment issues or questions:
- **Developer**: Vlad Bortnik
- **Website**: https://vladbortnik.dev
- **Email**: via contact form at vladbortnik.dev/contact.html

---

*Last Updated: October 2024*
