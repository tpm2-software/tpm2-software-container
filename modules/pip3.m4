#
# upgrade pip first so packages are not reinstalled using a version other than what may have been specified
#
RUN python3 -m pip install --upgrade pip
# install everything in one shot so we don't get a newer version of a package we specified. Ie if a module has dep on cryptogtraphy
# and we install it in different phases pip will upgrade cryptography
RUN pkgs="cryptography==$PYCRYPTO_VERSION pyyaml cpp-coveralls pyasn1 pyasn1_modules python-pkcs11 \
          bcrypt==$PYBCRYPT_VERSION setuptools"; \
    pkgs=$(echo "$pkgs" | sed -E 's/==\s+/ /g'); \
    python3 -m pip install $pkgs
