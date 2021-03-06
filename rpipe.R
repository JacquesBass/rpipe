#!/usr/bin/Rscript


options(warn = 2)


#>> A finalizer to remove the lock file when .GlobalEnv is destroyed.
.free_rpipe_lock. <- function(env)
{
    if (file.exists('.rpipe.lock')) file.remove('.rpipe.lock')
}


#>> Verifies all assertions about the project and returns a list with all the project data: names, dates, classes, etc.
project_files <- function()
{
    get_title <- function(fn)
    {
        txt <- readLines(fn)

        rex <- '^#>[[:blank:]]*([^[:blank:]>].*[^[:blank:]])[[:blank:]]*$'

        ix <- which(grepl(rex, txt))

        if (length(ix) != 1) return('')

        gsub('[^[:print:]]', '', gsub(rex, '\\1', txt[ix]))
    }

    get_description <- function(fn)
    {
        txt <- readLines(fn)

        rex <- '^#>>[[:blank:]]*([^[:blank:]>].*[^[:blank:]])[[:blank:]]*$'

        ix <- which(grepl(rex, txt))

        if (length(ix) == 0) return('')

        paste(gsub('[^[:print:]]', '', gsub(rex, '\\1', txt[ix])), collapse = '\\')
    }

    get_csv_name <- function(fn)
    {
        txt <- readLines(fn)

        last <- txt[length(txt)]

        rex <- gsub('^scripts/([0-9]{3})_([[:upper:]]*)_?([[:lower:]][[:lower:][:digit:]_]*)\\.R$', '\\3', fn)
        rex <- paste0('^write_', rex, '\\(\'(output/.*)\'\\)$')

        if (!grepl(rex, last)) stop(paste('The last line in the output file', fn, 'must match', rex))

        gsub(rex, '\\1', last)
    }

    check_last_three <- function(fn, last)
    {
        txt <- readLines(fn)

        if (length(txt) < 5) return (FALSE)

        !any(txt[(length(txt) - 2):length(txt)] != last)
    }

    pf <- list()

    pf$script_name <- sort(list.files('scripts', full.names = TRUE))
    pf$script_date <- file.info(pf$script_name)$mtime

    if (length(pf$script_name) == 0) stop('Project is empty. (No script files found.)')

    L <- length(pf$script_name)

    rex <- '^scripts/([0-9]{3})_([[:upper:]]*)_?([[:lower:]][[:lower:][:digit:]_]*)\\.R$'

    ix <- which(!grepl(rex, pf$script_name))
    if (length(ix) > 0) stop(paste('Wrong script name:', pf$script_name[ix], collapse = '\n'))

    class_name <- sort(unique(gsub(rex, '\\2', pf$script_name)))
    ix <- which(!(class_name %in% c('', 'AUTOLOAD', 'FUNCTION', 'GLOBAL', 'SHOW', 'OUTPUT')))
    if (length(ix) > 0) stop(paste('Wrong class name:', class_name[ix], collapse = '\n'))

    pf$title <- sapply(pf$script_name, get_title)
    names(pf$title) <- NULL

    ix <- which(pf$title == '')
    if (length(ix) > 0) stop(paste('Empty title in filename:', pf$script_name[ix], collapse = '\n'))

    pf$description <- sapply(pf$script_name, get_description)
    names(pf$description) <- NULL

    pf$name <- gsub(rex, '\\3', pf$script_name)

    pf$number <- as.integer(gsub(rex, '\\1', pf$script_name))

    ix <- which(duplicated(pf$number))
    if (length(ix) > 0) stop(paste('Duplicated script number:', pf$number[duplicated(pf$number)], collapse = '\n'))

    pf$class <- rep('code', L)
    pf$class[gsub(rex, '\\2', pf$script_name) %in% c('', 'AUTOLOAD')] <- 'file'
    pf$class[gsub(rex, '\\2', pf$script_name) == 'OUTPUT'] <- 'outp'

    pf$datafr_name <- rep('', L)
    pf$datafr_date <- rep(strptime('19800101', format = '%Y%m%d'), L)

    build <- c('', '', '')

    for (i in 1:L)
    {
        if (pf$class[i] == 'file')
        {
            pf$datafr_name[i] <- paste0('data/', pf$name[i], '.RData')

            build[1] <- paste0(pf$name[i], ' <- build_', pf$name[i], '()')
            build[3] <- paste0('save(', pf$name[i], ', file = \'', pf$datafr_name[i], '\')')

            if (!check_last_three(pf$script_name[i], build)) {
                cat('Invalid script file creation in :', pf$script_name[i], '\n\n')
                cat('The last (including the void line) three lines should be:\n\n')
                cat(paste(build, collapse = '\n'), '\n\n')

                stop('Edit the file and retry.')
            }

            if (file.exists(pf$datafr_name[i])) pf$datafr_date[i] <- file.info(pf$datafr_name[i])$mtime
        }
        if (pf$class[i] == 'outp')
        {
            pf$datafr_name[i] <- get_csv_name(pf$script_name[i])

            if (file.exists(pf$datafr_name[i])) pf$datafr_date[i] <- file.info(pf$datafr_name[i])$mtime
        }
    }

    lf <- list.files('data', full.names = TRUE)
    ix <- which(!(lf %in% pf$datafr_name))
    if (any(ix)) stop(paste('Untraced files in data/', lf[ix], collapse = '\n'))

    lf <- list.files('output', full.names = TRUE)
    ix <- which(!(lf %in% pf$datafr_name))
    if (any(ix)) stop(paste('Untraced files in output/', lf[ix], collapse = '\n'))

    pf
}


