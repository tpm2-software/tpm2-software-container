# installs rust from source

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# $HOME doesn't expand, see https://github.com/moby/moby/issues/28971
ENV PATH="/root/.cargo/bin:${PATH}"
