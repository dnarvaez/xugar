FROM fedora

RUN yum -y install git make gcc libtomcrypt-devel zlib-devel \
    python-imgcreate file zip wget lzma genisoimage mtd-utils crcimg \
    npm

RUN git clone https://github.com/dnarvaez/olpc-os-builder.git
RUN git clone https://github.com/dnarvaez/xugar.git

WORKDIR /olpc-os-builder
RUN git checkout v8.0

WORKDIR /xugar
RUN npm install

CMD npm app.js
