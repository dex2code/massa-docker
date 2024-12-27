
FROM  mirror.gcr.io/buildpack-deps:bookworm AS builder

ARG   PATH=/usr/local/cargo/bin:$PATH

ARG   RUSTUP_HOME=/usr/local/rustup
ARG   CARGO_HOME=/usr/local/cargo
ARG   RUST_VERSION=1.83.0
ARG   RUST_ARCH=x86_64-unknown-linux-gnu

ARG   MASSA_VERSION=MAIN.2.4

WORKDIR  /

RUN   set -eux; \
      wget "https://static.rust-lang.org/rustup/archive/1.27.1/${RUST_ARCH}/rustup-init"; \
      chmod +x rustup-init; \
      ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION --default-host ${RUST_ARCH}; \
      rm rustup-init; \
      chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
      rustup --version; \
      cargo --version; \
      rustc --version;

RUN   apt-get update \
      && apt-get -y install pkg-config curl git build-essential libssl-dev libclang-dev cmake \
      && apt-get clean

RUN   git clone https://github.com/massalabs/massa.git

WORKDIR  /massa
RUN      git checkout $MASSA_VERSION
RUN      RUST_BACKTRACE=full cargo build --release



FROM  mirror.gcr.io/ubuntu:latest AS massa

ARG   MASSA_UID=981
ARG   MASSA_GID=981
ARG   MASSA_HOME="/home/massa"

RUN   groupadd -g ${MASSA_GID} massa
RUN   useradd -d ${MASSA_HOME} -g massa -m -s /sbin/nologin -u ${MASSA_UID} massa
RUN   mkdir -p ${MASSA_HOME}/massa-node ${MASSA_HOME}/massa-client

COPY  --from=builder /massa/massa-node/ ${MASSA_HOME}/massa-node/
COPY  --from=builder /massa/massa-client/ ${MASSA_HOME}/massa-client/

COPY  --from=builder /massa/target/release/massa-node ${MASSA_HOME}/massa-node/
COPY  --from=builder /massa/target/release/massa-client ${MASSA_HOME}/massa-client/

COPY  massa-start.sh ${MASSA_HOME}/massa-node/
COPY  massa-client.sh ${MASSA_HOME}/massa-node/
RUN   chmod +x ${MASSA_HOME}/massa-node/*.sh

RUN   echo "[network]\n    #routable_ip = \"\"\n\n[bootstrap]\n    retry_delay = 15000\n" \
      > ${MASSA_HOME}/massa-node/config/config.toml

RUN   chown -R massa:massa ${MASSA_HOME}


EXPOSE   31244/tcp 31245/tcp 31248/tcp 33035/tcp 33036/tcp 33037/tcp
USER     massa
WORKDIR  ${MASSA_HOME}/massa-node
CMD      ["./massa-start.sh"]
