#!/bin/bash

docker run -v $PWD:$PWD -w $PWD -v $HOME:/root -it --rm pennsive/datalad
