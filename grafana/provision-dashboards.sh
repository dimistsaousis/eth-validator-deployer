#!/bin/bash

if [ "$(id -u)" = '0' ]; then
  chown -R grafana:root /var/lib/grafana
  chown -R grafana:root /etc/grafana
  exec su-exec grafana "$0" "$@"
fi

#  lighthouse_summary
__url='https://raw.githubusercontent.com/sigp/lighthouse-metrics/master/dashboards/Summary.json'
__file='/etc/grafana/provisioning/dashboards/lighthouse_summary.json'
wget -t 3 -T 10 -qcO - "${__url}" | jq '.title = "lighthouse_summary"' | jq 'walk(if . == "${DS_PROMETHEUS}" then "Prometheus" else . end)' >"${__file}"
#  lighthouse_validator_client
__url='https://raw.githubusercontent.com/sigp/lighthouse-metrics/master/dashboards/ValidatorClient.json'
    __file='/etc/grafana/provisioning/dashboards/lighthouse_validator_client.json'
wget -t 3 -T 10 -qcO - "${__url}" | jq '.title = "lighthouse_validator_client"' >"${__file}"
# lighthouse_validator_monitor
__url='https://raw.githubusercontent.com/sigp/lighthouse-metrics/master/dashboards/ValidatorMonitor.json'
__file='/etc/grafana/provisioning/dashboards/lighthouse_validator_monitor.json'
wget -t 3 -T 10 -qcO - "${__url}" | jq '.title = "lighthouse_validator_monitor"' >"${__file}"
# erigon_dashboard
__url='https://raw.githubusercontent.com/ledgerwatch/erigon/devel/cmd/prometheus/dashboards/erigon.json'
__file='/etc/grafana/provisioning/dashboards/erigon_dashboard.json'
wget -t 3 -T 10 -qcO - "${__url}" | jq '.title = "erigon_dashboard"' | jq '.uid = "YbLNLr6Mz"' >"${__file}"

find /etc/grafana/provisioning -type f -empty -delete

tree /etc/grafana/provisioning/

exec "$@"