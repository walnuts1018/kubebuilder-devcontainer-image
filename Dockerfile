FROM debian:bookworm-slim@sha256:99c0b25c46d0214d5a2091092e7908907dcaecd6a962cde0ac700acee222b6f3 AS aqua
ARG AQUA_VERSION=v2.54.0
ENV AQUA_ROOT_DIR=/opt/aqua

RUN apt-get -y update && apt-get install -y curl
RUN curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v4.0.3/aqua-installer | bash -s -- -v ${AQUA_VERSION}

FROM ghcr.io/walnuts1018/devcontainer-image-go:v0.0.42@sha256:9b29673239c556e1d78a56d91cf6c04adfc6f0800b81707f67598a8f23f891c0 AS runner
ENV PATH=/root/.local/share/aquaproj-aqua/bin:$PATH

COPY aqua.yaml /aqua.yaml
COPY --from=aqua /opt/aqua/bin/aqua /usr/local/bin/aqua

RUN aqua i -a /aqua.yaml
