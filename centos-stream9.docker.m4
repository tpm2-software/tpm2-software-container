FROM quay.io/centos/centos:stream9

LABEL org.opencontainers.image.source="https://github.com/tpm2-software/tpm2-software-container"

RUN dnf -y install epel-release dnf-plugins-core \
    && dnf config-manager --set-enabled crb

define(`CENTOS_JAVA', `java-17-openjdk java-17-openjdk-devel')dnl
define(`CENTOS_LIBUSB_DEVEL', `libusb-devel')dnl
define(`CENTOS_OPENSSL_PKCS11', `openssl-pkcs11')dnl
include(`centos_base_deps.m4')
include(`ibmtpm1682.m4')
include(`swtpm.m4')

# make install goes into /usr/local/lib/pkgconfig which is non-standard
# Set this so ./configure can find things and we don't have to worry about prefix changes
# to build instructions
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
ENV CLASSPATH=/usr/share/java/hamcrest/hamcrest.jar:/usr/share/java/junit.jar

WORKDIR /
