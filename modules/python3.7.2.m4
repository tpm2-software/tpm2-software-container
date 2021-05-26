ARG pyver="3.7.2"
WORKDIR /tmp
RUN wget --quiet --show-progress --progress=dot:giga "https://github.com/python/cpython/archive/v${pyver}.tar.gz" \
	&& tar -xf v${pyver}.tar.gz
RUN cd cpython-${pyver}/ \
	&& ./configure \
	&& make -j$(nproc) \
	&& make altinstall
RUN update-alternatives --install "/usr/bin/python3" "python3" "$(which python3.7)" 100
RUN update-alternatives --install "/usr/bin/"pip3 "pip3" "$(which pip3.7)" 100
