#!/bin/bash

# Import the validator keys
/usr/local/bin/lighthouse --network goerli account validator import --directory /keys --datadir /var/lib/lighthouse

# Run the validator client
exec /usr/local/bin/lighthouse vc --network goerli --datadir /var/lib/lighthouse --suggested-fee-recipient 0xe81a5054567C95db393751AC6194F925eDb8B3c0 --graffiti "Erdos"
