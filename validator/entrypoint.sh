#!/bin/bash
set -e  # Exit on any error

: "${ETH_NETWORK:=goerli}"
: "${FEE_RECIPIENT:=}"
: "${MEVBOOST_RELAYS:=}" 

# Execute the keymanager script
/keymanager.sh

CMD="lighthouse vc \
  --network $ETH_NETWORK \
  --datadir /var/lib/lighthouse \
  --beacon-nodes http://consensus:5052 \
  --metrics \
  --metrics-address 0.0.0.0 \
  --metrics-port 8009 \
  --http \
  --http-port 7500 \
  --http-address 0.0.0.0 \
  --http-allow-origin=* \
  --unencrypted-http-transport \
  --debug-level $LOG_LEVEL"

if [ -n "$FEE_RECIPIENT" ]; then
    CMD="$CMD --suggested-fee-recipient $FEE_RECIPIENT"
fi

if [ -n "$MEVBOOST_RELAYS" ]; then
    CMD="$CMD --builder http://mev-boost:18550"
fi

exec $CMD
