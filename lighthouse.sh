#!/bin/bash

# Define variables
lighthouse_path="/usr/local/bin/lighthouse"  # Replace with the actual path to the lighthouse executable
validator_dir="/var/lib/lighthouse/keys"  # Directory to store validator keys
password="mypassword"
network="goerli"

# Create the keys directory if it doesn't exist
mkdir -p "$validator_dir"

# Check if validator keys already exist
if [ ! -f "$validator_dir/validator_keystore.json" ]; then
    echo "Validator keys do not exist. Generating..."
    "$lighthouse_path" account validator create \
      --network "$network" \
      --output-dir "$validator_dir" \
      --count 1 \
      --password "$password"

fi

# Start the Validator process in the background and capture its output to a log file
"$lighthouse_path" validator_client \
  --network "$network" \
  --datadir /var/lib/lighthouse \
  --graffiti "Erdos" \
  --validators-dir "$validator_dir" \
  --wallet-password "$password" \
  > /var/lib/lighthouse/validator.log 2>&1 &

# Start the Beacon process and capture its output to a log file
"$lighthouse_path" bn \
  --network "$network" \
  --datadir /var/lib/lighthouse \
  --http \
  --execution-endpoint http://erigon:8551 \
  --execution-jwt /secrets/jwtsecret \
  --checkpoint-sync-url https://prater.checkpoint.sigp.io \
  --metrics \
  > /var/lib/lighthouse/beacon.log 2>&1 &

# Tail both log files with multitail and output to stdout
multitail -cS validator-log /var/lib/lighthouse/validator.log -cS beacon-log /var/lib/lighthouse/beacon.log
