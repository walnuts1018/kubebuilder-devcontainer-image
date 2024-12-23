FROM alpine:3.16 AS aqua

ENV AQUA_VERSION=v2.40.0

RUN apk add curl

RUN curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.1.0/aqua-installer | sh -s -- -i /usr/local/bin/aqua -v AQUA_VERSION

COPY aqua.yaml /aqua.yaml
RUN aqua -c /aqua.yaml cp -o /dist actionlint reviewdog

FROM golang:1.23.4-bookworm as runner

COPY --from=aqua /dist/* /usr/local/bin/
