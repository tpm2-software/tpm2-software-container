FROM ubuntu:26.04

LABEL org.opencontainers.image.source="https://github.com/tpm2-software/tpm2-software-container"

include(`ubuntu_26.04_base_deps.m4')
include(`ibmtpm1682.m4')

WORKDIR /
