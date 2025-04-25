# Alpine 3.19 Dockerfile
FROM archlinux:latest

LABEL org.opencontainers.image.source=https://github.com/tpm2-software/tpm2-software-container

RUN pacman -Sy --noconfirm archlinux-keyring 
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm base base-devel
RUN pacman -Scc --noconfirm
RUN pacman -Sy --noconfirm \
    autoconf-archive \
    cmocka \
    procps \
    iproute2 \
    git \
    pkg-config \
    gcc \
    libtool \
    automake \
    openssl \
    uthash \
    autoconf \
    doxygen \
    json-c \
    curl \
    util-linux \
    libltdl \
    libusb \
    libftdi \
    swtpm \
    pkgfile \
    glib2 \
    glib2-devel \
    python-yaml \
    xxd \
    expect \
    perl \
    pandoc \
    lcov
RUN ln -s /usr/bin/core_perl/shasum /usr/bin/

WORKDIR /
 
