#!/bin/bash
# In The Name Of God
# ========================================
# [] File Name : node-exporter.sh
#
# [] Creation Date : 25-05-2018
#
# [] Created By : Parham Alvani <parham.alvani@gmail.com>
# =======================================
version="0.16.0"

# based on https://devopscube.com/monitor-linux-servers-prometheus-node-exporter/

# Downloads and Installs the node exporter
curl -# -L "https://github.com/prometheus/node_exporter/releases/download/v${version}/node_exporter-${version}.linux-amd64.tar.gz" -o node_exporter.tar.gz
tar xvfz node_exporter.tar.gz
rm node_exporter.tar.gz
chmod +x node_exporter-${version}.linux-amd64/node_exporter
sudo mv node_exporter-${version}.linux-amd64/node_exporter /usr/local/bin

# Creates a specific user for node_exporter
sudo useradd -rs /bin/false node_exporter

# Creates a node exporter service
sudo cp node_exporter.service /etc/systemd/system/node_exporter.service
