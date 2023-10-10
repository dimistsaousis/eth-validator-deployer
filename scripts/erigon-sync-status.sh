#!/bin/bash

# Get the sync status of the erigon node

docker exec -it execution-container curl -X POST --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' -H "Content-Type: application/json" http://localhost:8545