#>> Make the project: Once, in a loop or from RStudio.
make_all <- function(break_if_no_lock, pf = project_files(), from_Rstudio = FALSE)
{
    isLocked <- file.exists('.rpipe.lock') | from_Rstudio

    if (isLocked) {
        if (break_if_no_lock) stop('Could not get lock! If no process is building, remove the lock file ".rpipe.lock" manually and retry.')
    } else {
        hea <- 1L
        save(hea, file = '.rpipe.lock')
        reg.finalizer(environment(), .free_rpipe_lock., onexit = TRUE)
    }

    force_recalc <- FALSE
    current_date <- pf$script_date[1]

    for (i in 1:length(pf$script_name))
    {
        current_date <- max(current_date, pf$script_date[i])

        if (pf$class[i] == 'code') {
            cat ('Processing', pf$script_name[i], '...\n')

            source(pf$script_name[i])
        }

        if (pf$class[i] == 'file') {
            if ((force_recalc | current_date > pf$datafr_date[i]) & !isLocked) {
                cat ('Processing', pf$script_name[i], '...\n')

                source(pf$script_name[i])

                force_recalc <- TRUE
            } else {
                if (grepl('_AUTOLOAD_', pf$script_name[i]))
                {
                    cat ('Loading', pf$datafr_name[i], '...\n')

                    load(pf$datafr_name[i], envir = .GlobalEnv)
                }
            }
        }

        if (pf$class[i] == 'outp') {
            if ((force_recalc | current_date > pf$datafr_date[i]) & !isLocked) {
                cat ('Processing', pf$script_name[i], '...\n')

                source(pf$script_name[i])
            } else {
                cat ('Skipped output', pf$script_name[i], '(nothing changed since last execution)\n')
            }
        }
    }

    if (isLocked) {
        cat ('\nOnly a simulation was done because the project is locked by another process building it!\n')

        if (from_Rstudio) cat ('\n(This is default behavior when called from RStudio.)\n')
        else              cat ('\n(If no process is building, remove the lock file ".rpipe.lock" manually and retry.)\n')
    } else {
        cat ('\nDone.\n')
    }
}


#>> Entry point: All functions not needed for building are conditionally defined to avoid declaring useless things when in RStudio.

isRStudio <- Sys.getenv("RSTUDIO") == "1"

