RUN if [ -n "$PYCRYPTO_VERSION" ]; then \
    python3 -m pip install cryptography==$PYCRYPTO_VERSION; \
else \
    python3 -m pip install cryptography; \
fi

RUN python3 -m pip install --upgrade pip \
	&& python3 -m pip install pyyaml cpp-coveralls pyasn1 pyasn1_modules python-pkcs11 bcrypt setuptools
