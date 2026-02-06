# Docker Complete Guide

![Docker Architecture](https://raw.githubusercontent.com/docker/docs/main/content/get-started/images/docker-architecture.webp)

## What and Why Docker?

**Docker** is a containerization platform that packages applications with all their dependencies into standardized units called containers.

### Before Docker

- Install and configure all services directly on OS
- Every developer goes through manual setup
- OS-specific dependency conflicts
- **DevOps Friction**: Developers write code → Operations team deploys → Miscommunication → Production failures

### How Containers Solve This

- **Isolated Environment**: Each container has its own filesystem, network, and process space
- **Package Once, Run Anywhere**: Bundle code + dependencies + runtime + config
- **No Server Configuration**: Just pull and run
- **Consistency**: Development = Staging = Production

### Why Use Docker? (`PIS`)

- **Portability**: Run on any system (laptop, cloud, on-prem)
- **Isolation**: No dependency conflicts between apps
- **Scalability**: Spin up 100 containers in seconds

---

## Docker vs Virtual Machines

![Docker vs VM](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*KtazvJZ-IX6aoq3jCjD5tA.png)

| Feature               | Docker Container   | Virtual Machine            |
| :-------------------- | :----------------- | :------------------------- |
| **Virtualizes**       | Application layer  | Kernel + Application layer |
| **Uses Host Kernel**  | ✅ Yes             | ❌ No (boots own kernel)   |
| **Size**              | MB (10-100 MB)     | GB (1-10 GB)               |
| **Startup Speed**     | Seconds            | Minutes                    |
| **OS Compatibility**  | Linux distros only | Any OS                     |
| **Resource Overhead** | Low                | High                       |

**Important**: Linux containers cannot run natively on Windows/Mac. Docker Desktop uses a lightweight Linux VM (WSL2 on Windows, HyperKit on Mac) to enable this.

---

## Core Concepts

### Images vs Containers

```text
Image (Blueprint)
    ↓
Container (Running Instance)

From 1 image → Multiple containers
```

- **Image**: Read-only template with application code, libraries, and OS layer
- **Container**: Running instance of an image (isolated process)

### Docker Registries

- **Docker Hub**: Public registry (default)
- **Private Registries**: AWS ECR, Google Container Registry, Azure ACR, Harbor

---

## Essential Commands

### Image Management

```bash
# Pull image
docker pull nginx:1.23

# List images
docker images

# Remove image
docker rmi nginx:1.23

# Build custom image
docker build -t myapp:1.0 ./path/to/dockerfile

# Push to registry
docker push myrepo/myapp:latest
#          [namespace/registry host]/[repository]:[tag]
```

### Container Lifecycle

```bash
# Run container (foreground)
docker run nginx:1.23

# Port binding
docker run -p 8080:80 nginx

# Environment variables
docker run -e MYSQL_ROOT_PASSWORD=secret mysql:8

# Run detached (background)
docker run -d --name web nginx:1.23

# Start/Stop/Restart
docker start web
docker stop web
docker restart web

# View logs
docker logs web
docker logs -f web  # Follow mode

# Execute command in running container
docker exec -it web bash

# Remove container
docker rm web
docker rm -f web  # Force remove running container

# List containers
docker ps          # Running only
docker ps -a       # All (including stopped)

# Clean workspace
docker container prune  # Remove stopped containers
docker system prune -a  # Remove everything unused
```

---

## Port Binding

Containers run in an isolated network. To access services:

```bash
docker run -d -p 3000:3000 myapp
#                 ↑    ↑
#               HOST  CONTAINER
```

**Rule**: Only one service per host port.

---

## Creating Custom Images

### Dockerfile

```dockerfile
# Base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Expose port (documentation only)
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD node healthcheck.js || exit 1

# Default command
CMD ["node", "server.js"]
```

### Build & Run

```bash
docker build -t myapp:1.0 .
docker run -d -p 3000:3000 myapp:1.0
```

---

## Docker Compose

Manage multi-container applications with a single YAML file.

### Example: Full-Stack App

```yaml
version: "3.8"

services:
  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    environment:
      - REACT_APP_API_URL=http://backend:5000
    depends_on:
      - backend

  backend:
    build: ./backend
    ports:
      - "5000:5000"
    environment:
      - DATABASE_URL=postgresql://postgres:secret@db:5432/mydb
    depends_on:
      - db

  db:
    image: postgres:15
    environment:
      - POSTGRES_PASSWORD=secret
      - POSTGRES_DB=mydb
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

### Commands

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f backend

# Stop services (preserve data)
docker-compose stop

# Stop and remove containers
docker-compose down

# Stop and remove volumes (⚠️ data loss)
docker-compose down -v

# Rebuild images
docker-compose build --no-cache
```

---

## Advanced Topics

### 1. Multi-Stage Builds

Reduce image size by separating build and runtime.

```dockerfile
# Build stage
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
CMD ["node", "dist/server.js"]
```

**Result**: 1.2GB → 150MB

---

### 2. Volumes (Data Persistence)

**Problem**: By default, container data is ephemeral. When you remove a container, all data is lost.

**Solution**: Volumes allow data to persist beyond container lifecycle and share data between containers.

#### Volume Types Explained

##### 1. Named Volumes (Recommended for Production)

- **Managed by Docker**: Stored in `/var/lib/docker/volumes/` (Linux) or Docker Desktop's VM
- **Portable**: Easy to backup, migrate, and share
- **Best for**: Databases, application state, uploaded files

```bash
# Create volume
docker volume create postgres_data

# Use in container
docker run -d \
  --name postgres \
  -v postgres_data:/var/lib/postgresql/data \
  postgres:15

# List volumes
docker volume ls

# Inspect volume location
docker volume inspect postgres_data

# Backup volume
docker run --rm \
  -v postgres_data:/data \
  -v $(pwd):/backup \
  alpine tar czf /backup/postgres_backup.tar.gz /data

# Remove volume (⚠️ deletes data)
docker volume rm postgres_data
```

##### 2. Bind Mounts (Development)

- **Direct mapping**: Host directory ↔ Container directory
- **Real-time sync**: Changes on host instantly reflect in container
- **Best for**: Source code during development, config files

```bash
# Mount current directory
docker run -d \
  --name dev-app \
  -v $(pwd):/app \
  -p 3000:3000 \
  node:18 npm run dev

# Mount specific folder (read-only)
docker run -d \
  -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf:ro \
  nginx:latest
```

**Warning**: Bind mounts can cause permission issues on Linux. Use `--user` flag or chown.

##### 3. tmpfs Mounts (Temporary, In-Memory)

- **Stored in RAM**: Never written to disk
- **Volatile**: Data lost when container stops
- **Best for**: Sensitive data (passwords, tokens), temporary cache

```bash
docker run -d \
  --tmpfs /tmp:rw,size=100m,mode=1777 \
  myapp
```

**When to use Named Volumes:**

- Production databases (PostgreSQL, MySQL, MongoDB)
- Persistent application state
- Sharing data between containers
- Need Docker-managed backups/migrations

**When to use Bind Mounts:**

- Local development (hot reload)
- Sharing configuration files
- Need direct access from host
- Debugging (mount logs to host)

**When to use tmpfs:**

- Storing sensitive data (passwords, tokens) that shouldn't touch disk
- Temporary cache that doesn't need persistence
- Performance-critical temporary data

#### Docker Compose Examples

##### Database with Named Volume

```yaml
version: "3.8"

services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: secret
    volumes:
      # Named volume (persists data)
      - db_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

volumes:
  db_data: # Creates named volume managed by Docker
```

##### Development Setup with Bind Mounts

```yaml
version: "3.8"

services:
  web:
    build: .
    volumes:
      # Bind mount for hot reload
      - ./src:/app/src
      - ./public:/app/public
      # Named volume for node_modules (prevents host override)
      - node_modules:/app/node_modules
    ports:
      - "3000:3000"
    command: npm run dev

volumes:
  node_modules:
```

##### Multi-Container with Shared Volume

```yaml
version: "3.8"

services:
  producer:
    image: myapp/producer
    volumes:
      - shared_data:/data

  consumer:
    image: myapp/consumer
    volumes:
      - shared_data:/data:ro # Read-only access

volumes:
  shared_data:
```

#### Common Volume Commands

```bash
# List all volumes
docker volume ls

# Remove unused volumes
docker volume prune

# Remove specific volume
docker volume rm volume_name

# Inspect volume
docker volume inspect volume_name
```

---

### 3. Docker Networking

**Problem**: Containers are isolated by default. How do they communicate with each other and the outside world?

**Solution**: Docker provides networking capabilities to connect containers, expose services, and isolate traffic.

#### Network Drivers Explained

##### 1. Bridge Network (Default)

- **Isolated virtual network** on a single host
- Containers get private IPs (e.g., `172.17.0.2`)
- Containers can communicate using:
  - **Container name** (DNS): `http://web-app:3000`
  - **Container IP**: `http://172.17.0.2:3000`
- **Best for**: Single-host applications

```bash
# Docker automatically creates a default bridge network
docker network ls
# OUTPUT: bridge (default), host, none

# Create custom bridge network
docker network create my-app-network

# Run containers in same network
docker run -d --network my-app-network --name redis redis:7
docker run -d --network my-app-network --name api -p 5000:5000 myapi

# Inside 'api' container, connect to Redis:
# redis://redis:6379  (uses DNS, 'redis' = container name)

# Inspect network
docker network inspect my-app-network

# Remove network
docker network rm my-app-network
```

##### 2. Host Network

- **No isolation**: Container uses host's network stack directly
- **No port mapping needed**: Container port 80 = Host port 80
- **Performance**: Slightly faster (no NAT)
- **Limitation**: Can't run multiple containers on same port
- **Best for**: Performance-critical apps, network monitoring tools

```bash
docker run -d --network host nginx
# Accessible at: http://localhost:80 (no -p flag needed)
```

##### 3. Overlay Network (Multi-Host)

- **Distributed network** across multiple Docker hosts
- Used in **Docker Swarm** or **Kubernetes**
- Containers on different servers can communicate transparently
- **Best for**: Microservices clusters, distributed systems

```bash
# Initialize Swarm mode
docker swarm init

# Create overlay network
docker network create -d overlay my-overlay

# Deploy services
docker service create --network my-overlay --name web nginx
```

##### 4. None Network

- **No network**: Completely isolated
- **Best for**: Batch jobs that don't need network access

```bash
docker run --network none alpine
```

#### Container Communication Examples

##### Scenario 1: Frontend + Backend + Database

```text
┌─────────────┐      ┌─────────────┐      ┌─────────────┐
│   React     │─────▶│   Node API  │─────▶│  PostgreSQL │
│   (3000)    │      │   (5000)    │      │   (5432)    │
└─────────────┘      └─────────────┘      └─────────────┘
      │                     │                     │
      └─────────────────────┴─────────────────────┘
                   my-app-network
```

**Docker CLI:**

```bash
# Create network
docker network create my-app-network

# Start database
docker run -d \
  --network my-app-network \
  --name db \
  -e POSTGRES_PASSWORD=secret \
  postgres:15

# Start backend
docker run -d \
  --network my-app-network \
  --name api \
  -e DATABASE_URL=postgresql://postgres:secret@db:5432/mydb \
  -p 5000:5000 \
  myapi:latest

# Start frontend
docker run -d \
  --network my-app-network \
  --name web \
  -e REACT_APP_API_URL=http://localhost:5000 \
  -p 3000:3000 \
  myfrontend:latest
```

**Docker Compose (Recommended):**

```yaml
version: "3.8"

services:
  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: secret
    networks:
      - backend
    # No port mapping (only accessible internally)

  api:
    build: ./backend
    environment:
      # Connect using service name 'db'
      DATABASE_URL: postgresql://postgres:secret@db:5432/mydb
    networks:
      - backend
      - frontend
    ports:
      - "5000:5000"

  web:
    build: ./frontend
    environment:
      # Connect using service name 'api'
      REACT_APP_API_URL: http://api:5000
    networks:
      - frontend
    ports:
      - "3000:3000"

networks:
  frontend: # React ↔ API
  backend: # API ↔ Database
```

**Key Points:**

- `db` is **not exposed** to host (no port mapping) → secure
- `api` connects to database using `db:5432` (DNS)
- Networks isolate frontend from database (security)

##### Scenario 2: Microservices with Service Discovery

```yaml
version: "3.8"

services:
  user-service:
    image: myapp/user-service
    networks:
      - microservices

  order-service:
    image: myapp/order-service
    environment:
      USER_SERVICE_URL: http://user-service:3000
    networks:
      - microservices

  payment-service:
    image: myapp/payment-service
    environment:
      ORDER_SERVICE_URL: http://order-service:4000
    networks:
      - microservices

  api-gateway:
    image: myapp/api-gateway
    ports:
      - "8080:8080"
    networks:
      - microservices

networks:
  microservices:
    driver: bridge
```

##### Scenario 3: External Network Access

```yaml
version: "3.8"

services:
  app:
    image: myapp
    networks:
      - internal
      - external

  redis:
    image: redis:7
    networks:
      - internal # Only accessible by 'app'

networks:
  internal:
    internal: true # No internet access
  external:
    # Default: allows outbound internet
```

#### Port Mapping vs Network

| Without Network                        | With Network                                    |
| :------------------------------------- | :---------------------------------------------- |
| `docker run -p 5432:5432 postgres`     | `docker run --network mynet --name db postgres` |
| Accessible from host: `localhost:5432` | Accessible from containers: `db:5432`           |
| **Exposed to outside world**           | **Internal only** (more secure)                 |

#### Common Network Commands

```bash
# List networks
docker network ls

# Create network
docker network create my-network

# Connect running container to network
docker network connect my-network container_name

# Disconnect container from network
docker network disconnect my-network container_name

# Remove network
docker network rm my-network

# Remove unused networks
docker network prune
```

#### Debugging Network Issues

```bash
# Inspect network
docker network inspect my-network

# Check container's IP
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name

# Test connectivity from inside container
docker exec -it container_name ping db
docker exec -it container_name curl http://api:5000/health

# View DNS resolution
docker exec -it container_name nslookup db
```

---

### 4. Docker Layer Caching

Optimize build speed by ordering Dockerfile instructions:

```dockerfile
# ❌ Slow (reinstalls deps on code change)
COPY . .
RUN npm install

# ✅ Fast (caches deps unless package.json changes)
COPY package*.json ./
RUN npm install
COPY . .
```

---

### 5. Security Best Practices

- **Use official base images**: `node:18-alpine` over `node:latest`
- **Run as non-root user**:
  ```dockerfile
  RUN addgroup -S appgroup && adduser -S appuser -G appgroup
  USER appuser
  ```
- **Scan images**: `docker scan myapp:1.0`
- **Use secrets management**: Docker secrets, Vault, AWS Secrets Manager
- **Limit resources**:
  ```bash
  docker run --memory=512m --cpus=0.5 myapp
  ```

---

### 6. Docker in Production

#### Orchestration Tools

- **Docker Swarm**: Native, simple
- **Kubernetes**: Industry standard, complex
- **AWS ECS/Fargate**: Managed container service

#### Health Checks

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:3000/health || exit 1
```

#### Logging

```bash
# JSON file driver (default)
docker run --log-driver json-file --log-opt max-size=10m myapp

# Send to external system
docker run --log-driver syslog --log-opt syslog-address=tcp://logs.example.com:514 myapp
```

---

## Docker Interview Questions

### Beginner Level

**Q1: What is the difference between `CMD` and `ENTRYPOINT`?**

- `CMD`: Default command, can be overridden by `docker run`.
- `ENTRYPOINT`: Fixed command, args from `docker run` are appended.

```dockerfile
ENTRYPOINT ["python"]
CMD ["app.py"]
# docker run myapp test.py → Runs: python test.py
```

**Q2: How do you reduce Docker image size?**

- Use Alpine base images
- Multi-stage builds
- Remove cache: `RUN apt-get update && apt-get install -y pkg && rm -rf /var/lib/apt/lists/*`
- Use `.dockerignore`

**Q3: What is the difference between `COPY` and `ADD`?**

- `COPY`: Simple file copy.
- `ADD`: Can extract tar files and fetch URLs (avoid unless needed).

**Q4: How does Docker networking work?**

- Containers on the same bridge network can communicate using:
  - Service names (DNS): `http://web-app:3000`
  - Container IPs: `http://172.17.0.2:3000`

---

### Intermediate Level

**Q5: Explain Docker layer caching.**

Each Dockerfile instruction creates a **read-only layer**. Docker uses a layered filesystem where each layer only stores the changes (diff) from the previous layer.

**How Caching Works:**

1. Docker calculates a checksum for each instruction (command + context)
2. If the instruction and all files it uses are unchanged, Docker reuses the cached layer
3. If **any** layer changes, all subsequent layers are invalidated (cache miss)

**Example - Bad Ordering (Slow Builds):**

```dockerfile
FROM node:18
WORKDIR /app

# ❌ Changes frequently → Invalidates cache on every code change
COPY . .
RUN npm install

CMD ["node", "server.js"]
```

**Problem**: Any code change → `COPY . .` layer invalidated → `npm install` re-runs (slow!)

**Example - Good Ordering (Fast Builds):**

```dockerfile
FROM node:18
WORKDIR /app

# ✅ Copy package files first (rarely change)
COPY package*.json ./
RUN npm install

# ✅ Copy source code last (changes frequently)
COPY . .

CMD ["node", "server.js"]
```

**Benefit**: Code changes don't invalidate `npm install` layer → Fast rebuilds!

**Key Principles:**

- **Least → Most frequently changing**: Base image → Dependencies → Source code
- **Combine layers**: `RUN apt-get update && apt-get install -y pkg` (not separate commands)
- **Use `.dockerignore`**: Exclude files that shouldn't invalidate cache (`.git`, `node_modules`, `*.md`)
- **Multi-stage builds**: Cache intermediate build stages

**Cache Busting Commands:**

```bash
# Build without cache
docker build --no-cache -t myapp:latest .
docker-compose build --no-cache

# Use BuildKit for better caching
DOCKER_BUILDKIT=1 docker build -t myapp:latest .
DOCKER_BUILDKIT=1 docker-compose build
```

**Q6: How do you debug a crashing container?**

```bash
# View exit code
docker ps -a

# Check logs
docker logs container_name

# Inspect
docker inspect container_name

# Override entrypoint to debug
docker run -it --entrypoint /bin/sh myapp
```

**Q7: What are Docker volumes? When to use bind mounts vs named volumes?**

**Volumes** are the preferred mechanism for persisting data in Docker. There are three types:

| Feature         | Named Volume                    | Bind Mount                      | tmpfs                     |
| :-------------- | :------------------------------ | :------------------------------ | :------------------------ |
| **Managed by**  | Docker                          | User (host filesystem)          | Operating System (RAM)    |
| **Location**    | `/var/lib/docker/volumes/`      | Any host path                   | Memory only               |
| **Persistence** | Survives container removal      | Survives container removal      | Lost when container stops |
| **Performance** | Good                            | Slower (file sync overhead)     | Fastest                   |
| **Portability** | ✅ Portable across hosts        | ❌ Host-dependent paths         | N/A                       |
| **Backup**      | Easy (Docker CLI)               | Manual (host tools)             | N/A                       |
| **Best for**    | Production databases, app state | Local development, config files | Temporary secrets, cache  |

**Q8: How do you pass secrets to containers securely?**

- Environment variables (not for production!)
- Docker secrets (Swarm mode)
- External secret managers (AWS Secrets Manager, HashiCorp Vault)
- Mounted files with restricted permissions

---

### Advanced Level

**Q9: Explain multi-stage builds with an example.**
Multi-stage builds use multiple `FROM` statements. Earlier stages compile code, final stage copies only runtime artifacts.

```dockerfile
FROM golang:1.20 AS builder
WORKDIR /app
COPY . .
RUN go build -o app

FROM alpine:3.18
COPY --from=builder /app/app /app
CMD ["/app"]
```

**Benefit**: 800MB Go image → 15MB Alpine runtime.

**Q10: How does Docker handle resource limits?**

Docker allows you to constrain CPU, memory, and I/O resources to prevent containers from consuming all host resources.

```bash
# CPU (limit to 1.5 CPU cores)
docker run --cpus=1.5 myapp
# Prevents CPU starvation on multi-tenant systems

# Memory (512MB RAM, 1GB total including swap)
docker run --memory=512m --memory-swap=1g myapp
# Prevents OOM (Out of Memory) crashes affecting other containers

# Block I/O (500 = 50% of default I/O weight)
docker run --blkio-weight=500 myapp
# Controls disk read/write priority relative to other containers
```

**Docker Compose example:**

```yaml
services:
  web:
    image: nginx
    deploy:
      resources:
        limits:
          cpus: "0.5"
          memory: 512M
        reservations:
          cpus: "0.25"
          memory: 256M
```

**Q11: What is the difference between `docker-compose stop` and `docker-compose down`?**

- `stop`: Stops containers but keeps them (can restart).
- `down`: Stops and **removes** containers, networks. Add `-v` to remove volumes.

**Q12: How do you optimize Docker build time in CI/CD?**

- Use BuildKit: `DOCKER_BUILDKIT=1 docker build .`
- Layer caching: Cache `node_modules` layer separately
- Docker layer caching in CI (GitHub Actions, GitLab CI)
- Multi-stage builds

---

### Production/System Design Level

**Q13: How would you design a zero-downtime deployment strategy with Docker?**

**Strategy 1: Blue-Green Deployment**

- Maintain two identical environments (Blue = current, Green = new version)
- Deploy new version to Green, test thoroughly
- Switch load balancer to Green instantly
- Keep Blue running as instant rollback option

```yaml
# docker-compose-blue.yml (current production)
services:
  web:
    image: myapp:v1.0
    labels:
      - "traefik.http.routers.web.rule=Host(`app.example.com`)"

# docker-compose-green.yml (new version)
services:
  web:
    image: myapp:v2.0
    labels:
      - "traefik.http.routers.web-green.rule=Host(`app.example.com`)"
      - "traefik.http.routers.web-green.priority=100"  # Higher priority

# Switch: Change priority or disable blue router
```

**Strategy 2: Rolling Updates (Recommended for Kubernetes/Swarm)**

**Docker Swarm:**

```bash
# Update service with rolling deployment
docker service update \
  --image myapp:v2.0 \
  --update-parallelism 2 \
  --update-delay 10s \
  myapp

# Updates 2 containers at a time with 10s delay between batches
```

**Kubernetes:**

```bash
# Update deployment
kubectl set image deployment/myapp myapp=myapp:v2.0

# Or apply updated manifest
kubectl apply -f deployment.yaml

# Watch rollout status
kubectl rollout status deployment/myapp

# Rollback if needed
kubectl rollout undo deployment/myapp
```

```yaml
# deployment.yaml with rolling update strategy
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1 # Max 1 extra pod during update
      maxUnavailable: 0 # Keep all pods available (zero downtime)
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
        - name: myapp
          image: myapp:v2.0
          readinessProbe:
            httpGet:
              path: /health
              port: 3000
            initialDelaySeconds: 5
            periodSeconds: 5
          livenessProbe:
            httpGet:
              path: /health
              port: 3000
            initialDelaySeconds: 15
            periodSeconds: 10
```

**How it works:** New pods are created one-by-one. Traffic only routes to new pods after passing readiness checks. Old pods terminate only after new pods are ready.

**Strategy 3: Health Checks + Load Balancer**

```dockerfile
FROM node:18
WORKDIR /app
COPY . .

HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f http://localhost:3000/health || exit 1

CMD ["node", "server.js"]
```

```yaml
# docker-compose.yml with rolling update behavior
version: "3.8"
services:
  web:
    image: myapp:latest
    deploy:
      replicas: 3
      update_config:
        parallelism: 1 # Update 1 at a time
        delay: 10s # Wait 10s between updates
        order: start-first # Start new before stopping old
      rollback_config:
        parallelism: 0 # Instant rollback all
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 10s
      timeout: 3s
      retries: 3
```

**Key Requirements:**

- Health checks to verify new containers are ready
- Load balancer to control traffic routing
- Monitoring to detect issues immediately
- Rollback plan (keep old image/containers)

---

**Q14: What is Docker Overlay Network?**

**Definition:** Overlay networks enable communication between containers across **multiple Docker hosts** (servers), creating a virtual network that spans physical machines.

**How it works:**

- Uses **VXLAN** (Virtual Extensible LAN) tunneling
- Encapsulates container traffic and routes it across hosts
- Provides built-in service discovery and load balancing

**When to use:**

- Docker Swarm clusters
- Multi-host microservices
- Distributed applications across data centers

**Example - Docker Swarm:**

```bash
# Initialize Swarm on manager node
docker swarm init --advertise-addr 192.168.1.10

# On worker nodes
docker swarm join --token <token> 192.168.1.10:2377

# Create overlay network
docker network create \
  --driver overlay \
  --attachable \
  my-overlay-network

# Deploy service across cluster
docker service create \
  --name web \
  --network my-overlay-network \
  --replicas 5 \
  nginx

# Containers on different hosts can communicate via service name
# http://web:80 works from any container in the network
```

**Example - Docker Compose with Swarm:**

```yaml
version: "3.8"

services:
  web:
    image: nginx
    networks:
      - webnet
    deploy:
      replicas: 3

  api:
    image: myapi
    networks:
      - webnet
    environment:
      - DATABASE_URL=postgres://db:5432
    deploy:
      replicas: 2

networks:
  webnet:
    driver: overlay
    attachable: true
```

**Overlay vs Bridge:**
| Feature | Bridge | Overlay |
| :--- | :--- | :--- |
| **Scope** | Single host | Multi-host |
| **Use case** | Local development | Production clusters |
| **Encryption** | No | Optional (`--opt encrypted`) |

---

**Q15: How do you handle logging in a containerized environment?**

**Challenge:** Container filesystems are ephemeral. Logs inside containers are lost when containers are removed.

**Solution 1: Stdout/Stderr (12-Factor App)**

```dockerfile
# Application logs to stdout
FROM node:18
CMD ["node", "server.js"]  # Logs go to stdout
```

```bash
# View logs
docker logs myapp
docker logs -f myapp  # Follow mode

# Configure log driver
docker run \
  --log-driver json-file \
  --log-opt max-size=10m \
  --log-opt max-file=3 \
  myapp
```

**Solution 2: Centralized Logging (Production)**

```yaml
# docker-compose.yml with centralized logging
version: "3.8"

services:
  app:
    image: myapp
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
        labels: "service=app"

  # Fluentd for log aggregation
  fluentd:
    image: fluent/fluentd:latest
    volumes:
      - ./fluentd/conf:/fluentd/etc
    ports:
      - "24224:24224"

  # Ship logs to ELK Stack
  logstash:
    image: docker.elastic.co/logstash/logstash:8.0.0
    volumes:
      - ./logstash.conf:/usr/share/logstash/pipeline/logstash.conf
```

**Solution 3: Sidecar Pattern (Kubernetes)**

```yaml
# Each pod has a logging sidecar container
apiVersion: v1
kind: Pod
metadata:
  name: myapp
spec:
  containers:
    - name: app
      image: myapp:latest
      volumeMounts:
        - name: logs
          mountPath: /var/log/app

    - name: log-shipper # Sidecar
      image: fluent/fluentd
      volumeMounts:
        - name: logs
          mountPath: /var/log/app
          readOnly: true

  volumes:
    - name: logs
      emptyDir: {}
```

**Best Practices:**

- Log to stdout/stderr (container-native)
- Use structured logging (JSON format)
- Set log rotation limits to prevent disk fill
- Send to centralized system (ELK, Loki, CloudWatch)
- Include correlation IDs for request tracing

---

**Q16: Explain Docker security concerns and mitigations.**

**Security Concerns:**

1. **Kernel Vulnerabilities**
   - **Issue:** All containers share host kernel. Kernel exploit = full host compromise.
   - **Mitigation:**
     - Use gVisor or Kata Containers (VM-level isolation)
     - Keep kernel updated
     - Run containers on dedicated hosts

2. **Privilege Escalation**
   - **Issue:** Running as root inside container can escape to host.
   - **Mitigation:**

     ```dockerfile
     FROM node:18-alpine

     # Create non-root user
     RUN addgroup -g 1001 -S appuser && \
         adduser -S appuser -u 1001 -G appuser

     USER appuser
     WORKDIR /app
     COPY --chown=appuser:appuser . .

     CMD ["node", "server.js"]
     ```

3. **Image Vulnerabilities**
   - **Issue:** Base images may contain CVEs (Common Vulnerabilities).
   - **Mitigation:**

     ```bash
     # Scan images
     docker scan myapp:latest
     trivy image myapp:latest

     # Use minimal base images
     FROM node:18-alpine  # Not node:18 (Debian-based, larger)
     FROM scratch         # For Go binaries (no OS layer)
     ```

4. **Exposed Secrets**
   - **Issue:** Hardcoded passwords in images/environment variables.
   - **Mitigation:**

     ```yaml
     # Docker Swarm secrets
     version: "3.8"
     services:
       db:
         image: postgres
         secrets:
           - db_password
         environment:
           POSTGRES_PASSWORD_FILE: /run/secrets/db_password

     secrets:
       db_password:
         external: true # Created with: docker secret create
     ```

5. **Network Exposure**
   - **Issue:** Containers exposed to internet unnecessarily.
   - **Mitigation:**

     ```yaml
     # Only expose API gateway, keep internal services private
     services:
       api:
         ports:
           - "443:443" # Public

       db:
         # No ports! Only accessible via internal network
         networks:
           - backend
     ```

**Complete Security Checklist:**

```bash
# 1. Run as non-root
USER 1000

# 2. Read-only filesystem
docker run --read-only --tmpfs /tmp myapp

# 3. Drop capabilities
docker run --cap-drop=ALL --cap-add=NET_BIND_SERVICE myapp

# 4. AppArmor profile
docker run --security-opt apparmor=docker-default myapp

# 5. Limit resources
docker run --memory=512m --cpus=0.5 myapp

# 6. No privileged mode
# NEVER: docker run --privileged

# 7. Scan before deploy
trivy image myapp:latest --severity HIGH,CRITICAL
```

**Defense in Depth:**

- Network segmentation (private networks)
- Secrets management (Vault, AWS Secrets Manager)
- Image signing (Docker Content Trust)
- Runtime protection (Falco, Sysdig)
- Regular security audits

---

## Quick Reference

### Dockerfile Best Practices

1. Use specific tags (`node:18-alpine`, not `node:latest`)
2. Order layers: least → most frequently changing
3. Combine `RUN` commands to reduce layers
4. Use `.dockerignore`
5. Run as non-root user
6. Multi-stage builds for compiled languages

### Common Errors

| Error                        | Solution                                             |
| :--------------------------- | :--------------------------------------------------- |
| `port already allocated`     | Change host port or stop conflicting service         |
| `no space left on device`    | `docker system prune -a`                             |
| `cannot connect to daemon`   | Start Docker Desktop / `sudo systemctl start docker` |
| `permission denied (socket)` | `sudo usermod -aG docker $USER` (logout/login)       |

---

## Resources

- [Official Docs](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Play with Docker](https://labs.play-with-docker.com/) - Free playground
- [Dockerfile Best Practices](https://docs.docker.com/develop/dev-best-practices/)
