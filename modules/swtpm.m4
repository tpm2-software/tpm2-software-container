RUN git -C /tmp clone --depth=1 https://github.com/stefanberger/libtpms.git \
	&& cd /tmp/libtpms \
	&& ./autogen.sh --prefix=/usr $LIBTPMS_AUTOGEN_EXTRA --with-openssl --with-tpm2 \
	&& make -j$(nproc) \
	&& make install \
	&& rm -fr /tmp/libtpms \
	&& git -C /tmp clone --depth=1 https://github.com/stefanberger/swtpm.git \
	&& cd /tmp/swtpm \
	&& ./autogen.sh --prefix=/usr \
	&& make -j$(nproc) $SWTPM_MAKE_EXTRA \
	&& make install \
	&& rm -fr /tmp/swtpm
