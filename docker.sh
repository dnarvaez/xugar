#!/bin/bash

build_dir=$(pwd)/build

sudo docker run -i -t --privileged \
    -v $build_dir:/xugar/build:rw \
    xugar /bin/bash
