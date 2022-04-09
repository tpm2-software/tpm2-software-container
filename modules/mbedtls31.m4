
## MBEDTLS 3.1
ENV MBEDTLS_VERSION=v3.1.0
RUN wget --no-verbose https://github.com/Mbed-TLS/mbedtls/archive/refs/tags/$MBEDTLS_VERSION.tar.gz
RUN tar -zxf $MBEDTLS_VERSION.tar.gz --one-top-level=/tmp/
RUN ls /tmp
WORKDIR /tmp/mbedtls-3.1.0
RUN make -j \
	&& make -j \
	&& make install \
	&& ldconfig
