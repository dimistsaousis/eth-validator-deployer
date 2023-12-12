#!/bin/bash

# Usage function
usage() {
    echo "Usage: $0 --container <CONTAINER_NAME> (--enforce --rate <RATE_IN_KBIT> | --disable)"
    exit 1
}

# Check for correct number of arguments
if [ "$#" -lt 3 ] || [ "$#" -gt 5 ]; then
    usage
fi

# Initialize variables
ENFORCE=false
DISABLE=false

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --container)
            shift
            CONTAINER_NAME="$1"
            ;;
        --enforce)
            ENFORCE=true
            ;;
        --rate)
            shift
            RATE="$1"
            ;;
        --disable)
            DISABLE=true
            ;;
        *)
            usage
            ;;
    esac
    shift
done

# Check if the container is running
CONTAINER_STATE=$(docker inspect --format '{{.State.Running}}' "$CONTAINER_NAME" 2>/dev/null)
if [ "$CONTAINER_STATE" != "true" ]; then
    echo "Error: Container $CONTAINER_NAME is not running."
    exit 1
fi

# Find the PID of the container
PID=$(docker inspect --format '{{.State.Pid}}' "$CONTAINER_NAME")

# Find the network namespace ID of the container
NS_ID=$(sudo readlink /proc/$PID/ns/net | awk -F'[:[]+' '{print $3}')

# Find the corresponding veth interface
VETH=$(sudo ip -o link show type veth | grep -B 1 "link-netnsid $NS_ID" | head -n 1 | awk -F': ' '{print $2}' | awk '{print $1}' | cut -d'@' -f1)

if [ -z "$VETH" ]; then
    echo "Error: Failed to identify the veth interface for container $CONTAINER_NAME."
    exit 1
fi

# Apply or remove traffic control based on the flag
if [ "$ENFORCE" = true ]; then
    # Apply traffic control
    sudo tc qdisc add dev $VETH root tbf rate ${RATE}kbit burst 32kbit latency 400ms
    echo "Traffic limit enforced on $VETH at ${RATE}kbit/s"
elif [ "$DISABLE" = true ]; then
    # Remove traffic control
    sudo tc qdisc del dev $VETH root
    echo "Traffic limit removed from $VETH"
else
    usage
fi
