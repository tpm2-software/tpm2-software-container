
## MBEDTLS 3.6
ENV MBEDTLS_VERSION=v3.6.7

RUN git clone --depth 1 --branch ${MBEDTLS_VERSION} --recurse-submodules --shallow-submodules \
	https://github.com/Mbed-TLS/mbedtls.git /tmp/mbedtls

WORKDIR /tmp/mbedtls

RUN pip3 install --no-cache-dir --break-system-packages -r scripts/basic.requirements.txt \
	&& make -j \
	&& make install \
	&& ldconfig
