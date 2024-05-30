#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# Download prometheus
rm -f /tmp/prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz
tar -xvf prometheus-2.43.0.linux-amd64.tar.gz
rm prometheus-2.43.0.linux-amd64.tar.gz
mv prometheus-2.43.0.linux-amd64/prometheus /tmp/prometheus
rm -rf prometheus-2.43.0.linux-amd64

# Import chains and demo.pk key
#
# Assumes morpheus-cli has already been transferred into the machine
/tmp/morpheus-cli chain import-ops aops.yml
/tmp/morpheus-cli key import demo.pk

# Start prometheus server
tmux new-session -d -s prometheus '/tmp/morpheus-cli prometheus generate --prometheus-open-browser=false --prometheus-start=true'
