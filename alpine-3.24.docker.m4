# Alpine 3.24 Dockerfile
FROM alpine:3.24

LABEL org.opencontainers.image.source="https://github.com/tpm2-software/tpm2-software-container"

include(`alpine_base_deps.m4')

include(`ibmtpm1682.m4')
include(`swtpm.m4')

WORKDIR /
