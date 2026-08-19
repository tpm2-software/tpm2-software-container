# Use the official Nix container as the base image.
# This image provides the Nix package manager, but it is not a full NixOS
# system.
#
# Pin the Nix package manager version for reproducible container builds.
# The nixpkgs revision used below independently defines the build environment.
FROM nixos/nix:2.30.2

LABEL org.opencontainers.image.source="https://github.com/tpm2-software/tpm2-software-container"

# Define the common CI build environment using a pinned nixpkgs revision.
#
# The NIX_DEV_* and NIX_PKCS11_* m4 hooks allow the derived dev and pkcs11
# images to extend the same Nix shell without duplicating this Dockerfile.
RUN cat > /ci-shell.nix <<'EOF'
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/70cc4559b10a6062b05ff1af17e0add065ccaed9.tar.gz") {} }:

pkgs.mkShell {
  # Disable Nix's implicit _FORTIFY_SOURCE injection. The tpm2-software CI
  # controls the compiler flags itself, and some CI configurations require
  # builds without the fortify flags added by the Nix compiler wrapper.
  hardeningDisable = [ "fortify" ];

  nativeBuildInputs = with pkgs; [
    autoconf
    autoconf-archive
    automake
    libtool
    pkg-config
    gnumake
    gcc
    bashInteractive
    coreutils
    gnused
    gnugrep
    findutils
    gawk
    which
    git
    swtpm
    libtpms
    shadow
    clang
    clang-tools
    expect
    dbus

ifdef(`NIX_DEV_NATIVE_EXTRA', `NIX_DEV_NATIVE_EXTRA')
ifdef(`NIX_PKCS11_NATIVE_EXTRA', `NIX_PKCS11_NATIVE_EXTRA')

    (python3.withPackages (python-pkgs: with python-pkgs; [
      pyyaml
ifdef(`NIX_DEV_PYTHON_EXTRA', `NIX_DEV_PYTHON_EXTRA')
ifdef(`NIX_PKCS11_PYTHON_EXTRA', `NIX_PKCS11_PYTHON_EXTRA')
    ]))

    (perl.withPackages (perlPackages: with perlPackages; [
      DigestSHA
    ]))
  ];

  # clang and clang-tools are intentionally present in buildInputs as well.
  # Existing CI scripts invoke clang-based tools outside a normal Nix
  # derivation, and the autotools test environment relies on the corresponding
  # environment hooks.
  buildInputs = with pkgs; [
    clang
    clang-tools
    libtpms
    openssl
    curl
    json_c
    cmocka
    uthash
    iproute2
    glib
    glib.dev

ifdef(`NIX_DEV_BUILD_EXTRA', `NIX_DEV_BUILD_EXTRA')
ifdef(`NIX_PKCS11_BUILD_EXTRA', `NIX_PKCS11_BUILD_EXTRA')
  ];
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.libtpms ]
                    + ":/usr/local/lib";
}
EOF

# dbus-run-session/dbus-daemon expect a session bus configuration at
# /etc/dbus-1/session.conf. This minimal Nix-based container does not provide
# a system-wide DBus configuration tree, so provide the required session bus
# configuration directly.
RUN mkdir -p /etc/dbus-1 && \
    cat > /etc/dbus-1/session.conf <<'EOF'
<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
  <type>session</type>

  <listen>unix:tmpdir=/tmp</listen>

  <standard_session_servicedirs />

  <policy context="default">
    <allow send_destination="*"/>
    <allow send_interface="*"/>
    <allow receive_sender="*"/>
    <allow own="*"/>
  </policy>
</busconfig>
EOF

# Realize the complete shell environment while building the image.
RUN nix-shell /ci-shell.nix --run 'true'

# The existing tpm2-software CI infrastructure invokes /bin/bash directly.
# Obtain Bash from the pinned nixpkgs environment and keep a stable reference
# to the real Bash binary.
RUN mkdir -p /real-bin /bin && \
    nix-shell /ci-shell.nix --run \
      'ln -sf "$(readlink -f "$(command -v bash)")" /real-bin/bash'

# From this point on, execute Dockerfile RUN commands through the real Bash.
SHELL ["/real-bin/bash", "-c"]

# Keep the existing tpm2-software interface:
#
#   /bin/bash -c "$DOCKER_BUILD_DIR/.ci/docker.run"
#
# The top-level command enters the pinned Nix shell. Child Bash invocations
# detected through IN_NIX_SHELL use the real Bash directly so generated
# scripts such as config.status can pass their arguments unchanged.
RUN cat > /tmp/bash-wrapper <<'EOF'
#!/real-bin/bash
set -e

if [ -n "${IN_NIX_SHELL:-}" ]; then
    exec /real-bin/bash "$@"
fi

if [ "$1" = "-c" ]; then
    shift
    exec nix-shell /ci-shell.nix --run "$*"
fi

exec nix-shell /ci-shell.nix --command /real-bin/bash
EOF

RUN rm -f /bin/bash && \
    mv /tmp/bash-wrapper /bin/bash && \
    chmod +x /bin/bash

ENV PATH=/root/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/bin:/usr/local/sbin:/usr/local/bin

WORKDIR /workspace
