#!/bin/bash
set -Eeuo pipefail

if [ "$(id -u)" = '0' ]; then
  chown -R lhvalidator:lhvalidator /var/lib/lighthouse
  chown -R lhvalidator:lhvalidator /keystore
  exec gosu lhvalidator docker-entrypoint.sh "$@"
fi

echo "$KEYSTORE_PASSWORD" > /keystore/password-file
chown lhvalidator:lhvalidator /keystore/password-file
chmod 700 /keystore/password-file

lighthouse --network mainnet account validator import --directory /keystore --datadir /var/lib/lighthouse --password-file /keystore/password-file --reuse-password

exec "$@"