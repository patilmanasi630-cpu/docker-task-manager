# =========================
# Stage 1: Build
# =========================

FROM python:3.12-slim AS builder

WORKDIR /build

COPY backend/requirements.txt .

RUN python -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir --upgrade pip \
    && /opt/venv/bin/pip install --no-cache-dir -r requirements.txt


# =========================
# Stage 2: Production
# =========================

FROM python:3.12-slim AS production

WORKDIR /app

# Create a non-root user
RUN useradd --create-home --shell /bin/bash appuser

# Copy only the required virtual environment
COPY --from=builder /opt/venv /opt/venv

# Copy backend application
COPY backend/ .

# Use virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Python optimization
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Give application user ownership
RUN chown -R appuser:appuser /app

# Run container as non-root user
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
