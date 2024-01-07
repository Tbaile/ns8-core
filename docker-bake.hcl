target "base" {
    platforms = [
        "linux/arm64",
        "linux/amd64"
    ]
}

target "core" {
    inherits = ["base"]
    target = "core"
    context = "core"
    tags = [
        "ns8-core:latest"
    ]
    args = {
        "CORE_IMAGE" = "${target.core.tags[0]}"
        "REDIS_IMAGE" = "${target.redis.tags[0]}"
        "RSYNC_IMAGE" = "${target.rsync.tags[0]}"
        "RESTIC_IMAGE" = "${target.restic.tags[0]}"
        "PROMTAIL_IMAGE" = "docker.io/grafana/promtail:2.9.2"
    }
    labels = {
        "org.nethserver.images" = "${target.core.args.REDIS_IMAGE} ${target.core.args.RSYNC_IMAGE} ${target.core.args.RESTIC_IMAGE} ${target.core.args.PROMTAIL_IMAGE}"
        "org.nethserver.flags" = "core"
    }
}

target "redis" {
    inherits = ["base"]
    context = "core/redis"
    tags = [
        "ns8-redis:latest"
    ]
}

target "restic" {
    inherits = ["base"]
    context = "core/restic"
    tags = [
        "ns8-restic:latest"
    ]
}

target "rsync" {
    inherits = ["base"]
    context = "core/rsync"
    tags = [
        "ns8-rsync:latest"
    ] 
}

group "default" {
    targets = ["core", "redis", "restic", "rsync"]
}
