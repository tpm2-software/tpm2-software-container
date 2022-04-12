#
# upgrade pip first so packages are not reinstalled using a version other than what may have been specified
#
RUN python3 -m pip install --upgrade pip
# install everything in one shot so we don't get a newer version of a package we specified. Ie if a module has dep on cryptogtraphy
# and we install it in different phases pip will upgrade cryptography
RUN if [ -n "$PYCRYPTO_VERSION" ]; then \
    python3 -m pip install cryptography==$PYCRYPTO_VERSION pyyaml cpp-coveralls pyasn1 pyasn1_modules python-pkcs11 bcrypt setuptools; \
else \
    python3 -m pip install cryptography pyyaml cpp-coveralls pyasn1 pyasn1_modules python-pkcs11 bcrypt setuptools; \
fi
