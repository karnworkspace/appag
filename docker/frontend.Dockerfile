# Frontend Dockerfile for React Application
FROM node:20-alpine AS base

# Install dependencies for better compatibility
RUN apk add --no-cache libc6-compat

WORKDIR /app

# Development stage
FROM base AS development

# Copy package files
COPY package*.json ./

# Install all dependencies
RUN npm ci

# Copy application code
COPY . .

# Expose port for development server
EXPOSE 3000

# Development command (will be overridden by docker-compose)
CMD ["npm", "start"]

# Dependencies stage (for production build)
FROM base AS dependencies

# Copy package files
COPY package*.json ./

# Install all dependencies (needed for build)
RUN npm ci

# Builder stage (for production)
FROM base AS builder

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy application code
COPY . .

# Build the React application
RUN npm run build

# Production stage (nginx)
FROM nginx:alpine AS production

# Copy custom nginx config
COPY --from=builder /app/nginx.conf /etc/nginx/conf.d/default.conf

# Copy built React app
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:80 || exit 1

# Nginx will start automatically
CMD ["nginx", "-g", "daemon off;"]
