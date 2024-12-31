FROM debian:bookworm-slim AS aqua
ARG AQUA_VERSION=v2.41.0
ENV AQUA_ROOT_DIR=/opt/aqua

RUN --mount=type=cache,target=/var/lib/apt,sharing=locked \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    apt-get -y update && apt-get install -y curl
RUN curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.1.0/aqua-installer | bash -s -- -v ${AQUA_VERSION}

FROM golang:1.23.4-bookworm as runner
ENV PATH=/root/.local/share/aquaproj-aqua/bin:$PATH

COPY aqua.yaml /aqua.yaml
COPY --from=aqua /opt/aqua/bin/aqua /usr/local/bin/aqua

RUN --mount=type=cache,target=/go/pkg/mod/ \
    --mount=type=cache,target=/root/.cache/go-build,sharing=locked \
    aqua i -a /aqua.yaml
