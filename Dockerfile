FROM quay.io/pypa/manylinux_2_28_x86_64:latest

RUN dnf install -y \
        wget \
        pkgconfig \
        cairo-devel \
        expat-devel \
        libicu-devel \
        freetype-devel \
        fontconfig-devel \
        harfbuzz-devel \
        libcurl-devel \
        turbojpeg-devel \
        libwebp-devel

ENV PYTHON3=/opt/python/cp311-cp311/bin/python3

RUN $PYTHON3 -m pip install --upgrade pip && \
    $PYTHON3 -m pip install meson ninja

RUN cd /tmp && \
    wget https://download.savannah.gnu.org/releases/freetype/freetype-2.13.3.tar.xz && \
    tar xf freetype-2.13.3.tar.xz && \
    cd freetype-2.13.3 && \
    $PYTHON3 -m meson setup build && \
    $PYTHON3 -m meson install -C build

RUN pkg-config --modversion freetype
