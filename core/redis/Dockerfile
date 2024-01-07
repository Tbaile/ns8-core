FROM redis:7.2.3-alpine
VOLUME [ "/data" ]
COPY redis.acl /data/etc/redis.acl
COPY redis.conf /data/etc/redis.conf
CMD ["redis-server", "/data/etc/redis.conf"]
