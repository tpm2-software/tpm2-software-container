RUN apk add --no-cache \
    clang \
    clang-analyzer \
    clang-extra-tools \
    compiler-rt \
    doxygen \
    lcov \
    pandoc \
    py3-pip \
    vim \
    xxd
ENV PIP_BREAK_SYSTEM_PACKAGES=1
RUN python3 -m pip install --no-cache-dir --break-system-packages \
    compiledb \
    && rm -rf /root/.cache/pip
