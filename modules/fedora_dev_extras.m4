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
ENV PIP_BREAK_SYSTEM_PACKAGES=1
RUN python3 -m pip install --no-cache-dir --break-system-packages \
    compiledb \
    && rm -rf /root/.cache/pip
