#!/bin/bash

# Define variables
lighthouse_path="/usr/local/bin/lighthouse"
network="goerli"

# Start the Validator process in the background and capture its output to a log file
"$lighthouse_path" validator_client \
  --network "$network" \
  --datadir /var/lib/lighthouse \
  --graffiti "Erdos" \
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
