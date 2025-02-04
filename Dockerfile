FROM debian:bookworm-slim AS aqua
ARG AQUA_VERSION=v2.43.2
ENV AQUA_ROOT_DIR=/opt/aqua

RUN apt-get -y update && apt-get install -y curl
RUN curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.1.1/aqua-installer | bash -s -- -v ${AQUA_VERSION}

FROM ghcr.io/walnuts1018/devcontainer-image-go:v0.0.19 AS runner
ENV PATH=/root/.local/share/aquaproj-aqua/bin:$PATH

COPY aqua.yaml /aqua.yaml
COPY --from=aqua /opt/aqua/bin/aqua /usr/local/bin/aqua

RUN aqua i -a /aqua.yaml
