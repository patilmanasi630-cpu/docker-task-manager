# Docker Task Manager

A full-stack task management application containerized using Docker.

This project demonstrates:

- Multi-stage Docker builds
- Lightweight production container
- Non-root container execution
- Flask web application
- PostgreSQL database
- Docker Compose orchestration
- Container health checks
- PostgreSQL volume persistence
- Automated Docker testing with GitHub Actions

---

## Project Architecture

```text
Browser
   |
   v
Flask Web Container
   |
   v
PostgreSQL Container
   |
   v
Persistent Docker Volume
