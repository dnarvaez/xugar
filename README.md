About
=====

xugar is an OLPC OS derivative. The repository contains a few scripts to build
xugar images.

Usage
=====

If docker is available, first of all activate the container.

    ./run-docker.sh

Then build the image with

    ./build-image.sh [xo model]

You can build without docker but you will have to install dependencies
yourself and setup olpc-os-builder, see Dockerfile for the details. When the
system is ready you can just run

    olpc-os-builder [ini file]
