FROM --platform=$BUILDPLATFORM golang:1.21.5 as base
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ENV GOOS=${TARGETOS}
ENV GOARCH=${TARGETARCH}
WORKDIR /app

FROM base as agent
COPY agent/go.mod .
COPY agent/go.sum .
RUN --mount=type=cache,target=/go/pkg/mod \
    go mod download
COPY agent/models models
COPY agent/validation validation
COPY agent/agent.go .
COPY agent/envstate.go .
COPY agent/hbuiltin.go .
COPY agent/hevent.go .
COPY agent/htask.go .
RUN --mount=type=cache,target=/root/.cache/go-build \
    CGO_ENABLED=0 go build -v 

FROM base as api-server
COPY api-server/go.mod .
COPY api-server/go.sum .
RUN --mount=type=cache,target=/go/pkg/mod \
    go mod download
COPY api-server/audit audit
COPY api-server/configuration configuration
COPY api-server/methods methods
COPY api-server/middleware middleware
COPY api-server/models models
COPY api-server/redis redis
COPY api-server/response response
COPY api-server/socket socket
COPY api-server/utils utils
COPY api-server/api-server-logs.go .
COPY api-server/api-server.go .
RUN --mount=type=cache,target=/root/.cache/go-build \
    CGO_ENABLED=0 go build -v api-server-logs.go
COPY api-server/api-server-multi-arch-build.sh .
RUN --mount=type=cache,target=/root/.cache/go-build \
    ./api-server-multi-arch-build.sh

FROM base as api-moduled
COPY api-moduled/go.sum .
COPY api-moduled/go.mod .
RUN --mount=type=cache,target=/go/pkg/mod \
    go mod download
COPY api-moduled/validation validation
COPY api-moduled/api-moduled.go .
RUN --mount=type=cache,target=/root/.cache/go-build \
    CGO_ENABLED=0 go build -v

FROM base as env
ARG CORE_IMAGE
ARG REDIS_IMAGE
ARG RSYNC_IMAGE
ARG RESTIC_IMAGE
ARG PROMTAIL_IMAGE
RUN echo "CORE_IMAGE=${CORE_IMAGE}" > core.env \
    && echo "REDIS_IMAGE=${REDIS_IMAGE}" >> core.env \
    && echo "RSYNC_IMAGE=${RSYNC_IMAGE}" >> core.env \
    && echo "RESTIC_IMAGE=${RESTIC_IMAGE}" >> core.env \
    && echo "PROMTAIL_IMAGE=${PROMTAIL_IMAGE}" >> core.env \
    && chmod 644 core.env

FROM --platform=$BUILDPLATFORM node:20.10.0 as ui
RUN apt-get update \
    && apt-get install -y tidy
WORKDIR /app
COPY ui/.yarn .yarn
COPY ui/.yarnrc.yml .
COPY ui/package.json .
COPY ui/yarn.lock .
RUN yarn install --immutable
COPY ui/public public
COPY ui/src src
COPY ui/.browserslistrc .
COPY ui/.eslintrc.js .
COPY ui/babel.config.js .
COPY ui/vue.config.js .
RUN NODE_OPTIONS=--openssl-legacy-provider yarn build \
    && tidy dist/index.html | grep -oP 'link href=\"css/app~.+\.css\" rel=\"stylesheet\"' | grep -oP 'app~.+\.css' | paste -sd ' ' - > dist/css/core.css

FROM scratch as core
COPY imageroot /
COPY --from=grafana/logcli:2.9.2-arm64 /usr/bin/logcli /usr/local/bin/logcli.bin
COPY --from=agent /app/agent /usr/local/bin/agent
COPY --from=api-server /app/api-server usr/local/bin/api-server
COPY --from=api-server /app/api-server-logs /usr/local/bin/api-server-logs
COPY --from=api-moduled /app/api-moduled /usr/local/bin/api-moduled
COPY --from=ui /app/dist /var/lib/nethserver/cluster/ui
COPY --from=env /app/core.env /etc/nethserver/core.env
COPY install.sh /var/lib/nethserver/node/install.sh
ENTRYPOINT [ "/" ]
