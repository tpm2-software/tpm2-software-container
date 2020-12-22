ARG autoconf_archive=autoconf-archive-2018.03.13
WORKDIR /tmp
RUN wget --quiet --show-progress --progress=dot:giga "http://mirror.kumi.systems/gnu/autoconf-archive/$autoconf_archive.tar.xz" \
		&& tar -xf $autoconf_archive.tar.xz \
        && rm $autoconf_archive.tar.xz \
        && cd $autoconf_archive \
        && ./configure --prefix=/usr \
        && make -j $(nproc) && make install
RUN rm -fr $autoconf_archive.tar.xz

