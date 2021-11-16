#!/bin/bash

docker build -t pennsive/rstudio:4.1 .
docker build -t pennsive/rstudio:latest .
docker push pennsive/rstudio:4.1
docker push pennsive/rstudio:latest
