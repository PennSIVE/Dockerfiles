#!/bin/bash
# to generate Dockerfile
#docker run --rm kaczmarj/neurodocker:0.9.1 generate docker \
#    --pkg-manager apt \
#    --base-image neurodebian:buster \
#    --fsl version=6.0.5 > Dockerfile
docker build -t pennsive/fsl:6.0.5 . &> build.log 