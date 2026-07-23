## LibreSSL 2.3.4
ENV LIBRE_VERSION=3.5.3

RUN cd /tmp \
        && curl -L https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-$LIBRE_VERSION.tar.gz \
                -o libressl-$LIBRE_VERSION.tar.gz \
        && tar -xavf libressl-$LIBRE_VERSION.tar.gz \
        && cd libressl-$LIBRE_VERSION \
        && ./configure \
        && make -j$(nproc) \
        && make install \
        && ldconfig \
        && cd / \
        && rm -rf /tmp/libressl-$LIBRE_VERSION /tmp/libressl-$LIBRE_VERSION.tar.gz
