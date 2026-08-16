FROM python:3.11-slim
LABEL maintainer="nigatiesahlie20@gmail.com"
LABEL description="Week 8 container demo app"

# Create an Unprivileged user to run the app 
RUN groupadd -r app && useradd -r -g app app
WORKDIR /app

# Dependencies FIRST - this is the layer cached until requirements.txt changes
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Application code LAST - it changes on every commit
COPY --chown=app:app app.py .
ENV ENVIRONMENT=development \
APP_VERSION=1.0 \
PYTHONUNBUFFERED=1
EXPOSE 5000
USER app
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
CMD python -c "import urllib.request; \
urllib.request.urlopen('http://localhost:5000/health')" || exit 1

# EXEC form — the app becomes PID 1 and receives SIGTERM directly
CMD ["python", "app.py"]
