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


packs <- c('abind', 'acepack', 'ade4', 'arules', 'assertthat', 'audio', 'AzureML', 'backports', 'base', 'base64enc', 'BH', 'bibtex', 'bindr',
           'bindrcpp', 'bit', 'bit64', 'bitops', 'blob', 'boot', 'BradleyTerry2', 'brew', 'brglm', 'broom', 'callr', 'car', 'carData', 'caret',
           'caretEnsemble', 'catboost', 'caTools', 'cellranger', 'checkmate', 'chron', 'Ckmeans.1d.dp', 'class', 'classInt', 'cld2', 'cli', 'cluster',
           'clv', 'coda', 'codetools', 'coin', 'colorspace', 'colourpicker', 'combinat', 'commonmark', 'compiler', 'config', 'CORElearn', 'crayon',
           'crosstalk', 'curl', 'CVST', 'darch', 'data.table', 'datasets', 'DBI', 'dbplyr', 'ddalpha', 'debugme', 'deepboost', 'deepnet',
           'dendextend', 'DEoptimR', 'desc', 'devtools', 'DiagrammeR', 'dichromat', 'digest', 'dimRed', 'diptest', 'doParallel', 'dotCall64',
           'downloader', 'dplyr', 'DRR', 'DT', 'dtplyr', 'dtw', 'e1071', 'earth', 'ellipse', 'entropy', 'evaluate', 'extrafont', 'extrafontdb',
           'FactoMineR', 'fastmatch', 'fclust', 'fda', 'ff', 'ffbase', 'fields', 'fImport', 'flashClust', 'flexclust', 'flexmix', 'FNN', 'forcats',
           'foreach', 'forecast', 'foreign', 'formatR', 'Formula', 'fpc', 'fracdiff', 'fs', 'functional', 'futile.logger', 'futile.options', 'gbm',
           'gclus', 'gdata', 'gdtools', 'gender', 'geometry', 'geosphere', 'ggmap', 'ggplot2', 'ggrepel', 'ggthemes', 'gistr', 'git2r', 'glmnet',
           'glue', 'gmodels', 'gmp', 'googlesheets', 'googleVis', 'gower', 'gplots', 'graphics', 'grDevices', 'grid', 'gridBase', 'gridExtra',
           'gsubfn', 'gtable', 'gtools', 'haven', 'hexbin', 'highlight', 'highr', 'Hmisc', 'hms', 'htmlTable', 'htmltools', 'htmlwidgets', 'httpuv',
           'httr', 'ifultools', 'igraph', 'influenceR', 'inline', 'inum', 'ipred', 'irlba', 'ISOcodes', 'iterators', 'jomo', 'jpeg', 'jsonlite',
           'kerasR', 'kernlab', 'KernSmooth', 'klaR', 'knitr', 'labeling', 'labelled', 'lambda.r', 'lars', 'later', 'lattice', 'latticeExtra', 'lava',
           'lazyeval', 'lda', 'leaflet', 'leaps', 'libcoin', 'lightgbm', 'lme4', 'lmtest', 'locpol', 'logistf', 'lpSolve', 'lsa', 'lubridate',
           'magic', 'magrittr', 'manipulate', 'mapproj', 'maps', 'maptools', 'markdown', 'MASS', 'Matrix', 'MatrixModels', 'maxent', 'mboost',
           'mcclust', 'mclust', 'memoise', 'methods', 'Metrics', 'mgcv', 'mice', 'mime', 'miniCRAN', 'miniUI', 'minqa', 'misc3d', 'mitml', 'mlapi',
           'mnormt', 'ModelMetrics', 'modelr', 'modeltools', 'monitoR', 'multcomp', 'munsell', 'mvtnorm', 'ndjson', 'network', 'neuralnet',
           'NeuralNetTools', 'ngram', 'nlme', 'nloptr', 'NLP', 'NMF', 'nnet', 'nnls', 'nplr', 'numbers', 'numDeriv', 'officer', 'openssl', 'openxlsx',
           'osmar', 'packrat', 'pan', 'parallel', 'party', 'partykit', 'pbapply', 'pbkrtest', 'pdc', 'pdftools', 'pillar', 'pkgbuild', 'pkgconfig',
           'pkgdown', 'pkgload', 'pkgmaker', 'PKI', 'plogr', 'plotly', 'plotmo', 'plotrix', 'pls', 'plyr', 'png', 'prabclus', 'praise', 'prettyunits',
           'pROC', 'processx', 'prodlim', 'profileModel', 'promises', 'proto', 'proxy', 'pryr', 'psych', 'purrr', 'pwr', 'qap', 'qdapDictionaries',
           'qdapRegex', 'qdapTools', 'quadprog', 'Quandl', 'quanteda', 'quantmod', 'quantreg', 'questionr', 'quickcheck', 'qvcalc', 'R.methodsS3',
           'R.oo', 'R.utils', 'R6', 'randomForest', 'RANN', 'raster', 'rbenchmark', 'rbokeh', 'RColorBrewer', 'Rcpp', 'RcppArmadillo', 'RcppEigen',
           'RcppExamples', 'RcppParallel', 'RcppRoll', 'RCurl', 'readr', 'readxl', 'recipes', 'recommenderlab', 'registry', 'rematch', 'reports',
           'reprex', 'reshape', 'reshape2', 'reticulate', 'rgexf', 'RgoogleMaps', 'rio', 'rjazz', 'rjson', 'RJSONIO', 'rlang', 'rmarkdown', 'Rmixmod',
           'rngtools', 'ROAuth', 'robustbase', 'ROCR', 'Rook', 'roxygen2', 'rpart', 'rpart.plot', 'rprojroot', 'rredis', 'RSclient', 'rsconnect',
           'Rserve', 'RSpectra', 'RSQLite', 'rstudioapi', 'RTextTools', 'Rttf2pt1', 'RUnit', 'rversions', 'rvest', 'rvg', 'rworldmap', 'sandwich',
           'scales', 'scatterplot3d', 'seewave', 'segmented', 'selectr', 'seriation', 'sfsmisc', 'shiny', 'shinyBS', 'shinydashboard', 'shinyjs',
           'signal', 'slam', 'sn', 'sna', 'snow', 'SnowballC', 'sourcetools', 'sp', 'spa', 'spacyr', 'spam', 'SparseM', 'sparsepp', 'spatial',
           'spData', 'splines', 'splus2R', 'sqldf', 'SQUAREM', 'stabs', 'statnet.common', 'stats', 'stats4', 'stopwords', 'streamR', 'stringdist',
           'stringi', 'stringr', 'strucchange', 'survival', 'tabplot', 'tau', 'tcltk', 'tclust', 'TeachingDemos', 'tensorflow', 'testthat',
           'text2vec', 'textcat', 'tfruns', 'TH.data', 'tibble', 'tidyr', 'tidyselect', 'tidyverse', 'timeDate', 'timeline', 'timeSeries', 'tinytex',
           'titanic', 'tm', 'tools', 'transcribeR', 'tree', 'treeClust', 'triangle', 'trimcluster', 'tseries', 'tsne', 'TSP', 'TTR', 'tuneR',
           'twitteR', 'upclass', 'urca', 'uroot', 'USAboundaries', 'USAboundariesData', 'utf8', 'utils', 'uuid', 'vcd', 'viridis', 'viridisLite',
           'visNetwork', 'waterfalls', 'whisker', 'withr', 'wmtsa', 'wordcloud', 'xgboost', 'xgboostExplainer', 'XML', 'xml2', 'xtable', 'xts',
           'yaml', 'zip', 'zipfR', 'zoo')


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
