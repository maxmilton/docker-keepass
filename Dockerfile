# Run the KeePassX password manager in a container
#
# Build image:
#   docker build -t local/keepass .
#
# Update:
#   docker build --no-cache -t local/keepass .
#

FROM alpine:3.7@sha256:5ce5f501c457015c4b91f91a15ac69157d9b06f1a75cf9107bf2b62e0843983a

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
