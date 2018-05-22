# Run the KeePassX password manager in a container
#
# Build image:
#   docker build -t local/keepass .
#
# Update:
#   docker build --no-cache -t local/keepass .
#

FROM alpine:3.7@sha256:8c03bb07a531c53ad7d0f6e7041b64d81f99c6e493cb39abba56d956b40eacbc

RUN set -xe \
  && addgroup -g 5339 -S keepass \
  && adduser -D -u 5339 -S -h /home/keepass -s /sbin/nologin -G keepass keepass \
  && adduser keepass video \
  && apk add --no-cache \
    keepassx \
    ttf-inconsolata

# run as non privileged user
USER keepass
WORKDIR /home/keepass

ENTRYPOINT ["/usr/bin/keepassx"]
