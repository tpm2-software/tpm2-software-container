RUN dnf -y install \
    clang \
    clang-analyzer \
    clang-tools-extra \
    doxygen \
    lcov \
    pandoc \
    && dnf clean all \
    && rm -rf /var/cache/dnf
