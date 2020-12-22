ARG uthash="2.1.0"
WORKDIR /tmp
RUN wget --quiet --show-progress --progress=dot:giga "https://github.com/troydhanson/uthash/archive/v${uthash}.tar.gz" \
	&& tar -xf v${uthash}.tar.gz \
        && cp uthash-${uthash}/src/*.h /usr/include/
RUN rm -rf uthash-${uthash}/ v${uthash}.tar.gz
