FROM fedora

RUN yum -y install git make gcc libtomcrypt-devel zlib-devel bitfrost-sugar \
    python-imgcreate file zip wget lzma

RUN git clone https://github.com/dnarvaez/olpc-os-builder.git
WORKDIR olpc-os-builder
RUN git checkout v8.0
RUN make install

WORKDIR /
RUN git clone https://github.com/dnarvaez/xugar.git
WORKDIR xugar
