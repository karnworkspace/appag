# Backend Dockerfile for Node.js + Express
FROM node:20-alpine AS base

# Install dependencies for better compatibility
RUN apk add --no-cache libc6-compat

WORKDIR /app

# Development stage
FROM base AS development

# Install nodemon globally for hot-reload
RUN npm install -g nodemon

# Copy package files
COPY package*.json ./

# Install all dependencies (including devDependencies)
RUN npm ci

# Copy application code
COPY . .

# Expose ports
EXPOSE 5000 9229

# Development command (will be overridden by docker-compose)
CMD ["npm", "run", "dev"]

# Dependencies stage (for production)
FROM base AS dependencies

# Copy package files
COPY package*.json ./

# Install production dependencies only
RUN npm ci --only=production

# Builder stage (for production)
FROM base AS builder

# Copy package files
COPY package*.json ./

# Install all dependencies
RUN npm ci

# Copy application code
COPY . .

# Build if needed (TypeScript compilation, etc.)
# RUN npm run build

# Production stage
FROM base AS production

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Copy production dependencies
COPY --from=dependencies --chown=nodejs:nodejs /app/node_modules ./node_modules

# Copy built application
COPY --from=builder --chown=nodejs:nodejs /app .

# Switch to non-root user
USER nodejs

# Expose port
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD node healthcheck.js || exit 1

# Production command
CMD ["node", "src/server.js"]
