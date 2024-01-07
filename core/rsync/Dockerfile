FROM alpine:3.18.4
RUN apk add --no-cache rsync
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "rsync", "--daemon", "--no-detach" ]
