ARG libtpms_version=0.10.2
ARG swtpm_version=0.10.1
COPY patches/libtpms.patch /tmp/libtpms.patch
RUN cd /tmp/ \
    && wget $WGET_EXTRA_FLAGS https://github.com/stefanberger/libtpms/archive/refs/tags/v$libtpms_version.tar.gz \
    && (tar xv --no-same-owner -f v$libtpms_version.tar.gz \
	|| python3 -c 'import sys, tarfile; archive="/tmp/v%s.tar.gz" % sys.argv[1]; dest="/tmp"; tarfile.open(archive, "r:gz").extractall(dest)' "$libtpms_version") \
	&& cd /tmp/libtpms-$libtpms_version \
	&& ./autogen.sh --prefix=/usr $LIBTPMS_AUTOGEN_EXTRA --with-openssl --with-tpm2 \
        && (command -d patch && patch -p1 < /tmp/libtpms.patch || true) \
	&& make -j$(nproc) \
	&& make install \
    && cd /tmp/ \
	&& rm -fr /tmp/libtpms-$libtpms_version \
    && rm -f /tmp/v$libtpms_version.tar.gz \
    && wget $WGET_EXTRA_FLAGS https://github.com/stefanberger/swtpm/archive/refs/tags/v$swtpm_version.tar.gz \
    && (tar xv --no-same-owner -f v$swtpm_version.tar.gz \
	|| python3 -c 'import sys, tarfile; archive="/tmp/v%s.tar.gz" % sys.argv[1]; dest="/tmp"; tarfile.open(archive, "r:gz").extractall(dest)' "$swtpm_version") \
	&& cd /tmp/swtpm-$swtpm_version \
	&& ./autogen.sh --prefix=/usr \
	&& make -j$(nproc) $SWTPM_MAKE_EXTRA \
	&& make install \
    && cd /tmp/ \
	&& rm -fr /tmp/swtpm-$swtpm_version \
    && rm -f /tmp/v$swtpm_version.tar.gz \
    && rm /tmp/libtpms.patch
