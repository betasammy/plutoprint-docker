FROM quay.io/pypa/manylinux2014_x86_64:latest

RUN yum groupinstall -y "Development Tools" && \
    yum install -y epel-release && \
    yum install -y python38 python38-pip python38-devel wget pkgconfig libpng-devel pixman-devel fontconfig-devel freetype-devel glib2-devel libXrender-devel libXext-devel && \
    yum clean all

# Use python3.8 explicitly
RUN python3.8 -m pip install --upgrade pip
RUN python3.8 -m pip install meson>=1.3.0 ninja

RUN cd /tmp && \
    wget https://cairographics.org/releases/cairo-1.18.4.tar.xz && \
    tar xf cairo-1.18.4.tar.xz && \
    cd cairo-1.18.4 && \
    python3.8 -m meson setup builddir --prefix=/usr/local && \
    python3.8 -m ninja -C builddir && \
    python3.8 -m ninja -C builddir install && \
    ldconfig

RUN pkg-config --modversion cairo
