# Stage 1: Build dependencies
FROM python:3.12-slim AS builder

WORKDIR /build

COPY backend/requirements.txt .

RUN python -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir --upgrade pip \
    && /opt/venv/bin/pip install --no-cache-dir -r requirements.txt


# Stage 2: Production image
FROM python:3.12-slim AS production

WORKDIR /app

# Create non-root user
RUN useradd --create-home --shell /bin/bash appuser

# Copy dependencies from builder
COPY --from=builder /opt/venv /opt/venv

# Copy application
COPY backend/ .

ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Give application ownership to non-root user
RUN chown -R appuser:appuser /app

# Run as non-root user
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
