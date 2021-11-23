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
RUN ./config --prefix=/usr \
	&& make -j \
	&& make LIBDIR=$(cat /tmp/libdir) install \
	&& ldconfig
# RUN rm /tpm/libdir
# RUN rm -rfv /tmp/openssl-$OSSL_VERSION

## CURL
ENV CURL_VERSION=7.80.0
RUN wget --no-verbose https://curl.se/download/curl-$CURL_VERSION.tar.gz
RUN tar -zxf curl-$CURL_VERSION.tar.gz --one-top-level=/tmp/
WORKDIR /tmp/curl-$CURL_VERSION
RUN autoreconf -fi \
	&& ./configure --libdir=/usr/$(cat /tmp/libdir) --prefix=/usr --with-openssl \
 	&& make -j \
	&& make install \
	&& ldconfig
# RUN rm -rfv /tmp/$CURL_VERSION

