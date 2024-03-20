sync {
    default.rsync,
    source    = "/data/www/",
    target    = "/data1/www/",
    exclude   = { '*.log', '*.txt' },
    rsync     = {
        archive = true,
        compress = true
    }
}