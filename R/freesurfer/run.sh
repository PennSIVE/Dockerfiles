#!/bin/bash

docker run -v $(pwd)/license.txt:/usr/local/freesurfer/license.txt -ti --rm pennsive/freesurfer:3.6.3
