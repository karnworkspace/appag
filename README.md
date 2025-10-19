# Task Manager - Gmail Integration System

A comprehensive task management system that automatically syncs with Gmail to organize meetings, deadlines, and appointments.

## 🚀 Features

- **Gmail Integration**: Automatically fetch and parse emails for meetings and appointments
- **Smart Task Detection**: AI-powered detection of calendar invites, deadlines, and meeting requests
- **Real-time Notifications**: Get alerts before important tasks
- **Multi-platform Access**: Web-based interface accessible from anywhere
- **Docker-based Development**: Consistent development environment across all platforms

## 📋 Prerequisites

- Docker and Docker Compose installed
- WSL2 (for Windows users)
- Node.js 20+ (for local development without Docker)
- Google Cloud Console account (for Gmail API)

## 🛠️ Technology Stack

- **Backend**: Node.js, Express.js, MongoDB
- **Frontend**: React 18, Material-UI
- **Authentication**: Google OAuth 2.0, JWT
- **Email Service**: Gmail API
- **Containerization**: Docker, Docker Compose
- **Development**: WSL2, Ubuntu 24.04

## 📁 Project Structure

```
Appag/
├── backend/                 # Node.js Express API
│   ├── src/
│   │   ├── config/         # Configuration files
│   │   ├── controllers/    # Route controllers
│   │   ├── middlewares/    # Express middlewares
│   │   ├── models/         # MongoDB models
│   │   ├── routes/         # API routes
│   │   ├── services/       # Business logic
│   │   └── server.js       # Main server file
│   ├── package.json
│   └── .env.example
├── frontend/               # React application
│   ├── src/
│   │   ├── components/    # Reusable components
│   │   ├── pages/        # Page components
│   │   └── services/     # API services
│   └── package.json
├── docker/                 # Docker configurations
│   ├── backend.Dockerfile
│   └── frontend.Dockerfile
├── scripts/               # Utility scripts
│   ├── test_docker_windows.bat
│   └── test_docker_wsl.sh
├── docs/                  # Documentation
├── docker-compose.yml     # Docker Compose configuration
├── Makefile              # Common commands
└── README.md             # This file
```

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/taskmanager.git
cd taskmanager
```

### 2. Setup Environment Variables

```bash
# Copy environment templates
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env

# Edit the .env files with your configuration
# Especially the Google OAuth credentials
```

### 3. Start with Docker (Recommended)

#### For WSL2/Linux/Mac:
```bash
# Start Docker service (WSL2 only)
sudo service docker start

# Build and start all services
make init

# Or start services in background
make up
```

#### Using Docker Compose directly:
```bash
# Build images
docker-compose build

# Start services
docker-compose up -d

# View logs
docker-compose logs -f
```

### 4. Access the Application

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:5000
- **API Documentation**: http://localhost:5000/api
- **Health Check**: http://localhost:5000/health

## 📝 Available Make Commands

```bash
make help         # Show all available commands
make up           # Start all services
make down         # Stop all services
make logs         # View logs
make shell-backend # Access backend container
make shell-frontend # Access frontend container
make restart      # Restart all services
make clean        # Clean up everything
```

## 🔧 Development

### Running Tests
```bash
make test         # Run all tests
make test-backend # Run backend tests
make test-frontend # Run frontend tests
```

### Accessing Containers
```bash
make shell-backend  # Access backend container
make shell-frontend # Access frontend container
make shell-mongodb  # Access MongoDB shell
```

### Database Operations
```bash
make db-seed      # Seed database with sample data
make db-backup    # Backup database
make db-migrate   # Run migrations
```

## 🔐 Gmail API Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Gmail API
4. Create OAuth 2.0 credentials
5. Add authorized redirect URIs:
   - `http://localhost:5000/api/auth/google/callback` (development)
   - Your production URL (production)
6. Copy Client ID and Client Secret to `.env` file

## 📊 Environment Variables

### Backend (.env)
```env
NODE_ENV=development
PORT=5000
MONGODB_URI=mongodb://admin:devpass123@mongodb:27017/taskmanager?authSource=admin
JWT_SECRET=your-jwt-secret
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret
FRONTEND_URL=http://localhost:3000
```

### Frontend (.env)
```env
REACT_APP_API_URL=http://localhost:5000
REACT_APP_GOOGLE_CLIENT_ID=your-google-client-id
```

## 🐛 Troubleshooting

### Docker Issues in WSL2
```bash
# If Docker daemon is not running
sudo service docker start

# If permission denied
sudo usermod -aG docker $USER
newgrp docker
```

### Port Already in Use
```bash
# Find process using port
lsof -i :3000  # or :5000

# Kill process
kill -9 <PID>
```

### MongoDB Connection Issues
```bash
# Check MongoDB status
docker logs taskmanager-mongodb

# Access MongoDB shell
make shell-mongodb
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 API Documentation

### Authentication Endpoints
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `GET /api/auth/google` - Google OAuth login
- `POST /api/auth/logout` - User logout

### Task Endpoints
- `GET /api/tasks` - Get all tasks
- `POST /api/tasks` - Create new task
- `GET /api/tasks/:id` - Get task by ID
- `PUT /api/tasks/:id` - Update task
- `DELETE /api/tasks/:id` - Delete task

### Gmail Endpoints
- `GET /api/gmail/sync` - Sync Gmail messages
- `GET /api/gmail/labels` - Get Gmail labels
- `POST /api/gmail/parse` - Parse email for tasks

## 📄 License

This project is licensed under the ISC License.

## 👥 Team

- Development Team
- Project Coordinator

## 📞 Support

For support, please create an issue in the GitHub repository.

---

**Note**: This project is under active development. Features and documentation may change.