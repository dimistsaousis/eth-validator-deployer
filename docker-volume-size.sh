#!/bin/bash

# Get a list of all docker volume names
volumes=$(sudo docker volume ls --format "{{.Name}}")

for volume in $volumes; do
  # Get the mountpoint of the volume
  mountpoint=$(sudo docker inspect --format '{{ .Mountpoint }}' $volume)
  
  # Get the size of the volume
  size=$(sudo du -sh $mountpoint | cut -f1)
  
  echo "Volume: $volume, Size: $size"
done
