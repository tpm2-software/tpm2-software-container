ARG ibmtpm_name=ibmtpm1637
RUN cd /tmp \
	&& wget $WGET_EXTRA_FLAGS -L "https://downloads.sourceforge.net/project/ibmswtpm2/$ibmtpm_name.tar.gz" \
	&& sha256sum $ibmtpm_name.tar.gz | grep ^dd3a4c3f7724243bc9ebcd5c39bbf87b82c696d1c1241cb8e5883534f6e2e327 \
	&& mkdir -p $ibmtpm_name \
	&& tar xv --no-same-owner -f $ibmtpm_name.tar.gz -C $ibmtpm_name \
	&& rm $ibmtpm_name.tar.gz \
	&& cd $ibmtpm_name/src \
	&& sed -i 's/-DTPM_NUVOTON/-DTPM_NUVOTON $(CFLAGS)/' makefile \
	&& CFLAGS="-DNV_MEMORY_SIZE=32768 -DMIN_EVICT_OBJECTS=7" make -j$(nproc) \
	&& cp tpm_server /usr/local/bin \
	&& rm -fr /tmp/$ibmtpm_name
