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

#cat /docker/docker.support.dockerfile >> /output/generated.Dockerfile

# mandatory
cat /docker/end.base.dockerfile >> /output/generated.Dockerfile

echo "Dockerfile generated 🎉"
