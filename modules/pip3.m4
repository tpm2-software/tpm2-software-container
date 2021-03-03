ARG CRYPTOGRAPHY_DONT_BUILD_RUST=1
RUN python3 -m pip install pyyaml cpp-coveralls pyasn1 pyasn1_modules python-pkcs11
