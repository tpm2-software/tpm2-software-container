ARG version=0.10.1
RUN cd /tmp/ \
    && wget $WGET_EXTRA_FLAGS -L https://github.com/stefanberger/libtpms/archive/refs/tags/v$version.tar.gz \
    && tar xv --no-same-owner -f v$version.tar.gz \
	&& cd /tmp/libtpms-$version \
	&& ./autogen.sh --prefix=/usr $LIBTPMS_AUTOGEN_EXTRA --with-openssl --with-tpm2 \
	&& make -j$(nproc) \
	&& make install \
    && cd /tmp/ \
	&& rm -fr /tmp/libtpms-$version \
    && rm -f /tmp/v$version.tar.gz \
    && wget $WGET_EXTRA_FLAGS -L https://github.com/stefanberger/swtpm/archive/refs/tags/v$version.tar.gz \
    && tar xv --no-same-owner -f v$version.tar.gz \
	&& cd /tmp/swtpm-$version \
	&& ./autogen.sh --prefix=/usr \
	&& make -j$(nproc) $SWTPM_MAKE_EXTRA \
	&& make install \
    && cd /tmp/ \
	&& rm -fr /tmp/swtpm-$version \
    && rm -f /tmp/v$version.tar.gz
