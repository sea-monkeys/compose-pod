# Compose Pod

This project is an attempt to reproduce the 🍊[GitPod](https://www.gitpod.io/) developer experience using 🐳🐙[Docker Compose](https://docs.docker.com/compose/) and [OpenVSCode server](https://github.com/gitpod-io/openvscode-server).

## Features

This project allows you to:
- define a development environment (with the necessary runtimes) with a web-IDE and your GitHub configuration (theoretically this works with GitLab or any other similar solution, testing is in progress)
- then simply launch your development environment with Docker Compose
- easily add services (database, Ollama, ...) thanks to Docker Compose

## Setup

Create a `.env` file in the root of the project with the following variables:

```dotenv
# Compose pod configuration
REDIRECTION_HTTP_PORT=3511
WEB_IDE_HTTP_PORT=3500
```
> - `REDIRECTION_HTTP_PORT` is the port where the redirection service will be available (it's a redirection to the web IDE on the appropriate project folder)
> - `WEB_IDE_HTTP_PORT` is the port where the web IDE will be available

### Git configuration

#### SSH configuration
If you want to be able to push your changes to your GitHub repository, you need to use SSH keys. To use your local SSH keys:

- Copy the content of the public key to the `SSH_PUBLIC_KEY` variable in the `.env` file. Use this command to get the public key: `cat $HOME/.ssh/github_perso.pub`
- Copy the content of the private key to the `SSH_PRIVATE_KEY` variable in the `.env` file. Use this command to get the private key: `cat $HOME/.ssh/github_perso | base64 -w 0` (you need to encoding the value of the key to `base64` format)

```dotenv
# SSH configuration
SSH_PUBLIC_KEY=ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4...
SSH_PRIVATE_KEY=LS0tLS1CRUdJZiBDRVJUSUZJQ8FURS0...
```

#### Git repository configuration

Then, set the following variables in the `.env` file:
> - `GIT_USER_NAME` is the name of the user that will be used to commit your changes
> - `GIT_USER_EMAIL` is the email of the user that will be used to commit your changes
> - `GIT_HOST` is the host of your Git repository (e.g. `github.com`, `gitlab.com`, ...)
> - `PROJECT_NAME` is the name of your project
> - `GIT_REPOSITORY` is the URL of your Git repository 

For example:
```dotenv
# Git configuration
GIT_USER_NAME=k33g
GIT_USER_EMAIL=ph.charrier@gmail.com
GIT_HOST=github.com

# GitHub project
PROJECT_NAME=bob
GIT_REPOSITORY=git@github.com:hawaiian-pizza-corp/bob.git
```

### Setup of the runtime(s)
> This feature is still in progress 🚧 (I'm working on something more "user-friendly")

In the `./docker` folder, you can find the Dockerfile fragments to generate a complete `Dockerfile` with the runtimes you need. You can find the following runtimes:
- `nodejs.support.dockerfile` for NodeJS
- `golang.support.dockerfile` for Golang
- `docker.support.dockerfile` for Docker (in Docker)
- more to come... 🚧

To prepare the setup of the generated Dockerfile, you need to edit the `generate-dockerfile.sh` script: 

```bash
#!/bin/sh
# --------------------------------------
# Generate Dockerfile
# --------------------------------------

# mandatory
cat /docker/base.dockerfile > /output/generated.Dockerfile
cat /docker/tools.dockerfile >> /output/generated.Dockerfile

# optional
cat /docker/nodejs.support.dockerfile >> /output/generated.Dockerfile
cat /docker/golang.support.dockerfile >> /output/generated.Dockerfile

# mandatory
cat /docker/end.base.dockerfile >> /output/generated.Dockerfile

echo "Dockerfile generated 🎉"
```

### Generate the Dockerfile

Run the following command to generate the Dockerfile:
```bash
docker compose --profile generate up
```
This will generate the `generated.Dockerfile` at the root of the project. You are now ready to run the project.

## Run the project

To start the Web IDE and the redirection service, run the following command:
```bash
docker compose --profile pod up --build
```

You can open the project with this URL: "http://localhost:3511" (or the port you defined in the `.env` file). 

Happy coding! 🎉

## Add services

To add services, you just need to use the include feature of Docker Compose. For example, you can add the following lines to the `compose.yml` file:

```yaml
include:
  - services.yml
```

Then, you can create a `services.yml` file with the services you want to add. For example, to add a Ollama service and download LLMs, you can use the following configuration:

```yaml
services:

  ollama-service-with-gpu:
    profiles: ["gpu"]
    image: ollama/ollama:0.6.6
    volumes:
      - ollama-data:/root/.ollama
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]

  ollama-service:
    profiles: ["pod"]
    image: ollama/ollama:0.6.6
    volumes:
      - ollama-data:/root/.ollama

  download-local-llm:
    profiles: ["pod"]
    image: curlimages/curl:8.12.1
    entrypoint: |
      sh -c '      
      curl "http://ollama-service:11434/api/pull" -d @- << EOF
      {"name": "qwen2.5:0.5b"}
      EOF

      curl "http://ollama-service:11434/api/pull" -d @- << EOF
      {"name": "qwen2.5:1.5b"}
      EOF
      '
    depends_on:
      ollama-service:
        condition: service_started

  download-local-llm-with-gpu:
    profiles: ["gpu"]
    image: curlimages/curl:8.12.1
    entrypoint: |
      sh -c '      
      curl "http://ollama-service-with-gpu:11434/api/pull" -d @- << EOF
      {"name": "qwen2.5:0.5b"}
      EOF

      curl "http://ollama-service-with-gpu:11434/api/pull" -d @- << EOF
      {"name": "qwen2.5:1.5b"}
      EOF
      '
    depends_on:
      ollama-service-with-gpu:
        condition: service_started

volumes:
  ollama-data:
```


Then, you can run the project again with the command:
```bash
docker compose --profile pod up --build
```

And if you configuration allows you to benfit from GPU, you can run the project with the command:
```bash
docker compose --profile pod --profile gpu up --build
```