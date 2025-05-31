#!/bin/bash

# Check if REDIS_PASSWORD is already set in the environment
if [ -z "$REDIS_PASSWORD" ]; then
  # Prompt the user for the Redis password
  read -s -p "Enter Redis password: " REDIS_PASSWORD
  echo  # Add a newline after the prompt (for better readability)
fi

# Build the image
echo "Building image redis6:latest..."
podman build --no-cache -t redis6:latest .
if [ $? -ne 0 ]; then
  echo "Error building image. Check your Dockerfile and build output."
  exit 1
fi

# Get the image ID
image_id=$(podman images -q redis6:latest)
if [ -z "$image_id" ]; then
  echo "Error: Image redis6:latest not found after building. Check your build process."
  exit 1
fi

# Remove old images with the same tag preventing removing the image we just built.
old_image_id=$(podman images -q redis6:latest)
if [ ! -z "$old_image_id" ] && [ "$image_id" != "$old_image_id" ]; then 
  echo "Removing old image redis6:latest..."
  podman rmi "$old_image_id"
fi

# Run your container using the image ID
echo "Running container redis6c with image ID: $image_id..."
podman run -d --name redis6c \
  -e REDIS_PASSWORD="${REDIS_PASSWORD}" \
  -p 30001-30006:30001-30006 \
  "$image_id"

if [ $? -ne 0 ]; then
  echo "Error running container. Check the output of podman run."
  exit 1
fi

# Remove unused images after work is done (optional)
trap 'podman image prune -af' EXIT
