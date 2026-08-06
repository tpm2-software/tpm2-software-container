RUN dnf -y install \
    CENTOS_JAVA \
    CENTOS_OPENSSL_PKCS11 \
    hamcrest \
    junit \
    nss-tools \
    python3-bcrypt \
    python3-cryptography \
    python3-pyasn1 \
    python3-pyasn1-modules \
    python3-setuptools \
    && python3 -m pip install --no-cache-dir python-pkcs11 \
    && dnf clean all \
    && rm -rf /var/cache/dnf /root/.cache/pip
