import os, socket, signal, sys
from datetime import datetime
from flask import Flask
app = Flask(__name__)
START = datetime.utcnow()
@app.route('/')
def index():
    return f'''
    <html><head><title>Week 8 Demo</title></head>
    <body style="font-family:sans-serif;text-align:center;padding-top:60px">
    <h1>Container is serving</h1>
    <p>Hostname: <code>{socket.gethostname()}</code></p>
    <p>Environment: <code>{os.environ.get("ENVIRONMENT", "unset")}</code></p>
    <p>Version: <code>{os.environ.get("APP_VERSION", "1.0")}</code></p>
    <p>Started: <code>{START.isoformat()}Z</code></p>
    </body></html>'''

@app.route('/health')
def health():
    return {'status': 'healthy'}, 200
    # Handle SIGTERM properly — this is the Class 1 lesson that pays off in Class 2

def shutdown(signum, frame):
    print('SIGTERM received — draining and exiting cleanly', flush=True)
    sys.exit(0)

signal.signal(signal.SIGTERM, shutdown)
if __name__ == '__main__':
    print('Serving on 0.0.0.0:5000', flush=True)
    app.run(host='0.0.0.0', port=5000)
