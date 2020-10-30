.installed.packs. <- data.frame(installed.packages(), stringsAsFactors = FALSE)


dependencies <- function(pak, ip = .installed.packs., suggests = FALSE)
{
    ix <- which(ip$Package == pak)

    if (length(ix) == 0) stop(paste('Package', pak, 'is not installed.'))

    if (suggests) all <- c(ip$Depends[ix], ip$Imports[ix], ip$LinkingTo[ix], ip$Suggests[ix])
    else          all <- c(ip$Depends[ix], ip$Imports[ix], ip$LinkingTo[ix])

    all <- all[!is.na(all)]
    all <- gsub('\\([^\\)]+\\)', '', all)
    all <- gsub('[[:blank:]]', '', all)
    all <- gsub('[[:cntrl:]]', '', all)

    all <- paste0(all, collapse = ',')
    all <- strsplit(all, split = ',')[[1]]

    all <- sort(all)
    all <- unique(all)
    all <- all[all != '']
    all <- all[all != 'R']

    all
}

packages <- .installed.packs.$Package

for (pak in packages) {
    dep <- dependencies(pak)

    ix <- which(!(dep %in% packages))

    if (length(ix) > 0) {
        cat(pak, ':', dep, '\n')
        cat('  FAILED :', dep[ix], '\n')
    }
}
