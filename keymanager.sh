#!/bin/bash

echo "$KEYSTORE_PASSWORD" > keys/password-file
lighthouse --network goerli account validator import --directory /keys --datadir /var/lib/lighthouse --password-file /keys/password-file --reuse-password
exec "$@"