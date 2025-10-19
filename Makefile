# Makefile for Task Manager Project
# Run these commands from WSL2 Ubuntu in the project directory

# Variables
DOCKER_COMPOSE = docker-compose
DOCKER = docker
PROJECT_NAME = taskmanager

# Colors for output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
NC = \033[0m # No Color

# Default target
.DEFAULT_GOAL := help

# Help command
.PHONY: help
help: ## Show this help message
	@echo "$(GREEN)Task Manager - Docker Commands$(NC)"
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-15s$(NC) %s\n", $$1, $$2}'

# Development commands
.PHONY: dev
dev: ## Start all services in development mode (attached)
	@echo "$(GREEN)Starting development environment...$(NC)"
	$(DOCKER_COMPOSE) up

.PHONY: up
up: ## Start all services in background (detached)
	@echo "$(GREEN)Starting services in background...$(NC)"
	$(DOCKER_COMPOSE) up -d

.PHONY: down
down: ## Stop all services
	@echo "$(YELLOW)Stopping all services...$(NC)"
	$(DOCKER_COMPOSE) down

.PHONY: restart
restart: down up ## Restart all services
	@echo "$(GREEN)Services restarted!$(NC)"

# Build commands
.PHONY: build
build: ## Build all Docker images
	@echo "$(GREEN)Building Docker images...$(NC)"
	$(DOCKER_COMPOSE) build

.PHONY: rebuild
rebuild: ## Rebuild all Docker images (no cache)
	@echo "$(GREEN)Rebuilding Docker images from scratch...$(NC)"
	$(DOCKER_COMPOSE) build --no-cache

# Service-specific commands
.PHONY: backend
backend: ## Start only backend service
	@echo "$(GREEN)Starting backend service...$(NC)"
	$(DOCKER_COMPOSE) up backend

.PHONY: frontend
frontend: ## Start only frontend service
	@echo "$(GREEN)Starting frontend service...$(NC)"
	$(DOCKER_COMPOSE) up frontend

.PHONY: mongodb
mongodb: ## Start only MongoDB service
	@echo "$(GREEN)Starting MongoDB service...$(NC)"
	$(DOCKER_COMPOSE) up -d mongodb

# Logs commands
.PHONY: logs
logs: ## Show logs from all services
	$(DOCKER_COMPOSE) logs -f

.PHONY: logs-backend
logs-backend: ## Show logs from backend service
	$(DOCKER_COMPOSE) logs -f backend

.PHONY: logs-frontend
logs-frontend: ## Show logs from frontend service
	$(DOCKER_COMPOSE) logs -f frontend

.PHONY: logs-mongodb
logs-mongodb: ## Show logs from MongoDB service
	$(DOCKER_COMPOSE) logs -f mongodb

# Shell access commands
.PHONY: shell-backend
shell-backend: ## Open shell in backend container
	@echo "$(GREEN)Opening shell in backend container...$(NC)"
	$(DOCKER) exec -it $(PROJECT_NAME)-backend /bin/sh

.PHONY: shell-frontend
shell-frontend: ## Open shell in frontend container
	@echo "$(GREEN)Opening shell in frontend container...$(NC)"
	$(DOCKER) exec -it $(PROJECT_NAME)-frontend /bin/sh

.PHONY: shell-mongodb
shell-mongodb: ## Open MongoDB shell
	@echo "$(GREEN)Opening MongoDB shell...$(NC)"
	$(DOCKER) exec -it $(PROJECT_NAME)-mongodb mongosh -u admin -p devpass123

# Database commands
.PHONY: db-seed
db-seed: ## Seed database with sample data
	@echo "$(GREEN)Seeding database...$(NC)"
	$(DOCKER) exec -it $(PROJECT_NAME)-backend npm run seed

.PHONY: db-migrate
db-migrate: ## Run database migrations
	@echo "$(GREEN)Running database migrations...$(NC)"
	$(DOCKER) exec -it $(PROJECT_NAME)-backend npm run migrate

.PHONY: db-backup
db-backup: ## Backup MongoDB database
	@echo "$(GREEN)Backing up database...$(NC)"
	@mkdir -p ./backups
	$(DOCKER) exec $(PROJECT_NAME)-mongodb mongodump --archive=/tmp/backup.archive --gzip --db taskmanager
	$(DOCKER) cp $(PROJECT_NAME)-mongodb:/tmp/backup.archive ./backups/backup_$(shell date +%Y%m%d_%H%M%S).archive
	@echo "$(GREEN)Backup completed!$(NC)"

# Testing commands
.PHONY: test
test: ## Run all tests
	@echo "$(GREEN)Running tests...$(NC)"
	$(DOCKER) exec -it $(PROJECT_NAME)-backend npm test

.PHONY: test-backend
test-backend: ## Run backend tests
	@echo "$(GREEN)Running backend tests...$(NC)"
	$(DOCKER) exec -it $(PROJECT_NAME)-backend npm test

.PHONY: test-frontend
test-frontend: ## Run frontend tests
	@echo "$(GREEN)Running frontend tests...$(NC)"
	$(DOCKER) exec -it $(PROJECT_NAME)-frontend npm test

# Linting commands
.PHONY: lint
lint: ## Run linters on all code
	@echo "$(GREEN)Running linters...$(NC)"
	$(DOCKER) exec -it $(PROJECT_NAME)-backend npm run lint
	$(DOCKER) exec -it $(PROJECT_NAME)-frontend npm run lint

# Installation commands
.PHONY: install
install: ## Install dependencies for all services
	@echo "$(GREEN)Installing dependencies...$(NC)"
	$(DOCKER) exec -it $(PROJECT_NAME)-backend npm install
	$(DOCKER) exec -it $(PROJECT_NAME)-frontend npm install

.PHONY: install-backend
install-backend: ## Install backend dependencies
	@echo "$(GREEN)Installing backend dependencies...$(NC)"
	$(DOCKER) exec -it $(PROJECT_NAME)-backend npm install

.PHONY: install-frontend
install-frontend: ## Install frontend dependencies
	@echo "$(GREEN)Installing frontend dependencies...$(NC)"
	$(DOCKER) exec -it $(PROJECT_NAME)-frontend npm install

# Cleanup commands
.PHONY: clean
clean: ## Stop and remove all containers, networks, and volumes
	@echo "$(RED)Cleaning up everything...$(NC)"
	$(DOCKER_COMPOSE) down -v
	$(DOCKER) system prune -f

.PHONY: clean-volumes
clean-volumes: ## Remove all project volumes
	@echo "$(RED)Removing volumes...$(NC)"
	$(DOCKER_COMPOSE) down -v

.PHONY: clean-images
clean-images: ## Remove all project images
	@echo "$(RED)Removing images...$(NC)"
	$(DOCKER) rmi $(shell $(DOCKER) images -q $(PROJECT_NAME)*)

# Status commands
.PHONY: ps
ps: ## Show running containers
	@echo "$(GREEN)Running containers:$(NC)"
	$(DOCKER_COMPOSE) ps

.PHONY: stats
stats: ## Show container resource usage
	@echo "$(GREEN)Container resource usage:$(NC)"
	$(DOCKER) stats --no-stream

# Setup commands
.PHONY: setup
setup: ## Initial project setup
	@echo "$(GREEN)Setting up project...$(NC)"
	@cp backend/.env.example backend/.env 2>/dev/null || true
	@cp frontend/.env.example frontend/.env 2>/dev/null || true
	@echo "$(YELLOW)Please edit backend/.env and frontend/.env with your configuration$(NC)"
	@echo "$(GREEN)Setup complete! Run 'make up' to start the project$(NC)"

.PHONY: init
init: setup build up ## Complete initialization (setup, build, and start)
	@echo "$(GREEN)Project initialized successfully!$(NC)"

# Production commands
.PHONY: prod
prod: ## Start services in production mode
	@echo "$(GREEN)Starting production environment...$(NC)"
	$(DOCKER_COMPOSE) -f docker-compose.yml -f docker-compose.prod.yml up -d

.PHONY: deploy
deploy: ## Deploy to production
	@echo "$(GREEN)Deploying to production...$(NC)"
	$(DOCKER_COMPOSE) -f docker-compose.yml -f docker-compose.prod.yml build
	$(DOCKER_COMPOSE) -f docker-compose.yml -f docker-compose.prod.yml up -d

# Monitoring commands
.PHONY: monitor
monitor: ## Show real-time container metrics
	@echo "$(GREEN)Monitoring containers...$(NC)"
	@watch -n 2 docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

.PHONY: health
health: ## Check health status of all services
	@echo "$(GREEN)Checking service health...$(NC)"
	@curl -s http://localhost:5000/health | jq '.' || echo "Backend not responding"
	@curl -s http://localhost:3000 > /dev/null && echo "Frontend: OK" || echo "Frontend: Not responding"
	@$(DOCKER) exec $(PROJECT_NAME)-mongodb mongosh --eval "db.adminCommand('ping')" > /dev/null && echo "MongoDB: OK" || echo "MongoDB: Not responding"

# Quick restart commands
.PHONY: restart-backend
restart-backend: ## Restart backend service
	@echo "$(YELLOW)Restarting backend...$(NC)"
	$(DOCKER_COMPOSE) restart backend

.PHONY: restart-frontend
restart-frontend: ## Restart frontend service
	@echo "$(YELLOW)Restarting frontend...$(NC)"
	$(DOCKER_COMPOSE) restart frontend
