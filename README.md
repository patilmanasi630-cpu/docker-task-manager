# Docker Task Manager

A full-stack Task Manager application built with Flask and PostgreSQL, containerized using Docker and deployed to the cloud.

This project demonstrates practical **Docker, PostgreSQL, CI/CD, Cloud Deployment, Monitoring, and DevOps** concepts.

---

## Features

* Flask web application
* PostgreSQL database
* Docker containerization
* Multi-stage Docker build
* Non-root container execution
* Docker Compose orchestration
* PostgreSQL persistent volume
* Database health checks
* Automated unit testing
* GitHub Actions CI/CD pipeline
* GitHub Container Registry image publishing
* Cloud deployment on Render
* Environment variable based database configuration
* Application health monitoring
* Prometheus metrics
* Grafana-ready monitoring configuration

---

## Project Architecture

```text
                    Internet
                       |
                       v
                Render Cloud
                       |
                       v
              Flask Application
               Docker Container
                       |
             +---------+---------+
             |                   |
             v                   v
        PostgreSQL          Prometheus
          Database            Metrics
             |                   |
             v                   v
       Persistent DB       Monitoring
                              |
                              v
                           Grafana
```

---

## Application Architecture

```text
Browser
   |
   v
Flask Web Application
   |
   +----> /health
   |
   +----> /metrics
   |
   +----> /tasks
   |
   v
PostgreSQL Database
```

---

## Technology Stack

| Technology                | Purpose                      |
| ------------------------- | ---------------------------- |
| Python                    | Application development      |
| Flask                     | Web framework                |
| PostgreSQL                | Database                     |
| Docker                    | Containerization             |
| Docker Compose            | Local service orchestration  |
| GitHub Actions            | CI/CD automation             |
| GitHub Container Registry | Docker image registry        |
| Render                    | Cloud deployment             |
| Prometheus                | Application metrics          |
| Grafana                   | Monitoring and visualization |

---

## Docker Containerization

The application uses a multi-stage Docker build to create a lightweight production container.

The container:

* Installs application dependencies
* Runs the Flask application
* Uses a non-root user
* Exposes the application port
* Supports environment-based configuration

---

## Docker Compose

Docker Compose is used for local orchestration.

The local architecture contains:

```text
Flask Web Container
        |
        v
PostgreSQL Container
        |
        v
Persistent Docker Volume
```

---

## Database

The application uses PostgreSQL.

The database connection is configured using the environment variable:

```text
DATABASE_URL
```

The application automatically initializes the required `tasks` table when the service starts.

Database structure:

```text
tasks
----------------
id       SERIAL PRIMARY KEY
title    TEXT NOT NULL
```

---

## Health Check

The application provides a health endpoint:

```text
/health
```

Live health endpoint:

https://docker-task-manager-sqgf.onrender.com/health

Expected response:

```json
{
  "status": "healthy",
  "database": "connected"
}
```

This endpoint verifies both application availability and PostgreSQL connectivity.

---

## Prometheus Monitoring

Prometheus metrics are exposed through:

```text
/metrics
```

Live metrics endpoint:

https://docker-task-manager-sqgf.onrender.com/metrics

The endpoint exposes:

* Python runtime metrics
* Process CPU metrics
* Process memory metrics
* Flask HTTP request metrics
* Request duration metrics
* HTTP status metrics
* Application information metrics

Example application metric:

```text
task_manager_app{version="1.0.0"} 1.0
```

Prometheus scrape configuration is available in:

```text
prometheus.yml
```

Example:

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: "task-manager"
    metrics_path: "/metrics"
    static_configs:
      - targets:
          - "docker-task-manager-sqgf.onrender.com"
```

---

## Cloud Deployment

The application is deployed using **Render Cloud**.

Live application:

https://docker-task-manager-sqgf.onrender.com

The deployment uses:

* Docker-based deployment
* PostgreSQL managed database
* Environment variables
* Automatic deployment from GitHub
* Public HTTPS endpoint
* Application health endpoint

---

## Environment Variables

The application uses environment variables instead of hard-coded database credentials.

Required environment variable:

```text
DATABASE_URL
```

The database URL is configured securely in the cloud deployment environment.

No database credentials are stored in the GitHub repository.

---

## CI/CD Pipeline

GitHub Actions automatically runs the CI/CD pipeline when code is pushed to the `main` branch or a pull request is created.

Pipeline stages:

```text
Git Push / Pull Request
          |
          v
     Checkout Code
          |
          v
     Setup Python
          |
          v
   Install Dependencies
          |
          v
        Flake8
          |
          v
      Unit Tests
          |
          v
     Docker Build
          |
          v
 GitHub Container Registry
```

The workflow is located at:

```text
.github/workflows/ci-cd.yml
```

---

## Monitoring Endpoints

| Endpoint   | Purpose                         |
| ---------- | ------------------------------- |
| `/`        | Task Manager application        |
| `/health`  | Application and database health |
| `/metrics` | Prometheus metrics              |
| `/tasks`   | Task API                        |

---

## Repository Structure

```text
docker-task-manager/
│
├── .github/
│   └── workflows/
│       ├── ci-cd.yml
│       └── docker-test.yml
│
├── backend/
│   ├── app.py
│   ├── requirements.txt
│   └── templates/
│       └── index.html
│
├── docs/
│   └── linux-nginx-setup.md
│
├── nginx/
│   └── nginx.conf
│
├── tests/
│   └── test_app.py
│
├── .dockerignore
├── Dockerfile
├── docker-compose.yml
├── prometheus.yml
└── README.md
```

---

## DevOps Deployment Pipeline

```text
Developer
    |
    v
GitHub Repository
    |
    v
GitHub Actions
    |
    +----> Lint
    |
    +----> Unit Tests
    |
    +----> Docker Build
    |
    v
GitHub Container Registry
    |
    v
Render Cloud
    |
    +----> Flask Application
    |
    +----> PostgreSQL
    |
    v
Public HTTPS Application
    |
    +----> /health
    |
    +----> /metrics
    |
    v
Monitoring
```

---

## Testing

The project includes automated unit tests using Pytest.

Tests are executed automatically through GitHub Actions.

Docker image builds are also validated through CI/CD.

---

## Cloud Application

**Live Application:**

https://docker-task-manager-sqgf.onrender.com

**Health Check:**

https://docker-task-manager-sqgf.onrender.com/health

**Prometheus Metrics:**

https://docker-task-manager-sqgf.onrender.com/metrics

---

## Project Goals

This project demonstrates practical implementation of:

* Containerization
* Docker optimization
* Database persistence
* Linux and Nginx configuration
* CI/CD automation
* Cloud deployment
* Environment variable management
* Application health monitoring
* Prometheus metrics
* DevOps deployment architecture

---

## Author

Manasi Patil
