#!/bin/bash

docker run -ti --rm pennsive/neuror:3.6.3

# remember to add connection to acl with xhost, get display IP with `ifconfig en0 | grep 'inet '`
docker run --rm -ti -e QT_X11_NO_MITSHM="1" \
    -e DISPLAY="192.168.0.148:0" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    pennsive/neuror:3.6.3