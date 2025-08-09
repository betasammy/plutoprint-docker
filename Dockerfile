FROM quay.io/pypa/manylinux2014_x86_64:latest

RUN yum groupinstall -y "Development Tools" && \
    yum install -y pkgconfig libpng-devel pixman-devel fontconfig-devel freetype-devel glib2-devel libXrender-devel libXext-devel wget python3 python3-pip && \
    yum clean all

# Install meson and ninja
RUN pip3 install meson ninja

RUN cd /tmp && \
    wget https://cairographics.org/releases/cairo-1.18.4.tar.xz && \
    tar xf cairo-1.18.4.tar.xz && \
    cd cairo-1.18.4 && \
    meson setup builddir --prefix=/usr/local && \
    ninja -C builddir && \
    ninja -C builddir install && \
    ldconfig

RUN pkg-config --modversion cairo
