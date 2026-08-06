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
ENV PIP_BREAK_SYSTEM_PACKAGES=1
RUN python3 -m pip install --no-cache-dir --break-system-packages \
    compiledb \
    && rm -rf /root/.cache/pip
