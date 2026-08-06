RUN pacman -Sy --noconfirm \
    doxygen \
    lcov \
    pandoc \
    python-pip \
    xxd \
    && pacman -Scc --noconfirm
ENV PIP_BREAK_SYSTEM_PACKAGES=1
RUN python3 -m pip install --no-cache-dir --break-system-packages \
    compiledb \
    && rm -rf /root/.cache/pip
