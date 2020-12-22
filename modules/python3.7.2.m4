ARG pyver="3.7.2"
WORKDIR /tmp
RUN wget --quiet --show-progress --progress=dot:giga "https://github.com/python/cpython/archive/v${pyver}.tar.gz" \
	&& tar -xf v${pyver}.tar.gz
RUN cd cpython-${pyver}/ \
	&& ./configure \
	&& make -j$(nproc) \
	&& make altinstall
