#!/bin/bash

docker run --rm repronim/neurodocker:0.7.0 generate docker \
    --pkg-manager apt \
    --base debian:buster \
    --run "apt-get update && apt-get install -y multiarch-support" \
    --afni version=latest \
    --ants version=2.3.1 \
    --fsl version=6.0.3 \
    --minc version=1.9.15 \
    --freesurfer version=6.0.0 \
    --convert3d version=1.0.0 \
    | docker build -t pennsive/neurodocker:buster -
# note: without multiarch-support dpkg will not be able to install the pre-dependancy libxp6
