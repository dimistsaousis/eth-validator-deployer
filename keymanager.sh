#!/bin/bash
set -Eeuo pipefail

if [ "$(id -u)" = '0' ]; then
  chown -R lhvalidator:lhvalidator /var/lib/lighthouse
  chown -R lhvalidator:lhvalidator /keys
  exec gosu lhvalidator docker-entrypoint.sh "$@"
fi

echo "$KEYSTORE_PASSWORD" > /keys/password-file
chown lhvalidator:lhvalidator /keys/password-file
chmod 700 keys/password-file

lighthouse --network goerli account validator import --directory /keys --datadir /var/lib/lighthouse --password-file /keys/password-file --reuse-password

exec "$@"