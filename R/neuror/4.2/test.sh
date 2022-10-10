#!/bin/bash

cd $(dirname $0)
docker run --rm -v $PWD:/work pennsive/neuror:4.2 Rscript /work/test_packages.R