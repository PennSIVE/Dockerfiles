#!/bin/bash

docker run --rm -i repronim/neurodocker:0.9.5 generate docker \
    --pkg-manager apt \
    --base-image debian:buster \
    --run "apt-get update && apt-get install -y multiarch-support" \
    --ants version=2.3.1 \
    --fsl version=6.0.5 \
    --minc version=1.9.15 \
    --freesurfer version=7.3.1 \
    --convert3d version=1.0.0 \
    --dcm2niix version=latest method=source > Dockerfile
# note: without multiarch-support dpkg will not be able to install the pre-dependancy libxp6
