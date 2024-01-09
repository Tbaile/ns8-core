target "base" {
    platforms = [
        "linux/arm64",
        "linux/amd64",
        "linux/arm/v7"
    ]
    cache-from = [
        "type=gha"
    ]
}

target "core" {
    inherits = ["base"]
    target = "core"
    context = "core"
    args = {
        CORE_IMAGE = "${target.core.tags[0]}"
        REDIS_IMAGE = "${target.redis.tags[0]}"
        RSYNC_IMAGE = "${target.rsync.tags[0]}"
        RESTIC_IMAGE = "${target.restic.tags[0]}"
        PROMTAIL_IMAGE = "docker.io/grafana/promtail:2.9.2"
    }
    labels = {
        "org.nethserver.images" = "${target.redis.tags[0]} ${target.rsync.tags[0]} ${target.restic.tags[0]} docker.io/grafana/promtail:2.9.2"
        "org.nethserver.flags" = "core"
    }
    tags = [
        "tbaile/core"
    ]
}

target "redis" {
    inherits = ["base"]
    context = "core/redis"
    tags = [
        "tbaile/redis"
    ]
}

target "restic" {
    inherits = ["base"]
    context = "core/restic"
    tags = [
        "tbaile/restic"
    ]
}

target "rsync" {
    inherits = ["base"]
    context = "core/rsync"
    tags = [
        "tbaile/rsync"
    ]
}

group "default" {
    targets = ["core", "redis", "restic", "rsync"]
}
