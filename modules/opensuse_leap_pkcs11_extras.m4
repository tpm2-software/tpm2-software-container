RUN zypper -n in \
    java-17-openjdk \
    java-17-openjdk-devel \
    mozilla-nss-tools \
    openssl-engine-libp11 \
    python3-devel \
    python3-pip \
    && zypper clean --all
