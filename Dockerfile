FROM quay.io/pypa/manylinux_2_28_x86_64:latest

ENV PYTHON3=/opt/python/cp311-cp311/bin/python3
ENV PATH="/opt/python/cp311-cp311/bin:${PATH}"

RUN $PYTHON3 -m ensurepip && \
    $PYTHON3 -m pip install --upgrade pip && \
    $PYTHON3 -m pip install meson ninja

RUN dnf install -y \
        wget \
        pkgconfig

RUN cd /tmp && \
    wget https://www.cairographics.org/releases/cairo-1.18.4.tar.xz && \
    tar xf cairo-1.18.4.tar.xz && \
    cd cairo-1.18.4 && \
    meson setup build \
        -Dwrap_mode=default \
        -Dfontconfig=enabled \
        -Dfreetype=enabled \
        -Dpng=enabled \
        -Dzlib=enabled \
        -Dtests=disabled \
        -Dglib=disabled \
        -Dxcb=disabled && \
    meson install -C build

RUN pkg-config --modversion cairo
