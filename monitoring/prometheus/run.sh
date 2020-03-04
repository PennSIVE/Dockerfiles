#!/bin/bash

docker run --name my-prometheus -v $(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml -p 1112:9090 -d prom/prometheus
