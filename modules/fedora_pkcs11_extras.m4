RUN dnf -y install \
    hamcrest \
    java-latest-openjdk \
    java-latest-openjdk-devel \
    junit \
    nss-tools \
    openssl-pkcs11 \
    python3-bcrypt \
    python3-cryptography \
    python3-pip \
    python3-pyasn1 \
    python3-pyasn1-modules \
    python3-pyyaml \
    python3-setuptools \
    && python3 -m pip install --no-cache-dir python-pkcs11 \
    && dnf clean all \
    && rm -rf /var/cache/dnf /root/.cache/pip
