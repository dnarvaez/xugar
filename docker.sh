#!/bin/bash

output_dir=$(pwd)/output

sudo docker run -i -t --privileged \
    -v $output_dir:/var/tmp/olpc-os-builder/output/:rw \
    dnarvaez/xugar /bin/bash
