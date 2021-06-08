ARG ibmtpm_name=ibmtpm1637
WORKDIR /tmp
RUN wget $WGET_EXTRA_FLAGS -L "https://downloads.sourceforge.net/project/ibmswtpm2/$ibmtpm_name.tar.gz"
RUN sha256sum $ibmtpm_name.tar.gz | grep ^dd3a4c3f7724243bc9ebcd5c39bbf87b82c696d1c1241cb8e5883534f6e2e327
RUN mkdir -p $ibmtpm_name \
	&& tar xv --no-same-owner -f $ibmtpm_name.tar.gz -C $ibmtpm_name \
	&& rm $ibmtpm_name.tar.gz
WORKDIR $ibmtpm_name/src
RUN sed -i 's/-DTPM_NUVOTON/-DTPM_NUVOTON $(CFLAGS)/' makefile
RUN CFLAGS="-DNV_MEMORY_SIZE=32768 -DMIN_EVICT_OBJECTS=7" make -j$(nproc) \
&& cp tpm_server /usr/local/bin
RUN rm -fr $ibmtpm_name/src $ibmtpm_name.tar.gz
