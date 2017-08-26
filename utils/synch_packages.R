packs <- c('abind', 'arules', 'assertthat', 'backports', 'base', 'base64enc', 'BH', 'bindr', 'bindrcpp', 'bit', 'bit64', 'bitops', 'blob', 'Boom',
           'BoomSpikeSlab', 'boot', 'brew', 'bsts', 'car', 'caret', 'caretEnsemble', 'catboost', 'caTools', 'CausalImpact', 'cellranger', 'chron',
           'Ckmeans.1d.dp', 'class', 'cluster', 'clv', 'codetools', 'coin', 'colorspace', 'combinat', 'compiler', 'config', 'CORElearn', 'crayon',
           'crosstalk', 'curl', 'darch', 'data.table', 'datasets', 'DBI', 'debugme', 'deepboost', 'deepnet', 'dendextend', 'DEoptimR', 'devtools',
           'DiagrammeR', 'dichromat', 'digest', 'diptest', 'doParallel', 'downloader', 'dplyr', 'e1071', 'earth', 'evaluate', 'fclust', 'flexclust',
           'flexmix', 'FNN', 'foreach', 'forecast', 'foreign', 'fpc', 'fracdiff', 'futile.logger', 'futile.options', 'gbm', 'gdata', 'gender',
           'geometry', 'geosphere', 'ggmap', 'ggplot2', 'ggthemes', 'git2r', 'glmnet', 'glue', 'gmodels', 'googlesheets', 'googleVis', 'gplots',
           'graphics', 'grDevices', 'grid', 'gridBase', 'gridExtra', 'gsubfn', 'gtable', 'gtools', 'highr', 'hms', 'htmltools', 'htmlwidgets',
           'httpuv', 'httr', 'igraph', 'influenceR', 'inline', 'ipred', 'irlba', 'iterators', 'jpeg', 'jsonlite', 'kerasR', 'kernlab', 'KernSmooth',
           'klaR', 'knitr', 'labeling', 'lambda.r', 'lars', 'lattice', 'lava', 'lazyeval', 'leaflet', 'lightgbm', 'lme4', 'lmtest', 'lpSolve',
           'magic', 'magrittr', 'manipulate', 'mapproj', 'maps', 'markdown', 'MASS', 'Matrix', 'MatrixModels', 'mboost', 'mcclust', 'mclust',
           'memoise', 'methods', 'Metrics', 'mgcv', 'mime', 'minqa', 'misc3d', 'mnormt', 'ModelMetrics', 'modeltools', 'multcomp', 'munsell',
           'mvtnorm', 'neuralnet', 'NeuralNetTools', 'nlme', 'nloptr', 'NLP', 'NMF', 'nnet', 'nnls', 'numDeriv', 'openssl', 'parallel', 'party',
           'pbapply', 'pbkrtest', 'pkgconfig', 'pkgmaker', 'PKI', 'plogr', 'plotmo', 'plotrix', 'plyr', 'png', 'prabclus', 'praise', 'processx',
           'prodlim', 'proto', 'purrr', 'qdapDictionaries', 'qdapRegex', 'qdapTools', 'quadprog', 'Quandl', 'quantmod', 'quantreg', 'R6',
           'randomForest', 'RANN', 'raster', 'RColorBrewer', 'Rcpp', 'RcppArmadillo', 'RcppEigen', 'RCurl', 'readr', 'registry', 'rematch', 'reports',
           'reshape2', 'reticulate', 'rgexf', 'RgoogleMaps', 'rjazz', 'rjson', 'rlang', 'rmarkdown', 'rngtools', 'robustbase', 'ROCR', 'Rook',
           'rpart', 'rprojroot', 'Rserve', 'RSQLite', 'rstudioapi', 'sandwich', 'scales', 'segmented', 'shiny', 'slam', 'sn', 'SnowballC',
           'sourcetools', 'sp', 'SparseM', 'spatial', 'splines', 'sqldf', 'stabs', 'stats', 'stats4', 'stringdist', 'stringi', 'stringr',
           'strucchange', 'survival', 'tcltk', 'tclust', 'TeachingDemos', 'tensorflow', 'testthat', 'tfruns', 'TH.data', 'tibble', 'tidyr',
           'tidyselect', 'timeDate', 'timeSeries', 'titanic', 'tm', 'tools', 'tree', 'treeClust', 'triangle', 'trimcluster', 'tseries', 'TTR',
           'USAboundaries', 'USAboundariesData', 'utils', 'vcd', 'viridis', 'viridisLite', 'visNetwork', 'whisker', 'withr', 'wordcloud', 'xgboost',
           'XML', 'xml2', 'xtable', 'xts', 'yaml', 'zoo')


if (length(packs) != length(unique(packs))) stop('Duplicated.')
if (any(packs != sort(packs))) stop('Wrong order')

my_packs <- installed.packages()[, 1]

mine_only <- my_packs[!(my_packs %in% packs)]

if (length(mine_only) > 0)
{
    cat('\nConsider adding these.\n\n')
    print(mine_only)
}

todo <- sort(unique(packs[!(packs %in% my_packs)]))

if (length(todo) > 0)
{
    cat('\nAdding these.\n\n')
    print(todo)
    cat('\n')

    sapply(todo, install.packages)
}

