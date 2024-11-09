
## MBEDTLS 3.6
ENV MBEDTLS_VERSION=v3.6.2
RUN wget --no-verbose https://github.com/Mbed-TLS/mbedtls/archive/refs/tags/$MBEDTLS_VERSION.tar.gz
RUN tar -zxf $MBEDTLS_VERSION.tar.gz --one-top-level=/tmp/
RUN ls /tmp
WORKDIR /tmp/mbedtls-3.6.2
RUN make -j \
	&& make -j \
	&& make install \
	&& ldconfig
