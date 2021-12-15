## OpenSSL 3
ENV OSSL_VERSION=3.0.0
RUN realpath $(ldconfig -p \
    | grep libcrypto.so.1| \
    sed 's/.* \//\//')| \
    sed 's/^\/usr\///'| \
    sed 's/\/libcrypto.*//' > /tmp/libdir
RUN wget --no-verbose https://www.openssl.org/source/openssl-$OSSL_VERSION.tar.gz
RUN tar -zxf openssl-$OSSL_VERSION.tar.gz --one-top-level=/tmp/
WORKDIR /tmp/openssl-$OSSL_VERSION
RUN ./config --prefix=/usr no-deprecated \
	&& make -j \
	&& make LIBDIR=$(cat /tmp/libdir) install \
	&& ldconfig
