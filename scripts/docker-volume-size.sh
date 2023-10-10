#!/bin/bash

# Get a list of all docker volume names and their sizes
volumes=$(sudo docker volume ls --format "{{.Name}}")

for volume in $volumes; do
  mountpoint=$(sudo docker inspect --format '{{ .Mountpoint }}' $volume)
  size=$(sudo du -sh $mountpoint | cut -f1)
  echo "Volume: $volume, Size: $size"
done
