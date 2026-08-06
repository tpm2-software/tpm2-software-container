include(`ubuntu-24.04.docker.m4')
ENV PIP_BREAK_SYSTEM_PACKAGES=1
RUN python3 -m pip install --no-cache-dir --break-system-packages \
    compiledb \
    && rm -rf /root/.cache/pip

