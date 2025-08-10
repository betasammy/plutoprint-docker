FROM quay.io/pypa/manylinux_2_28_x86_64:latest

RUN dnf install -y \
        cairo-devel \
        expat-devel \
        libicu-devel \
        freetype-devel \
        fontconfig-devel \
        harfbuzz-devel \
        libcurl-devel \
        turbojpeg-devel \
        libwebp-devel \
        ninja-build \
        meson \
        pkgconfig

RUN cd /tmp && \
    curl -LO https://download.savannah.gnu.org/releases/freetype/freetype-2.13.3.tar.xz && \
    tar xf freetype-2.13.3.tar.xz && \
    cd freetype-2.13.3 && \
    meson setup build && \
    meson install -C build

RUN pkg-config --modversion freetype
