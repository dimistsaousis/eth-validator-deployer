#!/bin/bash


# Sometime erigon get's stuck during sync when it crashes. It should automatically unwind some blocks and retry which does not always happen.
# This script allows to unwind some blocks when this happens. See https://github.com/ledgerwatch/erigon/issues/6027

UNWIND=1
if [ "$1" ]; then
    UNWIND=$1
fi

# Construct and execute the command
docker exec -it execution-container sh -c "/usr/local/bin/integration state_stages --unwind=$UNWIND --datadir /var/lib/erigon --chain goerli"
