FROM node:18-alpine
WORKDIR /app

# Copy app package files
COPY app/package*.json ./

# Install dependencies
RUN npm install --omit=dev

# Copy application code
COPY app/. .

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
CMD node -e "require('http').get('http://localhost:3000/health', (r) =>{process.exit(r.statusCode === 200 ? 0 : 1)})"

# Start application
CMD ["npm", "start"]