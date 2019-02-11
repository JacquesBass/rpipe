nice <- function(txt)
{
    txt <- paste(sort(unique(txt)), collapse = "', '")
    txt <- paste0("c('", txt, "')")
    rex <- '^(.{1,138},) (.*)$'
    cat('\n\n')
    while (txt != '')
    {
        if (grepl(rex, txt))
        {
            cat(gsub(rex, '\\1', txt), '\n')
            txt <- gsub(rex, '\\2', txt)
        } else {
            cat(txt, '\n')
            txt <- ''
        }
    }
}


packs <- c('abind', 'acepack', 'ade4', 'arules', 'askpass', 'assertthat', 'audio', 'AzureML', 'backports', 'base', 'base64enc', 'BH', 'bibtex',
           'bigmemory', 'bigmemory.sri', 'bindr', 'bindrcpp', 'bit', 'bit64', 'bitops', 'blob', 'bmp', 'boot', 'BradleyTerry2', 'brew', 'brglm',
           'broom', 'Cairo', 'callr', 'car', 'carData', 'caret', 'caretEnsemble', 'catboost', 'caTools', 'cellranger', 'checkmate', 'chron',
           'Ckmeans.1d.dp', 'class', 'classInt', 'cld2', 'cli', 'clipr', 'clisymbols', 'cluster', 'clv', 'coda', 'codetools', 'coin', 'colorspace',
           'colourpicker', 'combinat', 'commonmark', 'compiler', 'config', 'CORElearn', 'covr', 'crayon', 'crosstalk', 'curl', 'CVST', 'darch',
           'data.table', 'datasets', 'DBI', 'dbplyr', 'ddalpha', 'debugme', 'deepboost', 'deepnet', 'deldir', 'dendextend', 'DEoptimR', 'Deriv',
           'desc', 'devtools', 'DiagrammeR', 'dichromat', 'digest', 'dimRed', 'diptest', 'doParallel', 'dotCall64', 'downloader', 'dplyr', 'DRR',
           'DT', 'dtplyr', 'dtw', 'e1071', 'earth', 'ellipse', 'entropy', 'evaluate', 'extrafont', 'extrafontdb', 'FactoMineR', 'fansi', 'fastmatch',
           'fclust', 'fda', 'ff', 'ffbase', 'fields', 'fImport', 'flashClust', 'flexclust', 'flexmix', 'FNN', 'forcats', 'foreach', 'forecast',
           'foreign', 'formatR', 'Formula', 'fpc', 'fracdiff', 'fs', 'functional', 'futile.logger', 'futile.options', 'gbm', 'gclus', 'gdata',
           'gdtools', 'gender', 'generics', 'geometry', 'geosphere', 'ggmap', 'ggplot2', 'ggrepel', 'ggthemes', 'gh', 'gistr', 'git2r', 'glmnet',
           'glue', 'gmodels', 'gmp', 'goftest', 'googlesheets', 'googleVis', 'gower', 'gplots', 'graphics', 'grDevices', 'grid', 'gridBase',
           'gridExtra', 'gsubfn', 'gtable', 'gtools', 'gutenbergr', 'h2o', 'h5', 'haven', 'hexbin', 'highlight', 'highr', 'Hmisc', 'hms', 'htmlTable',
           'htmltools', 'htmlwidgets', 'httpuv', 'httr', 'hunspell', 'ifultools', 'igraph', 'imager', 'influenceR', 'ini', 'inline', 'inum', 'ipred',
           'irlba', 'ISOcodes', 'iterators', 'janeaustenr', 'jomo', 'jpeg', 'jsonlite', 'kerasR', 'kernlab', 'KernSmooth', 'klaR', 'knitr',
           'labeling', 'labelled', 'lambda.r', 'lars', 'lasso2', 'later', 'lattice', 'latticeExtra', 'lava', 'lazyeval', 'lda', 'leaflet', 'leaps',
           'libcoin', 'lightgbm', 'lme4', 'lmtest', 'locpol', 'logistf', 'lpSolve', 'lsa', 'lubridate', 'magic', 'magrittr', 'manipulate', 'mapproj',
           'maps', 'maptools', 'markdown', 'MASS', 'Matrix', 'MatrixModels', 'maxent', 'mboost', 'mcclust', 'mclust', 'memoise', 'methods', 'Metrics',
           'mgcv', 'mice', 'microbenchmark', 'mime', 'miniCRAN', 'miniUI', 'minqa', 'misc3d', 'mitml', 'mlapi', 'mlbench', 'mnormt', 'ModelMetrics',
           'modelr', 'modeltools', 'monitoR', 'multcomp', 'munsell', 'mvtnorm', 'mxnet', 'ndjson', 'network', 'neuralnet', 'NeuralNetTools', 'ngram',
           'nlme', 'nloptr', 'NLP', 'NMF', 'nnet', 'nnls', 'nplr', 'numbers', 'numDeriv', 'OAIHarvester', 'officer', 'opencage', 'openssl',
           'openxlsx', 'ordinal', 'osmar', 'packrat', 'pan', 'parallel', 'party', 'partykit', 'pbapply', 'pbkrtest', 'pdc', 'pdftools', 'pillar',
           'pkgbuild', 'pkgconfig', 'pkgdown', 'pkgload', 'pkgmaker', 'PKI', 'plogr', 'plotly', 'plotmo', 'plotrix', 'pls', 'plyr', 'png', 'polyclip',
           'pool', 'prabclus', 'praise', 'prettyunits', 'pROC', 'processx', 'prodlim', 'profileModel', 'progress', 'promises', 'proto', 'proxy',
           'pryr', 'ps', 'psych', 'purrr', 'pwr', 'qap', 'qdapDictionaries', 'qdapRegex', 'qdapTools', 'quadprog', 'Quandl', 'quanteda', 'quantmod',
           'quantreg', 'questionr', 'quickcheck', 'qvcalc', 'R.methodsS3', 'R.oo', 'R.utils', 'R6', 'randomForest', 'RANN', 'raster', 'rbenchmark',
           'rbokeh', 'rcmdcheck', 'RColorBrewer', 'Rcpp', 'RcppArmadillo', 'RcppEigen', 'RcppExamples', 'RcppParallel', 'RcppRoll', 'RCurl',
           'readbitmap', 'readr', 'readxl', 'recipes', 'recommenderlab', 'registry', 'rematch', 'rematch2', 'remotes', 'reports', 'reprex', 'reshape',
           'reshape2', 'reticulate', 'rex', 'rgdal', 'rgexf', 'RgoogleMaps', 'rio', 'rjazz', 'rjson', 'RJSONIO', 'rlang', 'rmarkdown', 'Rmixmod',
           'rngtools', 'ROAuth', 'robustbase', 'ROCR', 'Rook', 'roxygen2', 'rpart', 'rpart.plot', 'rprojroot', 'rredis', 'RSclient', 'rsconnect',
           'Rserve', 'RSpectra', 'RSQLite', 'rstudioapi', 'RTextTools', 'Rttf2pt1', 'RUnit', 'rversions', 'rvest', 'rvg', 'rworldmap', 'sandwich',
           'satellite', 'scales', 'scatterplot3d', 'seewave', 'segmented', 'selectr', 'seriation', 'sessioninfo', 'sf', 'sfsmisc', 'shiny', 'shinyBS',
           'shinydashboard', 'shinyjs', 'signal', 'slam', 'sn', 'sna', 'snow', 'SnowballC', 'sourcetools', 'sp', 'spa', 'spacyr', 'spam', 'SparseM',
           'sparsepp', 'spatial', 'spatstat', 'spatstat.data', 'spatstat.utils', 'spData', 'splines', 'splus2R', 'sqldf', 'SQUAREM', 'stabs',
           'statnet.common', 'stats', 'stats4', 'stopwords', 'streamR', 'stringdist', 'stringi', 'stringr', 'strucchange', 'survival', 'svglite',
           'sys', 'tabplot', 'tau', 'tcltk', 'tclust', 'TeachingDemos', 'tensor', 'tensorflow', 'testthat', 'text2vec', 'textcat', 'tfruns',
           'TH.data', 'tibble', 'tidyr', 'tidyselect', 'tidytext', 'tidyverse', 'tiff', 'timeDate', 'timeline', 'timeSeries', 'tinytex', 'titanic',
           'tm', 'tokenizers', 'tools', 'topicmodels', 'transcribeR', 'tree', 'treeClust', 'triangle', 'triebeard', 'trimcluster', 'tseries', 'tsne',
           'TSP', 'TTR', 'tuneR', 'twitteR', 'ucminf', 'units', 'upclass', 'urca', 'urltools', 'uroot', 'USAboundaries', 'USAboundariesData',
           'usethis', 'utf8', 'utils', 'uuid', 'vcd', 'viridis', 'viridisLite', 'visNetwork', 'waterfalls', 'webshot', 'whisker', 'withr', 'wmtsa',
           'wordcloud', 'xfun', 'xgboost', 'xgboostExplainer', 'XML', 'xml2', 'xopen', 'xtable', 'xts', 'yaml', 'zip', 'zipfR', 'zoo')


if (length(packs) != length(unique(packs))) stop('Duplicated.')
if (any(packs != sort(packs))) stop('Wrong order')

my_packs <- installed.packages()[, 1]

mine_only <- my_packs[!(my_packs %in% packs)]

if (length(mine_only) > 0)
{
    cat('\nConsider adding these.\n\n')
    mine_only <-sort(mine_only)
    names(mine_only) <- NULL
    print(mine_only)
    # nice(c(packs, mine_only))
}

todo <- sort(unique(packs[!(packs %in% my_packs)]))

if (length(todo) > 0)
{
    cat('\nAdding these.\n\n')
    print(todo)
    cat('\n')

    sapply(todo, install.packages)
}
