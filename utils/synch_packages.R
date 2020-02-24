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


packs <- c('abind', 'acepack', 'adagio', 'ade4', 'AlgDesign', 'arules', 'askpass', 'assertthat', 'AUC', 'audio', 'backports', 'base', 'base64enc',
           'BH', 'bibtex', 'bigmemory', 'bigmemory.sri', 'bindr', 'bindrcpp', 'Biobase', 'BiocGenerics', 'BiocManager', 'BiocVersion', 'bit', 'bit64',
           'bitops', 'blob', 'bmp', 'boot', 'BradleyTerry2', 'brew', 'brglm', 'broom', 'ca', 'CAinterprTools', 'Cairo', 'callr', 'car', 'carData',
           'caret', 'caretEnsemble', 'catboost', 'caTools', 'cellranger', 'ChannelAttribution', 'checkmate', 'chron', 'Ckmeans.1d.dp', 'class',
           'classInt', 'cld2', 'cli', 'clipr', 'clisymbols', 'cluster', 'clv', 'coda', 'codetools', 'coin', 'colorspace', 'colourpicker', 'combinat',
           'commonmark', 'compiler', 'config', 'conjoint', 'CORElearn', 'corrplot', 'covr', 'cowplot', 'crayon', 'crosstalk', 'curl', 'CVST',
           'data.table', 'datasets', 'DBI', 'dbplyr', 'dcurver', 'ddalpha', 'debugme', 'deepboost', 'deepnet', 'deldir', 'dendextend', 'DEoptimR',
           'Deriv', 'desc', 'devtools', 'DiagrammeR', 'dichromat', 'digest', 'dimRed', 'diptest', 'doParallel', 'dotCall64', 'downloader', 'dplyr',
           'DRR', 'DT', 'dtplyr', 'dtw', 'e1071', 'earth', 'ellipse', 'ellipsis', 'entropy', 'eRm', 'evaluate', 'expm', 'extrafont', 'extrafontdb',
           'factoextra', 'FactoMineR', 'fansi', 'farver', 'fastmap', 'fastmatch', 'fclust', 'fda', 'ff', 'ffbase', 'fields', 'fImport', 'flashClust',
           'flexclust', 'flexmix', 'float', 'FNN', 'forcats', 'foreach', 'forecast', 'foreign', 'formatR', 'Formula', 'fpc', 'fracdiff', 'fs',
           'functional', 'futile.logger', 'futile.options', 'gbm', 'gbRd', 'gclus', 'gdata', 'gdtools', 'gender', 'generics', 'geometry', 'geosphere',
           'ggforce', 'ggfortify', 'ggmap', 'ggplot2', 'ggpubr', 'ggraph', 'ggrepel', 'ggsci', 'ggsignif', 'ggthemes', 'gh', 'gistr', 'git2r', 'glue',
           'gmodels', 'gmp', 'goftest', 'googlesheets', 'googleVis', 'gower', 'GPArotation', 'gplots', 'graphics', 'graphlayouts', 'grDevices',
           'grid', 'gridBase', 'gridExtra', 'gsubfn', 'gtable', 'gtools', 'gutenbergr', 'h2o', 'haven', 'hdf5r', 'hexbin', 'highlight', 'highr',
           'Hmisc', 'hms', 'htmlTable', 'htmltools', 'htmlwidgets', 'httpuv', 'httr', 'hunspell', 'ifultools', 'igraph', 'imager', 'influenceR',
           'ini', 'inline', 'inum', 'ipred', 'irlba', 'ISOcodes', 'iterators', 'janeaustenr', 'jomo', 'jpeg', 'jsonlite', 'kerasR', 'kernlab',
           'KernSmooth', 'klaR', 'knitr', 'labeling', 'labelled', 'lambda.r', 'lars', 'lasso2', 'later', 'lattice', 'latticeExtra', 'lava',
           'lazyeval', 'lda', 'leaflet', 'leaflet.providers', 'leaps', 'lgr', 'libcoin', 'lifecycle', 'lightgbm', 'linprog', 'lme4', 'lmtest',
           'locpol', 'logistf', 'lpSolve', 'lsa', 'ltm', 'lubridate', 'magic', 'magrittr', 'manipulate', 'mapproj', 'maps', 'maptools', 'markdown',
           'markovchain', 'MASS', 'matlab', 'Matrix', 'MatrixModels', 'matrixStats', 'mboost', 'mcclust', 'mclust', 'memoise', 'methods', 'Metrics',
           'mgcv', 'mice', 'microbenchmark', 'mime', 'miniCRAN', 'miniUI', 'minqa', 'mirt', 'misc3d', 'mitml', 'mitools', 'mlapi', 'mlbench',
           'mlogit', 'mnormt', 'ModelMetrics', 'modelr', 'modeltools', 'monitoR', 'msm', 'multcomp', 'munsell', 'mvtnorm', 'NbClust', 'ndjson',
           'netrankr', 'network', 'neuralnet', 'NeuralNetTools', 'ngram', 'nlme', 'nloptr', 'NLP', 'NMF', 'nnet', 'nnls', 'nortest', 'nplr',
           'numbers', 'numDeriv', 'OAIHarvester', 'officer', 'opencage', 'openssl', 'openxlsx', 'ordinal', 'osmar', 'packrat', 'pan', 'parallel',
           'party', 'partykit', 'pbapply', 'pbkrtest', 'pdc', 'pdftools', 'permute', 'pheatmap', 'phonTools', 'pillar', 'pixmap', 'pkgbuild',
           'pkgconfig', 'pkgdown', 'pkgload', 'pkgmaker', 'PKI', 'plogr', 'plotly', 'plotmo', 'plotrix', 'pls', 'plyr', 'png', 'polyclip', 'polycor',
           'polynom', 'pool', 'prabclus', 'praise', 'prettyunits', 'pricesensitivitymeter', 'pROC', 'processx', 'prodlim', 'profileModel', 'progress',
           'promises', 'proto', 'proxy', 'proxyC', 'pryr', 'ps', 'psych', 'purrr', 'pwr', 'qap', 'qdapDictionaries', 'qdapRegex', 'qdapTools', 'qpdf',
           'quadprog', 'Quandl', 'quanteda', 'quantmod', 'quantreg', 'questionr', 'qvcalc', 'R.methodsS3', 'R.oo', 'R.utils', 'R6', 'randomForest',
           'RANN', 'rappdirs', 'raster', 'rbenchmark', 'rbokeh', 'rcmdcheck', 'RcmdrMisc', 'RColorBrewer', 'Rcpp', 'RcppArmadillo', 'RcppEigen',
           'RcppExamples', 'RcppParallel', 'RcppProgress', 'RcppRoll', 'RCurl', 'Rdpack', 'readbitmap', 'readr', 'readstata13', 'readxl', 'recipes',
           'recommenderlab', 'recosystem', 'registry', 'rematch', 'rematch2', 'remotes', 'reports', 'reprex', 'reshape', 'reshape2', 'reticulate',
           'rex', 'rfm', 'rgdal', 'rgexf', 'RgoogleMaps', 'RhpcBLASctl', 'rio', 'rjazz', 'rjson', 'RJSONIO', 'rlang', 'rmarkdown', 'Rmixmod', 'Rmpfr',
           'rngtools', 'ROAuth', 'robustbase', 'ROCR', 'Rook', 'roxygen2', 'rpart', 'rpart.plot', 'rprojroot', 'rredis', 'RSclient', 'rsconnect',
           'Rserve', 'rsparse', 'RSpectra', 'RSQLite', 'rstudioapi', 'Rttf2pt1', 'RUnit', 'rversions', 'rvest', 'rvg', 'rworldmap', 'sandwich',
           'satellite', 'scales', 'scatterplot3d', 'seewave', 'segmented', 'selectr', 'seriation', 'servr', 'sessioninfo', 'sf', 'sfsmisc', 'shape',
           'shiny', 'shinyBS', 'shinydashboard', 'shinyjs', 'signal', 'slam', 'sn', 'sna', 'snow', 'SnowballC', 'soundgen', 'sourcetools', 'sp',
           'spacyr', 'spam', 'SparseM', 'sparsepp', 'spatial', 'spatstat', 'spatstat.data', 'spatstat.utils', 'spData', 'splines', 'splus2R', 'sqldf',
           'SQUAREM', 'stabs', 'statmod', 'statnet.common', 'stats', 'stats4', 'stopwords', 'streamR', 'stringdist', 'stringi', 'stringr',
           'strucchange', 'survey', 'survival', 'svglite', 'sys', 'systemfonts', 'tau', 'tcltk', 'tclust', 'TeachingDemos', 'tensor', 'tensorflow',
           'testthat', 'text2vec', 'textcat', 'tfruns', 'TH.data', 'tibble', 'tidygraph', 'tidyr', 'tidyselect', 'tidytext', 'tidyverse', 'tiff',
           'timeDate', 'timeline', 'timeSeries', 'tinytex', 'titanic', 'tm', 'tokenizers', 'tools', 'topicmodels', 'transcribeR', 'treeClust',
           'triangle', 'triebeard', 'trimcluster', 'tseries', 'tsne', 'TSP', 'TTR', 'tuneR', 'tweenr', 'twitteR', 'ucminf', 'units', 'urca',
           'urltools', 'uroot', 'usethis', 'utf8', 'utils', 'uuid', 'vcd', 'vctrs', 'vegan', 'viridis', 'viridisLite', 'visNetwork', 'waterfalls',
           'webshot', 'whisker', 'withr', 'wmtsa', 'wordcloud', 'xfun', 'xgboost', 'XML', 'xml2', 'xopen', 'xplorerr', 'xtable', 'xts', 'yaml',
           'zeallot', 'zip', 'zipfR', 'zoo')


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

    install.packages(todo)
}
