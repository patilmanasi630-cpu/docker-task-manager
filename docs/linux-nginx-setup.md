# Linux Server Administration & Nginx Reverse Proxy

## 1. Objective

This project documents a secure Linux server configuration with:

- SSH key-based authentication
- Disabled password-based SSH login
- UFW firewall
- Nginx reverse proxy
- Gzip compression
- Cache headers
- Rate limiting
- SSL/TLS termination
- Let's Encrypt / Certbot support

---

## 2. Linux User Configuration

Create a dedicated administrative user:

```bash
sudo adduser deploy
sudo usermod -aG sudo deploy