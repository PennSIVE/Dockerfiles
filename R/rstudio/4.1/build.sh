#!/bin/bash

docker build -t pennsive/rstudio:4.1 .
docker push pennsive/rstudio:4.1
