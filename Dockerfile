<<<<<<< HEAD
# Stage 1: Build dependencies
=======
# =========================
# Stage 1: Build
# =========================

>>>>>>> bb7622d03e5f9dcb70cbddfcd1d8bb8119774244
FROM python:3.12-slim AS builder

WORKDIR /build

COPY backend/requirements.txt .

RUN python -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir --upgrade pip \
    && /opt/venv/bin/pip install --no-cache-dir -r requirements.txt


<<<<<<< HEAD
# Stage 2: Production image
=======
# =========================
# Stage 2: Production
# =========================

>>>>>>> bb7622d03e5f9dcb70cbddfcd1d8bb8119774244
FROM python:3.12-slim AS production

WORKDIR /app

<<<<<<< HEAD
# Create non-root user
RUN useradd --create-home --shell /bin/bash appuser

# Copy only required dependencies
COPY --from=builder /opt/venv /opt/venv

# Copy application
COPY backend/ .

ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Give application ownership to non-root user
RUN chown -R appuser:appuser /app

=======
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
>>>>>>> bb7622d03e5f9dcb70cbddfcd1d8bb8119774244
USER appuser

EXPOSE 5000

<<<<<<< HEAD
CMD ["python", "app.py"]
=======
CMD ["python", "app.py"]
>>>>>>> bb7622d03e5f9dcb70cbddfcd1d8bb8119774244
