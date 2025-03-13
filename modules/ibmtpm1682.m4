ARG ibmtpm_name=ibmtpm1682
RUN cd /tmp \
	&& wget $WGET_EXTRA_FLAGS -L "https://downloads.sourceforge.net/project/ibmswtpm2/$ibmtpm_name.tar.gz" \
	&& sha1sum $ibmtpm_name.tar.gz | grep ^651800d0b87cfad55b004fbdace4e41dce800a61 \
	&& mkdir -p $ibmtpm_name \
	&& tar xv --no-same-owner -f $ibmtpm_name.tar.gz -C $ibmtpm_name \
	&& rm $ibmtpm_name.tar.gz \
	&& cd $ibmtpm_name/src \
	&& sed -i 's/0x300000ff/0x310000ff/' TpmToOsslMath.h \
	&& sed -i 's/-DTPM_NUVOTON/-DTPM_NUVOTON $(CFLAGS)/' makefile \
	&& CFLAGS="-DNV_MEMORY_SIZE=32768 -DMIN_EVICT_OBJECTS=7" make -j$(nproc) \
	&& cp tpm_server /usr/local/bin \
	&& rm -fr /tmp/$ibmtpm_name
