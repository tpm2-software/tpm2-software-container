ARG pyver="3.7.2"
RUN cd /tmp \
	&& wget --quiet --show-progress --progress=dot:giga "https://github.com/python/cpython/archive/v${pyver}.tar.gz" \
	&& tar -xf v${pyver}.tar.gz \
	&& cd cpython-${pyver}/ \
	&& ./configure \
	&& make -j$(nproc) \
	&& make altinstall \
	&& rm -fr /tmp/v${pyver}.tar.gz /tmp/cpython-${pyver}

RUN update-alternatives --install "/usr/bin/python3" "python3" "$(which python3.7)" 100
RUN update-alternatives --install "/usr/bin/pip3" "pip3" "$(which pip3.7)" 100
