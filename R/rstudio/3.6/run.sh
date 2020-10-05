#!/bin/bash

docker run -d -e DISABLE_AUTH=true -v $HOME:/data -w /data -p 80:8787 pennsive/rstudio:3.6
