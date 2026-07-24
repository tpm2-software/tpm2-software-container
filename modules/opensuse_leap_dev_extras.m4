RUN zypper -n in \
    cargo \
    doxygen \
    clang \
    clang-tools \
    doxygen \
    lcov \
    libffi-devel \
    pandoc \
    patch \
    python3-PyYAML \
    python3-pip \
    rust \
    vim \
    && zypper clean --all
