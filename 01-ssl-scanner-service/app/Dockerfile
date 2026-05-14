FROM python:3.11.8-slim AS builder
WORKDIR /build
COPY requirements.txt .
RUN pip install --no-cache-dir --target=/dependencies -r requirements.txt

FROM python:3.11.8-slim
WORKDIR /app
COPY --from=builder /dependencies /app/libs
RUN rm -rf /usr/local/lib/python3.11/site-packages/setuptools* && \
    rm -rf /usr/local/lib/python3.11/site-packages/wheel* && \
    rm -rf /usr/local/lib/python3.11/site-packages/pip*
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ENV PYTHONPATH="/app/libs"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
COPY ssl_check.py .
RUN useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app
USER appuser
CMD ["python", "ssl_check.py"]