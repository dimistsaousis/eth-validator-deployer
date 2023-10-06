#!/usr/bin/env bash
set -Eeuo pipefail

if [ "$(id -u)" = '0' ]; then
  chown -R erigon:erigon /var/lib/erigon
  exec su-exec erigon "${BASH_SOURCE[0]}" "$@"
fi

echo "Generating JWT secret"
__secret1=$(head -c 8 /dev/urandom | od -A n -t u8 | tr -d '[:space:]' | sha256sum | head -c 32)
__secret2=$(head -c 8 /dev/urandom | od -A n -t u8 | tr -d '[:space:]' | sha256sum | head -c 32)
echo -n "${__secret1}""${__secret2}" > /var/lib/erigon/jwtsecret/secret

chmod 777 /var/lib/erigon/jwtsecret
chmod 666 /var/lib/erigon/jwtsecret/secret

