#!/bin/bash

# Start the Validator process in the background and capture its output to a log file
/usr/local/bin/lighthouse vc \
  --network goerli \
  --datadir /var/lib/lighthouse \
  --suggested-fee-recipient 0xe81a5054567C95db393751AC6194F925eDb8B3c0 \
  --graffiti "Erdos" \
  > /var/lib/lighthouse/validator.log 2>&1 &

# Start the Beacon process and capture its output to a log file
/usr/local/bin/lighthouse bn \
  --network goerli \
  --datadir /var/lib/lighthouse \
  --http \
  --execution-endpoint http://erigon:8551 \
  --execution-jwt /secrets/jwtsecret \
  --checkpoint-sync-url https://prater.checkpoint.sigp.io \
  --metrics \
  > /var/lib/lighthouse/beacon.log 2>&1

# Tail both log files with multitail and output to stdout
multitail -cS validator-log /var/lib/lighthouse/validator.log -cS beacon-log /var/lib/lighthouse/beacon.log
