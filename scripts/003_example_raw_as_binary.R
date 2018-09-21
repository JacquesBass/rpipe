#> Some ETL process is the typical start of a ML pipe.


#>> Typically, we will load a big file slowly (like a csv) and save it as binary to load it faster anytime we need it.
#>> Typically, that file is not what we will use for training, so we don't want it to load automatically each time we make -> not AUTOLOAD.

#>> And this is when rpipe becomes annoyingly pedantic, you have to do it by declaring a function named build_example_raw_as_binary(), this is
#>> --------------------------------------------------
#>> build_<lower case part of the script name>, returning whatever you want to save, exactly as done by the last 3 lines that cannot be modified!!
#>>                                                                                                     ------------------------------------------

#>> This applies to all scripts generating files. The file name (one file) and the script name MUST match.

#>> Also, you cannot declare variables or functions in the file since they will not be loaded when there is no need to run the script. That's what
#>> _GLOBAL_* and _FUNCTION_* scripts are for.


build_example_raw_as_binary <- function()
{
    # data <- read.csv(file = 'input/my_source_xxx.csv')    # read, query a DB or whatever.

    data <- data.frame(x = 1:3)

    data
}


example_raw_as_binary <- build_example_raw_as_binary()

save(example_raw_as_binary, file = 'data/example_raw_as_binary.RData')
