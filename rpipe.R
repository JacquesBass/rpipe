#!/usr/bin/Rscript


options(warn = 2)


.free_rpipe_lock. <- function(e)
{
    if (file.exists('./.rpipe.lock')) file.remove('./.rpipe.lock')
}


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

    check_last_three <- function(fn, last)
    {
        txt <- readLines(fn)

        !any(txt[(length(txt) - 2):length(txt)] != last)
    }

    pf <- list()

    pf$script_name <- sort(list.files('scripts', full.names = TRUE))
    pf$script_date <- file.info(pf$script_name)$mtime

    if (length(pf$script_name) == 0) stop('Project is empty. (No script files found.)')

    rex <- '^scripts/([0-9]{3})_([[:upper:]]*)_?([[:lower:]][[:lower:][:digit:]_]*)\\.R$'

    ix <- which(!grepl(rex, pf$script_name))
    if (length(ix) > 0) stop(paste('Wrong script name:', pf$script_name[ix], collapse = '\n'))

    ix <- which(!(sort(unique(gsub(rex, '\\2', pf$script_name))) %in% c('', 'DONTAUTOLOAD', 'FUNCTION', 'GLOBAL', 'SHOW', 'OUTPUT')))
    if (length(ix) > 0) stop(paste('Wrong class in filename:', pf$script_name[ix], collapse = '\n'))

    pf$title <- sapply(pf$script_name, get_title)
    names(pf$title) <- NULL

    ix <- which(pf$title == '')
    if (length(ix) > 0) stop(paste('Empty title in filename:', pf$script_name[ix], collapse = '\n'))

    pf$description <- sapply(pf$script_name, get_description)
    names(pf$description) <- NULL

    pf$name    <- gsub(rex, '\\3', pf$script_name)
    pf$is_file <- gsub(rex, '\\2', pf$script_name) %in% c('', 'DONTAUTOLOAD')
    pf$number  <- as.integer(gsub(rex, '\\1', pf$script_name))

    ix <- which(duplicated(pf$number))
    if (length(ix) > 0) stop(paste('Duplicated script number:', pf$number[duplicated(pf$number)], collapse = '\n'))

    L <- length(pf$script_name)

    pf$datafr_name <- rep('', L)
    pf$datafr_date <- rep(strptime('19800101', format = '%Y%m%d'), L)

    build <- c('', '', '')

    for (i in 1:L)
    {
        if (pf$is_file[i])
        {
            pf$datafr_name[i] <- paste0('data/', pf$name[i], '.RData')

            build[1] <- paste0(pf$name[i], ' <- build_', pf$name[i], '()')
            build[3] <- paste0('save(', pf$name[i], ', file = \'', pf$datafr_name[i], '\')')

            if (!check_last_three(pf$script_name[i], build)) stop(paste('Invalid script file creation in :', pf$script_name[i]))

            if (file.exists(pf$datafr_name[i])) pf$datafr_date[i] <- file.info(pf$datafr_name[i])$mtime
        }
    }

    lf <- list.files('data', full.names = TRUE)
    ix <- which(!(lf %in% pf$datafr_name))
    if (any(ix)) stop(paste('Untraced files in data/', lf[ix], collapse = '\n'))

    pf
}


make_all <- function(pf = project_files())
{
    isLocked <- file.exists('./.rpipe.lock')

    if (!isLocked) {
        hea <- 1L
        save(hea, file = './.rpipe.lock')
        reg.finalizer(environment(), .free_rpipe_lock., onexit = TRUE)
    }

    force_recalc <- FALSE
    current_date <- pf$script_date[1]

    for (i in 1:length(pf$script_name))
    {
        current_date <- max(current_date, pf$script_date[i])

        if (!pf$is_file[i]) {
            cat ('Processing', pf$script_name[i], '...\n')

            source(pf$script_name[i])
        } else {
            if (force_recalc & !isLocked) {
                cat ('Processing', pf$script_name[i], '...\n')

                source(pf$script_name[i])
            } else {
                if (current_date > pf$datafr_date[i] & !isLocked)
                {
                    cat ('Processing', pf$script_name[i], '...\n')

                    source(pf$script_name[i])

                    force_recalc <- TRUE
                } else {
                    if (!grepl('_DONTAUTOLOAD_', pf$script_name[i]))
                    {
                        cat ('Loading', pf$datafr_name[i], '...\n')

                        load(pf$datafr_name[i], envir = .GlobalEnv)
                    }
                }
            }
        }
    }

    if (isLocked) {
        cat ('\nOnly a simulation was done because the project is locked by another process building it!\n')
        cat ('\n(If no process is building, remove the lock file "./.rpipe.lock" manually and retry.)\n')
    } else {
        .free_rpipe_lock.()

        cat ('\nDone.\n')
    }
}


isRStudio <- Sys.getenv("RSTUDIO") == "1"

if (isRStudio) {

    rm(list = unique(gsub('(^make_all$)|(^project_files$)|(^_free_rpipe_lock_$)', 'isRStudio', ls())))

    make_all()

} else {

    map_all <- function(write_file = FALSE, pf = project_files())
    {
        if (write_file) {
            df <- data.frame(name = pf$name, is_file = pf$is_file, title = pf$title, description = pf$description, stringsAsFactors = FALSE)

            rownames(df) <- pf$number

            cat('\nWriting ./project_map.csv ... ')
            write.table(df, './project_map.csv', quote = FALSE, sep = '\t')
            cat('Ok.\n')
        } else {
            df <- data.frame(NAME = pf$name, IS_FILE = pf$is_file, TITLE = pf$title, stringsAsFactors = FALSE)

            rownames(df) <- pf$number

            err <- try(sx <- gsub('^.*columns[[:blank:]]*([0-9]+)[[:blank:]]*;.*$', '\\1', system('stty -a | head -1', intern = T)), silent = TRUE)

            if (class(err) != 'try-error' && length(sx) == 1) options(width = as.integer(sx))

            print(df, right = F)
        }
    }


    inifinite_loop <- function()
    {
        while (TRUE)
        {
            make_all()

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
        cat('  file : Writes results to ./project_map.csv including details section.\n')
        cat('  help : Shows this help.\n')
        cat('  init : Creates empty folders: data, scripts, output\n')
        cat('  loop : Make in an infinite loop waiting for file events to repeat.\n')
        cat('  make : Make once.\n')
        cat('  show : Prints results to console skipping details section.\n')

        cat('\n')
    }


    if (length(commandArgs(TRUE)) == 1)
    {
        if (commandArgs(TRUE) == 'file') map_all(T)
        if (commandArgs(TRUE) == 'help') rpipe_help()
        if (commandArgs(TRUE) == 'init') init_folders()
        if (commandArgs(TRUE) == 'show') map_all()
        if (commandArgs(TRUE) == 'make') make_all()
        if (commandArgs(TRUE) == 'loop') inifinite_loop()
    } else {
        rpipe_help()
    }
}
