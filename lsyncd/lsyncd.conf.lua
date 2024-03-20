settings {
    logfile    = "/var/log/lsyncd/lsyncd.log",
    statusFile = "/var/log/lsyncd/lsyncd.status"
}

sync {
    default.rsyncssh,
    source    = "/data/www/",
    target    = "/data1/www/",
    exclude   = { '*.log', '*.txt' },
    rsync     = {
        archive = true,
        compress = true
    },
    ssh = {
        port = 22
    }
}