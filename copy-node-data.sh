#!/bin/bash

# Ensure the correct number of arguments are provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <volume_name> <source_path>"
    exit 1
fi

# Assign arguments to variables
VOLUME_NAME=$1
SOURCE_PATH=$2

# Validate that the source path exists
if [[ ! -d $SOURCE_PATH ]]; then
    echo "Error: The source path $SOURCE_PATH does not exist."
    exit 1
fi

# Run the Docker command to copy data
docker run --rm -v $VOLUME_NAME:/data -v $SOURCE_PATH:/var/lib/erigon debian:bullseye-slim bash -c "apt-get update && apt-get install -y rsync && rsync -avP /var/lib/erigon/* /data"

