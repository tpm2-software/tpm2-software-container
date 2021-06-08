ARG uthash="2.1.0"
RUN cd /tmp \
	&& wget $WGET_EXTRA_FLAGS -L  "https://github.com/troydhanson/uthash/archive/v${uthash}.tar.gz" \
	&& tar -xf v${uthash}.tar.gz \
	&& cp uthash-${uthash}/src/*.h /usr/include/ \
	&& rm -fr /tmp/v${uthash}.tar.gz /tmp/uthash-${uthash}
