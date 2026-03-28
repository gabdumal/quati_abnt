FROM fedora:latest

# Create dummy xdg-open to prevent programs that would like to open applications from crashing
RUN printf '#!/bin/sh\nexit 0\n' > /usr/local/bin/xdg-open && chmod +x /usr/local/bin/xdg-open

# Install system dependencies
RUN dnf upgrade -y
RUN dnf install -y \
    ca-certificates \
    curl \
    gcc \
    git \
    libatomic \
    openssl-devel

# Install project dependencies
RUN dnf install -y \
    liberation-fonts \
    make \
    perl \
    pkgconf-pkg-config

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable
ENV CARGO_HOME="/root/.cargo"
ENV CARGO_TARGET="/workspace/target"
ENV PATH="$CARGO_HOME/bin:$PATH"

# Install Typst
RUN cargo install typst-cli --locked
RUN cargo install hayagriva --features cli

# Install Typst package: quati_abnt
ARG QUATI_ABNT_VERSION
ENV QUATI_ABNT_VERSION=$QUATI_ABNT_VERSION
ENV QUATI_ABNT_PATH=/root/.local/share/typst/packages/preview/quati-abnt
RUN mkdir -p $QUATI_ABNT_PATH/$QUATI_ABNT_VERSION

RUN ln -s /workspace/typst.toml $QUATI_ABNT_PATH/$QUATI_ABNT_VERSION/typst.toml
RUN ln -s /workspace/src $QUATI_ABNT_PATH/$QUATI_ABNT_VERSION/src
RUN ln -s /workspace/README.md $QUATI_ABNT_PATH/$QUATI_ABNT_VERSION/README.md
