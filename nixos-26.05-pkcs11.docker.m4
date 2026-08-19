# Add tpm2-pkcs11 build and integration-test dependencies on top of the
# NixOS 26.05 development image.

define(`NIX_PKCS11_NATIVE_EXTRA', `
    sqlite
    opensc
    gnutls
    nss.tools
    tpm2-abrmd
    jdk
    glibc.bin
')

define(`NIX_PKCS11_BUILD_EXTRA', `
    sqlite
    libyaml
    p11-kit
')

define(`NIX_PKCS11_PYTHON_EXTRA', `
      cryptography
      bcrypt
')

include(`nixos-26.05-dev.docker.m4')

# Dependencies built by the tpm2-pkcs11 CI are installed below /usr/local.
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig

# The tpm2-pkcs11 integration tests use `arch` to determine the machine
# architecture. Provide an equivalent implementation using uname -m.
RUN mkdir -p /usr/local/bin && \
    cat > /usr/local/bin/arch <<'EOF'
#!/real-bin/bash
exec uname -m
EOF

RUN chmod +x /usr/local/bin/arch

# JUnit and Hamcrest are required by the Java integration tests. Keep the
# versions aligned with modules/junit.m4 used by the other PKCS#11 images.
RUN nix-shell /ci-shell.nix --run '\
    mkdir -p /java && \
    curl -L --fail --retry 3 \
      -o /java/junit.jar \
      "https://search.maven.org/remotecontent?filepath=junit/junit/4.13/junit-4.13.jar" && \
    curl -L --fail --retry 3 \
      -o /java/hamcrest.jar \
      "https://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest/2.2/hamcrest-2.2.jar"'

ENV CLASSPATH=/java/hamcrest.jar:/java/junit.jar
