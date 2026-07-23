ENV PIP_REQUIRE_VIRTUALENV=0
ENV PIP_BREAK_SYSTEM_PACKAGES=1
RUN apt-get update && \
    apt-get install -y \
    default-jdk \
    default-jre \
    junit4 \
    libengine-pkcs11-openssl \
    libnss3-tools \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*
