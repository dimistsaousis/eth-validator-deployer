#!/bin/bash
set -e  # Exit on any error

: "${ETH_NETWORK:=goerli}"
: "${FEE_RECIPIENT:=}"
: "${MEVBOOST_RELAYS:=}" 

CMD="lighthouse bn \
  --network $ETH_NETWORK \
  --disable-upnp \
  --datadir /var/lib/lighthouse \
  --http \
  --http-address 0.0.0.0 \
  --http-port 5052 \
  --http-allow-origin=* \
  --listen-address 0.0.0.0 \
  --port 9000 \
  --quic-port 9001 \
  --target-peers 80 \
  --execution-endpoint http://execution:8551 \
  --execution-jwt /var/lib/lighthouse/beacon/jwtsecret/secret \
  --metrics \
  --metrics-address 0.0.0.0 \
  --metrics-port 8008 \
  --validator-monitor-auto \
  --debug-level $LOG_LEVEL"

if [ "$ETH_NETWORK" == "goerli" ]; then
    CMD="$CMD --checkpoint-sync-url https://prater.checkpoint.sigp.io"
fi

if [ -n "$FEE_RECIPIENT" ]; then
    CMD="$CMD --suggested-fee-recipient $FEE_RECIPIENT"
fi

if [ -n "$MEVBOOST_RELAYS" ]; then
    CMD="$CMD --builder http://mev-boost:18550"
fi

exec $CMD
