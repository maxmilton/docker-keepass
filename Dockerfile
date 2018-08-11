# Run the KeePassX password manager in a container
#
# Build image:
#   docker build -t local/keepass .
#
# Update:
#   docker build --no-cache -t local/keepass .
#

FROM alpine:3.7@sha256:56e2f91ef15847a2b02a5a03cbfa483949d67a242c37e33ea178e3e7e01e0dfd

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
