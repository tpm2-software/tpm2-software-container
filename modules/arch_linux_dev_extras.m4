RUN pacman -Sy --noconfirm \
    doxygen \
    lcov \
    pandoc \
    xxd \
    && pacman -Scc --noconfirm
