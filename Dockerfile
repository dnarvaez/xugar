FROM fedora

RUN yum -y install git make gcc libtomcrypt-devel zlib-devel bitfrost-sugar

RUN git clone https://github.com/dnarvaez/olpc-os-builder.git
WORKDIR olpc-os-builder
RUN git checkout v8.0
RUN make install

ADD . /xugar
WORKDIR /xugar
