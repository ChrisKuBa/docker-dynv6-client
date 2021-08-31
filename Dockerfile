ARG APLINE_VERSION=3.12.7
ARG BUILD_FROM="alpine:${APLINE_VERSION}"

FROM $BUILD_FROM

ARG APLINE_VERSION
ARG BUILD_FROM
ARG BUILD_DATE
ARG BUILD_VERSION
ARG BUILD_REVISION

ENV SLEEP=600 \
    GREP="scope global dynamic" \
    INTERFACE="eth0"

RUN apk --update upgrade \
 && apk --no-cache add curl \
 && adduser -D -u 1111 service_user service_user

WORKDIR /home/service_user

COPY --chown=service_user:service_user dynv6.sh .

RUN chmod 500 dynv6.sh

USER service_user

LABEL org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.authors="Christian Kulbe <chriskbua@mail.de>" \
      org.opencontainers.image.url="https://hub.docker.com/r/chriskuba/dynv6-client" \
      org.opencontainers.image.documentation="https://github.com/ChrisKuBa/docker-dynv6-client/blob/main/README.md" \
      org.opencontainers.image.source="https://github.com/ChrisKuBa/docker-dynv6-client" \ 
      org.opencontainers.image.version=$BUILD_VERSION \
      org.opencontainers.image.licenses="GPL-2.0" \
      org.opencontainers.image.title=dynv6-client \
      org.opencontainers.image.revision=$BUILD_REVISION \
      org.opencontainers.image.description="This simple alpine docker container updates the ipv6 address of a dynv6 zone." \
      org.opencontainers.image.base.name=$BUILD_FROM
#LABEL org.opencontainers.image.vendor=""
#LABEL org.opencontainers.image.ref.name=""
#LABEL org.opencontainers.image.base.digest=""

ENTRYPOINT ["/home/service_user/dynv6.sh"]