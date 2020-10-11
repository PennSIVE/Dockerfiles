#!/bin/bash

docker run --rm -d -e PORT=9090 -v $HOME:/data -w /data -p 80:9090 pennsive/rstudio:4.0
# ssh -L12345:127.0.0.1:12345 timrf@takim
# SINGULARITYENV_PORT=12345 singularity run --cleanenv -B $TMPDIR:/var/run/rstudio-server /project/taki3/simg/rstudio_4.0.sif
