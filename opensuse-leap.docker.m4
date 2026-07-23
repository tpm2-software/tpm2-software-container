FROM opensuse/leap

LABEL org.opencontainers.image.source="https://github.com/tpm2-software/tpm2-software-container"

include(`opensuse_leap_base_deps.m4')

include(`ibmtpm1682.m4')

# make install goes into /usr/local/lib/pkgconfig which is non-standard
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

ENV LIBTPMS_AUTOGEN_EXTRA="--libdir=/usr/lib64"
ENV SWTPM_MAKE_EXTRA="CFLAGS=\"-I/usr/include/libseccomp/\""
include(`swtpm.m4')

include(`uthash.m4')
