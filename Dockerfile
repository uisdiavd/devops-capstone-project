FROM python:3.9-slim

# Working Directory
WORKDIR /app
COPY requirements.txt .

# Requirements
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY service/ ./service/

# Switch to a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Run
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]