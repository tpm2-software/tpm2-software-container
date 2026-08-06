RUN dnf -y install \
    clang \
    clang-analyzer \
    clang-tools-extra \
    doxygen \
    lcov \
    pandoc \
    python3-pip \
    && dnf clean all \
    && rm -rf /var/cache/dnf
RUN python3 -m pip install --no-cache-dir \
    compiledb \
    && rm -rf /root/.cache/pip
