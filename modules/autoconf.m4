ARG autoconf_archive=autoconf-archive-2018.03.13
RUN cd /tmp \
	&& wget --quiet --show-progress --progress=dot:giga "http://mirror.kumi.systems/gnu/autoconf-archive/$autoconf_archive.tar.xz" \
	&& tar -xf $autoconf_archive.tar.xz \
	&& rm $autoconf_archive.tar.xz \
	&& cd $autoconf_archive \
	&& ./configure --prefix=/usr \
	&& make -j $(nproc) && make install \
	&& rm -fr /tmp/$autoconf_archive.tar.xz /tmp/$autoconf_archive

