FROM alpine:3.18.4
RUN apk add --no-cache \
        restic \
        rclone \
    && addgroup -S restic \
    && adduser -S -D -H -h /dev/null -s /sbin/nologin -G restic restic \
    && mkdir -v -p -m 0750 /srv/repo \
    && chown -c restic:restic /srv/repo
COPY usr/local/bin/rclone-wrapper /usr/local/bin/rclone-wrapper
CMD []
ENTRYPOINT [ "/usr/bin/restic" ]
VOLUME [ "/srv/repo" ]
ENV RCLONE_CONFIG=/dev/null
