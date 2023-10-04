#!/bin/bash

# Start the systemd init system
exec /lib/systemd/systemd &

# Capture and output systemd journal logs to stdout
journalctl -u lighthousebeacon.service -u lighthousevalidator.service -f
