# Arch Linux Dockerfile
FROM archlinux:latest

LABEL org.opencontainers.image.source=https://github.com/tpm2-software/tpm2-software-container

include(`arch_linux_base_deps.m4')
include(`ibmtpm1682.m4')

WORKDIR /
