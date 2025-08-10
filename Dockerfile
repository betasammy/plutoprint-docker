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
    curl -LO https://cairographics.org/releases/cairo-1.18.4.tar.xz && \
    tar xf cairo-1.18.4.tar.xz && \
    cd cairo-1.18.4 && \
    meson setup build && \
    meson install -C build

RUN pkg-config --modversion cairo
