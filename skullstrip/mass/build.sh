#!/bin/bash

docker run --rm repronim/neurodocker:0.7.0 generate docker \
    --pkg-manager apt \
    --base debian:buster \
    --run "apt-get update && apt-get install -y multiarch-support" \
    --afni version=latest \
    --fsl version=5.0.10 \
    | docker build -t mass_base -
# note: without multiarch-support dpkg will not be able to install the pre-dependancy libxp6
docker build -t pennsive/mass .
