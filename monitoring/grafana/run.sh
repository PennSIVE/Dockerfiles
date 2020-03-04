#!/bin/bash

# docker volume create grafana-storage
docker run -d --name=grafana -e "GF_INSTALL_PLUGINS=grafana-simple-json-datasource" -p 1113:3000 -v grafana-storage:/var/lib/grafana grafana/grafana
