#!/bin/bash

build_dir=$(pwd)/build

sudo docker run -i -t --privileged \
    -v $build_dir:/xugar/build:rw \
    dnarvaez/xugar /bin/bash
