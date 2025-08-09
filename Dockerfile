FROM quay.io/pypa/manylinux2014_x86_64:latest

RUN yum groupinstall -y "Development Tools" && \
    yum install -y pkgconfig libpng-devel pixman-devel fontconfig-devel freetype-devel glib2-devel libXrender-devel libXext-devel wget && \
    yum clean all

RUN cd /tmp && \
    wget https://cairographics.org/releases/cairo-1.17.6.tar.xz && \
    tar xf cairo-1.17.6.tar.xz && \
    cd cairo-1.17.6 && \
    ./configure --prefix=/usr/local && \
    make -j$(nproc) && make install && \
    ldconfig

RUN pkg-config --modversion cairo
