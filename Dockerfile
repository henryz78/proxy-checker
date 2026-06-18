FROM python:3.11-slim

RUN apt-get update && apt-get install -y curl ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files
COPY . .

# Convert line endings of entrypoint.sh to LF
RUN python -c "import sys; content = open('entrypoint.sh', 'rb').read().replace(b'\r\n', b'\n'); open('entrypoint.sh', 'wb').write(content)"

EXPOSE 8888

CMD ["bash", "entrypoint.sh"]
