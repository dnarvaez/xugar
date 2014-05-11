FROM fedora

RUN test -b /dev/loop0 || mknod /dev/loop0 b 7 0
RUN test -b /dev/loop1 || mknod /dev/loop1 b 7 1
RUN test -b /dev/loop2 || mknod /dev/loop2 b 7 2
RUN test -b /dev/loop3 || mknod /dev/loop3 b 7 3
RUN test -b /dev/loop4 || mknod /dev/loop4 b 7 4
RUN test -b /dev/loop5 || mknod /dev/loop5 b 7 5

RUN yum -y install git make gcc libtomcrypt-devel zlib-devel \
    python-imgcreate file zip wget lzma genisoimage mtd-utils crcimg \
    nodejs

RUN git clone https://github.com/dnarvaez/olpc-os-builder.git
RUN git clone https://github.com/dnarvaez/xugar.git

WORKDIR olpc-os-builder
RUN git checkout v8.0

WORKDIR xugar
RUN npm install

CMD npm app.js
