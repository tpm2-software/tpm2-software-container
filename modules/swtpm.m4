WORKDIR /tmp
RUN git clone https://github.com/stefanberger/libtpms.git
RUN cd libtpms \
	&& ./autogen.sh --prefix=/usr $LIBTPMS_AUTOGEN_EXTRA --with-openssl --with-tpm2 \
	&& make -j$(nproc) \
	&& make install

WORKDIR /tmp
RUN git clone https://github.com/stefanberger/swtpm.git
RUN cd swtpm \
	&& ./autogen.sh --prefix=/usr \
	&& make -j$(nproc) $SWTPM_MAKE_EXTRA \
	&& make install
