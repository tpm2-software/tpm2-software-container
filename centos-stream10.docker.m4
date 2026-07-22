FROM quay.io/centos/centos:stream10

LABEL org.opencontainers.image.source="https://github.com/tpm2-software/tpm2-software-container"

# can return 100 if packages need update
RUN dnf check-update; \
    rc=$?; \
    if [ $rc -ne 100 ] && [ $rc -ne 0 ]; then \
        echo "dnf check-update failed: $rc"; \
        exit $rc; \
    fi

RUN dnf -y install epel-release dnf-plugins-core && \
    dnf config-manager --set-enabled crb

define(`CENTOS_JAVA', `java-21-openjdk java-21-openjdk-devel')dnl
define(`CENTOS_LIBUSB_DEVEL', `libusb1-devel')dnl
define(`CENTOS_OPENSSL_PKCS11', `')dnl
include(`centos_base_deps.m4')
include(`ibmtpm1682.m4')
include(`swtpm.m4')

# make install goes into /usr/local/lib/pkgconfig which is non-standard
# Set this so ./configure can find things and we don't have to worry about prefix changes
# to build instructions
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
ENV CLASSPATH=/usr/share/java/hamcrest/hamcrest.jar:/usr/share/java/junit.jar

WORKDIR /
