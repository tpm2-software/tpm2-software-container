FROM --platform=linux/ppc64le fedora:44

LABEL org.opencontainers.image.source="https://github.com/tpm2-software/tpm2-software-container"

include(`fedora_base_deps.m4')
include(`ibmtpm1682.m4')
include(`junit.m4')

# make install goes into /usr/local/lib/pkgconfig which is non-standard
# Set this so ./configure can find things and we don't have to worry about prefix changes
# to build instructions
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
ENV CLASSPATH=/usr/share/java/hamcrest/hamcrest.jar:/usr/share/java/junit.jar

WORKDIR /