if (isRStudio) {

    rm(list = unique(gsub('(^make_all$)|(^project_files$)|(^_free_rpipe_lock_$)', 'isRStudio', ls())))

    if (length(list.files('scripts')) == 0 & length(list.files('pipeline')) > 0) setwd(paste0(getwd(), '/pipeline'))

    make_all(FALSE, from_Rstudio = TRUE)

} else {

    show_project <- function(write_file = FALSE, pf = project_files())
    {
        if (write_file) {
            df <- data.frame(name = pf$name, class = pf$class, title = pf$title, description = pf$description, stringsAsFactors = FALSE)

            rownames(df) <- pf$number

            cat('\nWriting ./project_map.csv ... ')
            write.table(df, './project_map.csv', quote = FALSE, sep = '\t')
            cat('Ok.\n')
        } else {
            df <- data.frame(NAME = pf$name, CLASS = pf$class, TITLE = pf$title, stringsAsFactors = FALSE)

            rownames(df) <- pf$number

            err <- try(sx <- gsub('^.*columns[[:blank:]]*([0-9]+)[[:blank:]]*;.*$', '\\1', system('stty -a | head -1', intern = T)), silent = TRUE)

            if (class(err) != 'try-error' && length(sx) == 1) options(width = as.integer(sx))

            print(df, right = F)
        }
    }


    make_info <- function(calc_hash = TRUE, pf = project_files())
    {
        recency <- function(dt)
        {
            dt        <- now - dt
            units(dt) <- 'hours'

            sprintf('%8.4f', dt)
        }
        L <- length(pf$script_name)

        pf$hash    <- rep('    --', L)
        pf$build   <- rep('Skip', L)
        pf$recency <- rep('    --', L)

        force_recalc <- FALSE
        current_date <- pf$script_date[1]

        now <- Sys.time()

        if (calc_hash) cat('\nHashing data files ... (may take some time) ...')
        for (i in 1:length(pf$script_name))
        {
            current_date <- max(current_date, pf$script_date[i])

            if (pf$class[i] == 'code') pf$build[i] <- 'Run'

            if (pf$class[i] == 'file') {

                if (force_recalc | current_date > pf$datafr_date[i]) {
                    pf$build[i] <- 'Build'

                    force_recalc <- TRUE
                } else {
                    if (grepl('_AUTOLOAD_', pf$script_name[i])) pf$build[i] <- 'Load'
                }

                if (file.exists(pf$datafr_name[i]))
                {
                    if (calc_hash) pf$hash[i] <- gsub('^(.{10}).*$', '\\1', digest::digest(pf$datafr_name[i], file = TRUE))

                    pf$recency[i] <- recency(pf$datafr_date[i])
                }
            }

            if (pf$class[i] == 'outp') {
                if (force_recalc | current_date > pf$datafr_date[i]) pf$build[i] <- 'Build'

                if (file.exists(pf$datafr_name[i]))
                {
                    if (calc_hash) pf$hash[i] <- gsub('^(.{10}).*$', '\\1', digest::digest(pf$datafr_name[i], file = TRUE))

                    pf$recency[i] <- recency(pf$datafr_date[i])
                }
            }
        }
        if (calc_hash) cat(' Ok.\n\n')

        df <- data.frame(pf$name,
                         recency(pf$script_date),
                         pf$class,
                         pf$datafr_name,
                         pf$recency,
                         pf$hash,
                         pf$build, stringsAsFactors = FALSE)

        colnames(df) <- c('NAME', 'RECENCY(h)', 'CLASS', 'DATA_FILE', 'RECENCY(h)', 'DATA_HASH', 'BUILD')
        rownames(df) <- pf$number

        err <- try(sx <- gsub('^.*columns[[:blank:]]*([0-9]+)[[:blank:]]*;.*$', '\\1', system('stty -a | head -1', intern = T)), silent = TRUE)

        if (class(err) != 'try-error' && length(sx) == 1) options(width = as.integer(sx))

        print(df, right = F)
    }


    inifinite_loop <- function()
    {
        while (TRUE)
        {
            make_all(TRUE)

            .free_rpipe_lock.() # No problem erasing the file as failing to get it (owned by someone else) would fail.

            system('inotifywait -e create,close_write,delete -r scripts/ data/')
        }
    }


    init_folders <- function()
    {
        system('mkdir data scripts input output')
    }


    rpipe_help <- function()
    {
        cat('Usage: rpipe.R <cmd>\n\n')

        cat(' <cmd>   DESCRIPTION\n')
        cat(' -------------------\n')
        cat('  fast : Same as "info" without computing data file hashes.\n')
        cat('  file : Writes project steps to "./project_map.csv" including descriptions.\n')
        cat('  help : Shows this help.\n')
        cat('  info : Show project make details, including dates and hashes, without doing anything.\n')
        cat('  init : Creates empty folders: data, scripts, input, output\n')
        cat('  loop : An infinite loop of: "make", "wait for file events", "repeat".\n')
        cat('  make : Run the "make" just once.\n')
        cat('  show : Prints project steps to console skipping descriptions.\n')

        cat('\n')
    }


    dofn <- list(fast = function() make_info(FALSE),
                 file = function() show_project(TRUE),
                 info = function() make_info(),
                 init = function() init_folders(),
                 loop = function() inifinite_loop(),
                 make = function() make_all(FALSE),
                 show = function() show_project())

    args <- commandArgs(TRUE)

    if (length(args) == 1)
    {
        if (is.null(dofn[[args]])) rpipe_help() else dofn[[args]]()
    } else {
        rpipe_help()
    }
}
