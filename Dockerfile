FROM alpine:3.12.7

ARG BUILD_DATE
ARG BUILD_VERSION

LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.authors="Christian Kulbe <chriskbua@mail.de>"
LABEL org.opencontainers.image.url="https://hub.docker.com/r/chriskuba/dynv6-client"
LABEL org.opencontainers.image.documentation="https://github.com/ChrisKuBa/docker-dynv6-client/blob/main/README.md"
LABEL org.opencontainers.image.source="https://github.com/ChrisKuBa/docker-dynv6-client"
LABEL org.opencontainers.image.version="${BUILD_VERSION}"
#LABEL org.opencontainers.image.revision=""
#LABEL org.opencontainers.image.vendor=""
LABEL org.opencontainers.image.licenses="GPL-2.0"
#LABEL org.opencontainers.image.ref.name=""
LABEL org.opencontainers.image.title=dynv6-client
LABEL org.opencontainers.image.description="This simple alpine docker container updates the ipv6 address of a dynv6 zone."
#LABEL org.opencontainers.image.base.digest=""
LABEL org.opencontainers.image.base.name=alpine:3.12.7

ENV TZ Europe/Berlin
RUN apk --update upgrade \
  && apk --no-cache add curl \
  && adduser -D -u 1111 service_user service_user

WORKDIR /home/service_user
COPY dynv6.sh .
RUN chmod 700 dynv6.sh \
  && chown service_user:service_user dynv6.sh

USER service_user

ENV SLEEP=600
ENV GREP="scope global dynamic"
ENV INTERFACE="eth0"

ENTRYPOINT ["/home/service_user/dynv6.sh"]