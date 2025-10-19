#!/bin/bash

echo "====================================="
echo "Docker Environment Test for WSL2"
echo "====================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check command existence
check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "${GREEN}✅ $1 found${NC}"
        $1 --version
        return 0
    else
        echo -e "${RED}❌ $1 not found${NC}"
        return 1
    fi
}

echo "[1] Checking System Information..."
echo "-------------------------------------"
echo "WSL2 Distribution: $(lsb_release -d | cut -f2)"
echo "Kernel: $(uname -r)"
echo "Architecture: $(uname -m)"
echo ""

echo "[2] Checking Docker Installation..."
echo "-------------------------------------"
if check_command docker; then
    echo ""
    echo "Docker location: $(which docker)"
fi
echo ""

echo "[3] Checking Docker Compose..."
echo "-------------------------------------"
# Check for docker-compose v1
if command -v docker-compose &> /dev/null; then
    echo -e "${GREEN}✅ Docker Compose v1 found${NC}"
    docker-compose --version
else
    # Check for docker compose v2
    if docker compose version &> /dev/null 2>&1; then
        echo -e "${GREEN}✅ Docker Compose v2 found${NC}"
        docker compose version
    else
        echo -e "${RED}❌ Docker Compose not found${NC}"
    fi
fi
echo ""

echo "[4] Checking Docker Daemon Connection..."
echo "-------------------------------------"
if docker info &> /dev/null; then
    echo -e "${GREEN}✅ Docker daemon is accessible${NC}"
    echo "Docker version: $(docker version --format 'Client: {{.Client.Version}} | Server: {{.Server.Version}}')"

    # Check if using Docker Desktop or native Docker
    if docker info 2>/dev/null | grep -q "docker-desktop"; then
        echo "Using: Docker Desktop for Windows (WSL2 backend)"
    else
        echo "Using: Native Docker in WSL2"
    fi
else
    echo -e "${RED}❌ Cannot connect to Docker daemon${NC}"
    echo ""
    echo "Possible solutions:"
    echo "1. If using Docker Desktop:"
    echo "   - Make sure Docker Desktop is running on Windows"
    echo "   - Enable WSL2 integration in Docker Desktop settings"
    echo "   - Check Settings > Resources > WSL Integration"
    echo ""
    echo "2. If using native Docker in WSL2:"
    echo "   - Install Docker: curl -fsSL https://get.docker.com | sh"
    echo "   - Add user to docker group: sudo usermod -aG docker \$USER"
    echo "   - Start Docker service: sudo service docker start"
fi
echo ""

echo "[5] Checking Docker Socket..."
echo "-------------------------------------"
if [ -S /var/run/docker.sock ]; then
    echo -e "${GREEN}✅ Docker socket exists${NC}"
    ls -la /var/run/docker.sock
else
    echo -e "${YELLOW}⚠️  Docker socket not found at /var/run/docker.sock${NC}"
fi
echo ""

echo "[6] Testing Docker Functionality..."
echo "-------------------------------------"
if docker run --rm hello-world &> /dev/null; then
    echo -e "${GREEN}✅ Docker can run containers successfully${NC}"
else
    echo -e "${RED}❌ Failed to run test container${NC}"
    echo "Attempting to run with output:"
    docker run --rm hello-world
fi
echo ""

echo "[7] Checking Docker Resources..."
echo "-------------------------------------"
if docker info &> /dev/null; then
    docker system df 2>/dev/null | grep -E "TYPE|Images|Containers|Local Volumes"
fi
echo ""

echo "[8] Checking Running Containers..."
echo "-------------------------------------"
if docker ps &> /dev/null; then
    CONTAINER_COUNT=$(docker ps -q | wc -l)
    if [ $CONTAINER_COUNT -gt 0 ]; then
        echo "Running containers: $CONTAINER_COUNT"
        docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    else
        echo "No containers currently running"
    fi
else
    echo -e "${RED}❌ Cannot list containers${NC}"
fi
echo ""

echo "[9] Checking Docker Network..."
echo "-------------------------------------"
if docker network ls &> /dev/null; then
    echo -e "${GREEN}✅ Docker networks available${NC}"
    docker network ls --format "table {{.Name}}\t{{.Driver}}\t{{.Scope}}"
else
    echo -e "${RED}❌ Cannot list networks${NC}"
fi
echo ""

echo "[10] Checking User Permissions..."
echo "-------------------------------------"
if groups | grep -q docker; then
    echo -e "${GREEN}✅ Current user is in docker group${NC}"
else
    echo -e "${YELLOW}⚠️  Current user is not in docker group${NC}"
    echo "You may need to run: sudo usermod -aG docker \$USER"
    echo "Then logout and login again"
fi
echo ""

echo "====================================="
echo "Test Complete!"
echo "====================================="
echo ""

# Summary
echo "Summary:"
if docker info &> /dev/null; then
    echo -e "${GREEN}✅ Docker is properly configured in WSL2${NC}"
    echo ""
    echo "You can now proceed with the project setup!"
    echo "Next steps:"
    echo "1. cd ~/projects"
    echo "2. git clone or create your project"
    echo "3. docker-compose up"
else
    echo -e "${RED}❌ Docker is not properly configured${NC}"
    echo ""
    echo "Please fix the issues above before proceeding."
fi
