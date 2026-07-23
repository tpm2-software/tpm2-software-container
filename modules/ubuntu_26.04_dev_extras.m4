RUN apt-get update && \
    apt-get install -y \
    acl \
    bear \
    clang-format-22 \
    clang-tidy-22 \
    doxygen \
    gnutls-bin \
    lcov \
    libftdi-dev \
    libgmp-dev \
    libjson-glib-dev \
    libmbedtls-dev \
    libusb-1.0-0-dev \
    pandoc \
    python3-pip \
    rustc \
    uuid-dev \
    vim-common \
    && rm -rf /var/lib/apt/lists/*
