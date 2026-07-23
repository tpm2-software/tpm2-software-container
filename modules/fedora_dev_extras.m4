RUN dnf -y install \
    clang \
    clang-analyzer \
    clang-tools-extra \
    doxygen \
    lcov \
    pandoc \
    python3-pyyaml \
    vim-common \
    && dnf clean all \
    && rm -rf /var/cache/dnf
