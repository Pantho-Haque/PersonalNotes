# Docker [#](https://youtu.be/pg19Z8LL06w?si=KwWzAIKi0MKluTsi)

## What and why is docker?

- virtualization software
- application + Libraries and Dependencies + Runtime + env configuration
- packaged in a docker package -> easily share and distribute

### Before docker

- install and configure all services directly on os.
- every developergo through this.
- depends on the os they are using.
- Deployment process
  - developer produce an application with instructions
  - give it to operations team
  - OT will deal with the configurations and installation
  - **Issues**
    - insatall and configure on os
    - conflicts on dependencies
    - miscommunication btwn Development team and OT.

### How Containers solve this issue

- doesnt install directly on the system
- developer starts a **Docker Container** using a single command rather look for binaries to download and install
- gives an isolated environment
- packaged all dependencies and configarations, not only code
- No configurations needed on the server. so Less error

## Docker vs VM

|                      | Docker                  | Virtual Machine                    |
| -------------------- | ----------------------- | ---------------------------------- |
| Virtualize           | only appliacation layer | both Kernel and application layers |
| Use the hosts kernel | Does                    | Doesnt, It boots up on its own     |
| Size                 | MB                      | GB                                 |
| Speed                | Sec                     | Min                                |
| Compatibility        | only linux Distros      | With all os                        |

- Linux based docker image cannot use windows kernel
- Docker developed **Docker Desktop** to run linux containers on windowes or mac
  - uses a hypervisor layer with lightweight linux distros

## Install docker Locally

- [Install Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/) from this link
  - includes Docker Engine, Docker CLI-Client, GUI Client
- Or you can just follow [Omran Jamal](https://omranjamal.me/blog/020-install-docker-with-opinions) vai's blog

## Image vs Container

- Docker Image has a **package** of Application(JS app), Services(nodejs, npm), OS Layer(Linux)
  - includes code with complete environment configuration
    - working directories
    - environment variables
- A **running instance** of an image is a container.
  - From one image we can run multiple containers
- **Docker Registries** have ready docker images - storage for Docker images.
  - [**Docker Hub**](https://hub.docker.com/) - Container Image library
    - default location docker will look for images
    - maintained by Docker Community
    - Dedicated team(Software maintainence, Security Experts) to review and publish all contents.
    - **tags** specifies the version of that image - `latest` for the last image that was build.

## Commands

- Download the images locally,
  - `docker pull {image_name}:{tag}`
  - `docker images` -> to see the images present on local system.
- Run the image to create a container
  - `docker run {image_name}:{tag}` -> runs a new container and will block the terminal , when exit the container dies
  - `docker run -d {image_name}:{tag}` -> using `-d` or `--detach` will run container in **background**
  - `docker start {id}`-> to reuse a container
  - `docker logs {id}` -> to see the application logs from container.
  - `docker stop {id}` -> to stop the container
  - `docker ps` -> to see all running containers.
  - `docker ps -a`-> all container, whether its running or not.
  - `docker rm {id}`-> to delete a container
  - automatically generates a container name if you dont specify
    - `docker run --name {container_name} -d {image_name}:{tag}`
    - we can use that name instead of using that id.
- We can skip the pull part.As Docker automatically pulls images from Docker Hub if its locallly not available.

## Port Binding

- Container runs in closed docker network
- To access, we need to expose it to our local network.
- We do that when we run a docker container.
- `docker run -d -p {HOST_PORT}:{CONTAINER_PORT} nginx:1.23` -> `-p` or `--publish` used to expose
  - Only one service can run on a specific port.

## Public and private registries

- public Docker registry
  - Docker Hub
  - anyone can search images and download
- Private Docker registry
  - cloud providers have service for PDR (Amazon ECR,Google Container Registry)
  - Docker hub also provide PDR
    - it provids both private and public repositories

## Docker Registry and Docker Repository

- Registry
  - service providing storage
  - collection of repositories
- Repository
  - collection of related images

## Creating Own image

- Dockerfile - Definition to build an image
- Directives
  - `FROM` -> select base image.
  - `COPY` -> take the file from local computer to the container.
  - `WORKDIR` -> equivalent to `cd..`
  - `RUN` -> execute linux commands
  - `CMD` -> default command that executes when Docker starts.
- Build
  - `docker build -t {name}:{tag} {directory of Dockerfile}` -> `-t` or `--tag` to set name and optional tag

```docker
FROM node:alpine3.20

# Set the working directory
WORKDIR /app

# Copy all files from the current directory to /app in the container
COPY . /app

RUN npm install

# Start the application
CMD ["npm", "run", "dev"]


#docker build -t todo-web:1.0 .
#docker run -d --name todoApp -p 3000:3000 todo-web:1.0
```

## Docker Compose [#](https://youtu.be/SXwC9fSwct8?si=TuDxPL4TSs9bAVhe)

### Why ?

- microservice application
- set of container(different application) who run together and communicate in one environment.
- To manage multple docker containers (each container have different config)

### use case

- assume we have 2 docker container
- to connect them we have to

  - Create a docker network `docker network create {net_name}`
  - Run a mongodb server from mongodb image in docker hub

```bash
    docekr run -d \
    -p 27017:27017 \
    -e MONGO_INITDB_ROOT_USERNAME=admin \
    -e MONGO_INITDB_ROOT_PASSWORD=password \
    --network {net_name} \
    --name mongodb
    mongo
```

- Run a mongoexpress server from mongoexpress image in docker hub

```bash
    docekr run -d \
    -p 8081:8081 \
    -e ME_CONFIG_MONGODB_ADMINUSERNAME=admin \
    -e ME_CONFIG_MONGODB_ADMINPASSWORD=passsword \
    -e ME_CONFIG_MONGODB_SERVER=mongodb \
    --network {net_name} \
    --name mongo-express
    mongo-express
```

- those containers are now able to communicate with each other as they are in the same network.

### Easy solution -> Docker Compose

- an `yml` file defined with all configuration of list of containers we want to start together
- consist the ability to modify those containers to start or stop them.
- structured way to contain docker commands

```
version: '3.1'

services:
  {container_name}:
    image:{image_name}:{port_name}
    ports:
      -{HOST_PORT}:{CONTAINER_PORT}
    environment:
      {key}:{value}
    depends_on:
      -"{container_name as services}"
```