ARG BASE_IMAGE_URL=ghcr.io/drakkan/sftpgo
ARG BASE_IMAGE_TAG=v2.3.0
ARG BASE_IMAGE=${BASE_IMAGE_URL}:${BASE_IMAGE_TAG}

FROM alpine:3.16.0 AS downloader

COPY sftpgo-plugin-downloader /usr/bin

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

ENV PUBSUB_PLUGIN_VERSION=v1.0.3
RUN sftpgo-plugin-downloader pubsub $PUBSUB_PLUGIN_VERSION

ENV KMS_PLUGIN_VERSION=v1.0.3
RUN sftpgo-plugin-downloader kms $KMS_PLUGIN_VERSION

ENV METADATA_PLUGIN_VERSION=v1.0.2
RUN sftpgo-plugin-downloader metadata $METADATA_PLUGIN_VERSION

ENV GEOIPFILTER_PLUGIN_VERSION=v1.0.0
RUN sftpgo-plugin-downloader geoipfilter $GEOIPFILTER_PLUGIN_VERSION

ENV EVENTSTORE_PLUGIN_VERSION=v1.0.3
RUN sftpgo-plugin-downloader eventstore $EVENTSTORE_PLUGIN_VERSION

ENV EVENTSEARCH_PLUGIN_VERSION=v1.0.3
RUN sftpgo-plugin-downloader eventsearch $EVENTSEARCH_PLUGIN_VERSION

FROM $BASE_IMAGE

COPY --from=downloader /usr/local/bin /usr/local/bin
