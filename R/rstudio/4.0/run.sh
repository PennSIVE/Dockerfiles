#!/bin/bash

docker run --entrypoint="" -it -e DISABLE_AUTH=true -v $HOME:/data -w /data -p 80:8787 pennsive/rstudio:4.0 bash
# singularity run --cleanenv --pid -B $TMPDIR:/var/run/rstudio-server rstudio_4.0.sif
