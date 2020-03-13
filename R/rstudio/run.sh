#!/bin/bash

docker run -d -e DISABLE_AUTH=true -p 80:8787 pennsive/r-env:rstudio
