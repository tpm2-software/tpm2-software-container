RUN pacman -Sy --noconfirm \
    jdk-openjdk \
    nss \
    && pacman -Scc --noconfirm
