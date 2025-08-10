FROM quay.io/pypa/manylinux_2_28_x86_64:latest

# Install system dependencies needed for Cairo build and Python venv
RUN yum groupinstall -y "Development Tools" && \
    yum install -y \
      libpng-devel pixman-devel fontconfig-devel freetype-devel glib2-devel libXrender-devel libXext-devel wget python3 python3-pip && \
    yum clean all

# Create a Python virtualenv with newer pip, meson, ninja
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install meson>=1.3.0 ninja

# Build and install Cairo 1.18.4 using the virtualenv meson/ninja
RUN cd /tmp && \
    wget https://cairographics.org/releases/cairo-1.18.4.tar.xz && \
    tar xf cairo-1.18.4.tar.xz && \
    cd cairo-1.18.4 && \
    python3 -m meson setup builddir --prefix=/usr/local && \
    python3 -m ninja -C builddir && \
    python3 -m ninja -C builddir install && \
    ldconfig

RUN pkg-config --modversion cairo
