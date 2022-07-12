## LibreSSL 2.3.4
ENV LIBRE_VERSION=3.5.3

RUN curl https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-$LIBRE_VERSION.tar.gz \
        -o libressl-$LIBRE_VERSION.tar.gz

RUN tar -xavf libressl-$LIBRE_VERSION.tar.gz --one-top-level=/tmp/
WORKDIR /tmp/libressl-$LIBRE_VERSION
RUN ./configure \
      && make -j \
      && make install \
      && ldconfig
