FROM fedora

RUN yum -y install git make gcc libtomcrypt-devel zlib-devel

RUN git clone https://github.com/dnarvaez/olpc-os-builder.git
WORKDIR olpc-os-builder
RUN make install

ADD . /xugar
WORKDIR /xugar
