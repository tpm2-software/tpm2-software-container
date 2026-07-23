## OpenSSL 3
ENV OSSL_VERSION=3.0.0
RUN cd /tmp \
    && realpath $(ldconfig -p \
        | grep libcrypto.so.1 \
        | sed 's/.* \//\//') \
        | sed 's/^\/usr\///' \
        | sed 's/\/libcrypto.*//' > /tmp/libdir \
    && wget --no-verbose https://www.openssl.org/source/openssl-$OSSL_VERSION.tar.gz \
    && tar -zxf openssl-$OSSL_VERSION.tar.gz \
    && cd openssl-$OSSL_VERSION \
    && ./config --prefix=/usr no-deprecated \
    && make -j$(nproc) \
    && make LIBDIR=$(cat /tmp/libdir) install \
    && ldconfig \
    && cd / \
    && rm -rf /tmp/openssl-$OSSL_VERSION /tmp/openssl-$OSSL_VERSION.tar.gz /tmp/libdir
