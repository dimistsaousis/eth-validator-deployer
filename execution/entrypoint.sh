#!/bin/bash
set -e  # Exit on any error

# Build the command with the necessary flags
CMD="erigon \
  --prune htc \
  --chain goerli \
  --http.api web3,eth,net,engine \
  --private.api.addr 0.0.0.0:9090 \
  --datadir /var/lib/erigon \
  --port 30303 \
  --p2p.allowed-ports 30303,30304,30305 \
  --torrent.port 42069 \
  --nat any \
  --metrics \
  --metrics.addr 0.0.0.0 \
  --http \
  --http.addr 0.0.0.0 \
  --http.port 8545 \
  --http.vhosts=* \
  --http.corsdomain=* \
  --ws \
  --authrpc.addr 0.0.0.0 \
  --authrpc.port 8551 \
  --authrpc.vhosts=* \
  --authrpc.jwtsecret /var/lib/erigon/jwtsecret/secret \
  --maxpeers 100 \
  --db.pagesize 16K"

# Execute the command
exec $CMD
