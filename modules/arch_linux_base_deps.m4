RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm base base-devel
RUN pacman -Scc --noconfirm
RUN pacman -Sy --noconfirm \
    autoconf \
    autoconf-archive \
    automake \
    cmocka \
    curl \
    expect \
    gcc \
    git \
    glib2 \
    glib2-devel \
    iproute2 \
    json-c \
    libftdi \
    libltdl \
    libtool \
    libusb \
    openssl \
    perl \
    pkg-config \
    pkgfile \
    procps \
    python-yaml \
    swtpm \
    uthash \
    util-linux \
    wget \
    && pacman -Scc --noconfirm
RUN ln -s /usr/bin/core_perl/shasum /usr/bin/
