ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y \
    autoconf \
    autoconf-archive \
    automake \
    build-essential \
    clang-22 \
    clang-tools-22 \
    curl \
    dbus-x11 \
    expect \
    g++ \
    gawk \
    gcc \
    git \
    gnulib \
    iproute2 \
    libcmocka-dev \
    libcmocka0 \
    libcurl4-openssl-dev \
    libdbus-1-dev \
    libgcrypt20-dev \
    libglib2.0-dev \
    libjson-c-dev \
    libseccomp-dev \
    libsqlite3-dev \
    libssl-dev \
    libtasn1-6-dev \
    libtool \
    libtpms-dev \
    libyaml-dev \
    m4 \
    net-tools \
    opensc \
    pkg-config \
    python3 \
    socat \
    sqlite3 \
    swtpm \
    uthash-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-22 100
RUN update-alternatives --install /usr/bin/scan-build scan-build /usr/bin/scan-build-22 100
