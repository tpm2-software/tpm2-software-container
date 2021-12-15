## CURL
ENV CURL_VERSION=7.80.0
WORKDIR /tmp/
RUN wget --no-verbose https://curl.se/download/curl-$CURL_VERSION.tar.gz
RUN tar -zxf curl-$CURL_VERSION.tar.gz
WORKDIR /tmp/curl-$CURL_VERSION
RUN autoreconf -fi \
	&& ./configure --prefix=/usr --with-openssl \
 	&& make -j install
