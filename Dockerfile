FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y \
    autoconf-archive \
    curl \
    libcmocka0 \
    libcmocka-dev \
    net-tools \
    build-essential \
    git \
    pkg-config \
    gcc \
    g++ \
    m4 \
    libtool \
    automake \
    libgcrypt20-dev \
    libssl-dev \
    autoconf \
    gnulib \
    wget \
    doxygen \
    libdbus-1-dev \
    libglib2.0-dev \
    clang-6.0 \
    clang-tools-6.0 \
    pandoc \
    lcov \
    libcurl4-openssl-dev \
    dbus-x11 \
    python-yaml \
    python3-yaml \
    vim-common \
    python3-pip \
    libsqlite3-dev \
    python-cryptography \
    python3-cryptography \
    libengine-pkcs11-openssl \
    libtasn1-6-dev \
    socat \
    libseccomp-dev \
    expect \
    gawk \
    python-pip

RUN pip  install cpp-coveralls pyasn1 pyasn1_modules
RUN pip3 install cpp-coveralls pyasn1 pyasn1_modules
RUN pip install --upgrade pyasn1-modules

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 100
RUN update-alternatives --install /usr/bin/scan-build scan-build /usr/bin/scan-build-6.0 100

# there's a bug where old versions of libpkcs11 engine were install to the wrong directory, but
# we don't want to export the variable and kill off the default engines, so symlink the wrong one
RUN ln -s /usr/lib/ssl/engines/libpkcs11.so /usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/

ARG autoconf_archive=autoconf-archive-2018.03.13
WORKDIR /tmp
RUN wget --quiet --show-progress --progress=dot:giga "http://mirror.kumi.systems/gnu/autoconf-archive/$autoconf_archive.tar.xz" \
		&& tar -xf $autoconf_archive.tar.xz \
        && rm $autoconf_archive.tar.xz \
        && cd $autoconf_archive \
        && ./configure --prefix=/usr \
        && make -j $(nproc) && make install
RUN rm -fr $autoconf_archive.tar.xz

ARG ibmtpm_name=ibmtpm1119
WORKDIR /tmp
RUN wget --quiet --show-progress --progress=dot:giga "https://downloads.sourceforge.net/project/ibmswtpm2/$ibmtpm_name.tar.gz" \
	&& sha256sum $ibmtpm_name.tar.gz | grep ^b9eef79904e276aeaed2a6b9e4021442ef4d7dfae4adde2473bef1a6a4cd10fb \
	&& mkdir -p $ibmtpm_name \
	&& tar xvf $ibmtpm_name.tar.gz -C $ibmtpm_name \
	&& rm $ibmtpm_name.tar.gz
WORKDIR $ibmtpm_name/src
RUN CFLAGS="-I/usr/local/openssl/include" make -j$(nproc) \
&& cp tpm_server /usr/local/bin
RUN rm -fr $ibmtpm_name/src $ibmtpm_name.tar.gz

WORKDIR /tmp
RUN git clone https://github.com/stefanberger/libtpms.git
RUN cd libtpms \
	&& ./autogen.sh --prefix=/usr --with-openssl --with-tpm2 \
	&& make -j$(nproc) \
	&& make install

WORKDIR /tmp
RUN git clone https://github.com/stefanberger/swtpm.git
RUN cd swtpm \
	&& ./autogen.sh --prefix=/usr \
	&& make -j$(nproc) \
	&& make install || true

ARG uthash="2.1.0"
WORKDIR /tmp
RUN wget --quiet --show-progress --progress=dot:giga "https://github.com/troydhanson/uthash/archive/v${uthash}.tar.gz" \
	&& tar -xf v${uthash}.tar.gz \
        && cp uthash-${uthash}/src/*.h /usr/include/
RUN rm -rf uthash-${uthash}/ v${uthash}.tar.gz
