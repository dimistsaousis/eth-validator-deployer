#!/bin/bash
set -e  # Exit on any error

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
  --suggested-fee-recipient 0xe81a5054567C95db393751AC6194F925eDb8B3c0"

exec $CMD
