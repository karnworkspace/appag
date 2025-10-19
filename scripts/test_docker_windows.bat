@echo off
echo =====================================
echo Docker Environment Test for Windows
echo =====================================
echo.

echo [1] Checking Docker Desktop Installation...
echo -------------------------------------
where docker >nul 2>&1
if %errorlevel% == 0 (
    echo ✅ Docker command found
    docker --version
) else (
    echo ❌ Docker command not found - Please install Docker Desktop
)
echo.

echo [2] Checking Docker Compose...
echo -------------------------------------
where docker-compose >nul 2>&1
if %errorlevel% == 0 (
    echo ✅ Docker Compose found
    docker-compose --version
) else (
    echo ⚠️  Docker Compose v1 not found, checking v2...
    docker compose version >nul 2>&1
    if %errorlevel% == 0 (
        echo ✅ Docker Compose v2 found
        docker compose version
    ) else (
        echo ❌ Docker Compose not found
    )
)
echo.

echo [3] Checking Docker Daemon Status...
echo -------------------------------------
docker info >nul 2>&1
if %errorlevel% == 0 (
    echo ✅ Docker daemon is running
    echo.
    echo Docker System Info:
    docker version --format "Client: {{.Client.Version}} | Server: {{.Server.Version}}"
) else (
    echo ❌ Docker daemon is not running
    echo Please start Docker Desktop
)
echo.

echo [4] Checking WSL2 Integration...
echo -------------------------------------
wsl --list --verbose 2>nul | findstr /i "docker-desktop" >nul
if %errorlevel% == 0 (
    echo ✅ Docker Desktop WSL2 integration detected
) else (
    echo ⚠️  Docker Desktop WSL2 integration not detected
)

wsl --list --verbose 2>nul | findstr /i "Ubuntu" >nul
if %errorlevel% == 0 (
    echo ✅ Ubuntu WSL2 distro found
) else (
    echo ⚠️  Ubuntu WSL2 distro not found
)
echo.

echo [5] Testing Docker with Hello-World...
echo -------------------------------------
docker run --rm hello-world >nul 2>&1
if %errorlevel% == 0 (
    echo ✅ Docker can run containers successfully
) else (
    echo ❌ Failed to run test container
    echo Trying to pull and run hello-world image...
    docker run --rm hello-world
)
echo.

echo [6] Checking Docker Resources...
echo -------------------------------------
for /f "tokens=*" %%i in ('docker system df 2^>nul ^| findstr "Images Containers"') do echo %%i
echo.

echo [7] Listing Running Containers...
echo -------------------------------------
docker ps >nul 2>&1
if %errorlevel% == 0 (
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    if %errorlevel% neq 0 (
        echo No containers running
    )
) else (
    echo ❌ Cannot list containers
)
echo.

echo =====================================
echo Test Complete!
echo =====================================
echo.
echo Next step: Run test_docker_wsl.sh inside WSL2
echo Command: wsl -d Ubuntu ~/test_docker_wsl.sh
echo.
pause
