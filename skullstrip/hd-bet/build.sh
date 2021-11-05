#!/bin/bash

docker build -t pennsive/hd-bet .
docker build -t pennsive/hd-bet:69f0202 .
docker push pennsive/hd-bet
docker push pennsive/hd-bet:69f0202
