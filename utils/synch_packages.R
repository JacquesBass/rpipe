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

packs <- c('abind', 'acepack', 'ade4', 'arules', 'assertthat', 'AzureML', 'backports', 'base', 'base64enc', 'BH', 'bindr', 'bindrcpp', 'bit', 
           'bit64', 'bitops', 'blob', 'Boom', 'BoomSpikeSlab', 'boot', 'BradleyTerry2', 'brew', 'brglm', 'bsts', 'car', 'caret', 'caretEnsemble', 
           'catboost', 'caTools', 'CausalImpact', 'cellranger', 'checkmate', 'chron', 'Ckmeans.1d.dp', 'class', 'cld2', 'cluster', 'clv', 'codetools', 
           'coin', 'colorspace', 'combinat', 'commonmark', 'compiler', 'config', 'CORElearn', 'crayon', 'crosstalk', 'curl', 'darch', 'data.table', 
           'datasets', 'DBI', 'debugme', 'deepboost', 'deepnet', 'dendextend', 'DEoptimR', 'desc', 'devtools', 'DiagrammeR', 'dichromat', 'digest', 
           'diptest', 'doParallel', 'dotCall64', 'downloader', 'dplyr', 'dtw', 'e1071', 'earth', 'ellipse', 'evaluate', 'FactoMineR', 'fclust', 
           'fields', 'fImport', 'flashClust', 'flexclust', 'flexmix', 'FNN', 'foreach', 'forecast', 'foreign', 'formatR', 'Formula', 'fpc', 
           'fracdiff', 'functional', 'futile.logger', 'futile.options', 'gbm', 'gdata', 'gender', 'geometry', 'geosphere', 'ggmap', 'ggplot2', 
           'ggthemes', 'gistr', 'git2r', 'glmnet', 'glue', 'gmodels', 'gmp', 'googlesheets', 'googleVis', 'gplots', 'graphics', 'grDevices', 'grid', 
           'gridBase', 'gridExtra', 'gsubfn', 'gtable', 'gtools', 'hexbin', 'highr', 'Hmisc', 'hms', 'htmlTable', 'htmltools', 'htmlwidgets', 
           'httpuv', 'httr', 'ifultools', 'igraph', 'influenceR', 'inline', 'ipred', 'irlba', 'iterators', 'jpeg', 'jsonlite', 'kerasR', 'kernlab', 
           'KernSmooth', 'klaR', 'knitr', 'labeling', 'lambda.r', 'lars', 'lattice', 'latticeExtra', 'lava', 'lazyeval', 'leaflet', 'leaps', 
           'lightgbm', 'lme4', 'lmtest', 'locpol', 'lpSolve', 'magic', 'magrittr', 'manipulate', 'mapproj', 'maps', 'maptools', 'markdown', 'MASS', 
           'Matrix', 'MatrixModels', 'mboost', 'mcclust', 'mclust', 'memoise', 'methods', 'Metrics', 'mgcv', 'mime', 'miniCRAN', 'minqa', 'misc3d', 
           'mnormt', 'ModelMetrics', 'modeltools', 'multcomp', 'munsell', 'mvtnorm', 'neuralnet', 'NeuralNetTools', 'nlme', 'nloptr', 'NLP', 'NMF', 
           'nnet', 'nnls', 'numbers', 'numDeriv', 'openssl', 'osmar', 'parallel', 'party', 'partykit', 'pbapply', 'pbkrtest', 'pdc', 'pkgconfig', 
           'pkgmaker', 'PKI', 'plogr', 'plotly', 'plotmo', 'plotrix', 'plyr', 'png', 'prabclus', 'praise', 'processx', 'prodlim', 'profileModel', 
           'proto', 'proxy', 'pryr', 'purrr', 'pwr', 'qdapDictionaries', 'qdapRegex', 'qdapTools', 'quadprog', 'Quandl', 'quantmod', 'quantreg', 'R6', 
           'randomForest', 'RANN', 'raster', 'rbenchmark', 'rbokeh', 'RColorBrewer', 'Rcpp', 'RcppArmadillo', 'RcppEigen', 'RCurl', 'readr', 
           'registry', 'rematch', 'reports', 'reshape2', 'reticulate', 'rgexf', 'RgoogleMaps', 'rjazz', 'rjson', 'RJSONIO', 'rlang', 'rmarkdown', 
           'rngtools', 'ROAuth', 'robustbase', 'ROCR', 'Rook', 'roxygen2', 'rpart', 'rpart.plot', 'rprojroot', 'rredis', 'RSclient', 'Rserve', 
           'RSQLite', 'rstudioapi', 'RUnit', 'rversions', 'rworldmap', 'sandwich', 'scales', 'scatterplot3d', 'segmented', 'shiny', 'slam', 'sn', 
           'SnowballC', 'sourcetools', 'sp', 'spam', 'SparseM', 'spatial', 'splines', 'splus2R', 'sqldf', 'stabs', 'stats', 'stats4', 'streamR', 
           'stringdist', 'stringi', 'stringr', 'strucchange', 'survival', 'tau', 'tcltk', 'tclust', 'TeachingDemos', 'tensorflow', 'testthat', 
           'textcat', 'tfruns', 'TH.data', 'tibble', 'tidyr', 'tidyselect', 'timeDate', 'timeline', 'timeSeries', 'titanic', 'tm', 'tools', 'tree', 
           'treeClust', 'triangle', 'trimcluster', 'tseries', 'TTR', 'twitteR', 'USAboundaries', 'USAboundariesData', 'utils', 'uuid', 'vcd', 
           'viridis', 'viridisLite', 'visNetwork', 'whisker', 'withr', 'wmtsa', 'wordcloud', 'xgboost', 'XML', 'xml2', 'xtable', 'xts', 'yaml', 'zoo')


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
