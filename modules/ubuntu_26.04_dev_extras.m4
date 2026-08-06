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
    && update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-22 100 \
    && update-alternatives --install /usr/bin/run-clang-tidy run-clang-tidy /usr/bin/run-clang-tidy-22 100 \
    && update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-22 100 \
    && rm -rf /var/lib/apt/lists/*
ENV PIP_BREAK_SYSTEM_PACKAGES=1
RUN python3 -m pip install --no-cache-dir --break-system-packages \
    compiledb \
    && rm -rf /root/.cache/pip
