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


packs <- c('abind', 'acepack', 'adagio', 'ade4', 'admisc', 'AlgDesign', 'alphavantager', 'anytime', 'arules', 'ash', 'askpass', 'assertthat', 'AUC',
           'audio', 'backports', 'base', 'base64enc', 'beepr', 'BH', 'bibtex', 'bigmemory', 'bigmemory.sri', 'bindr', 'bindrcpp', 'binom', 'Biobase',
           'BiocGenerics', 'BiocManager', 'BiocVersion', 'bit', 'bit64', 'bitops', 'blob', 'bmp', 'Boom', 'BoomSpikeSlab', 'boot', 'BradleyTerry2',
           'brew', 'brglm', 'brio', 'broom', 'bslib', 'bsts', 'ca', 'cachem', 'CAinterprTools', 'Cairo', 'callr', 'car', 'carData', 'caret',
           'caretEnsemble', 'caRtociudad', 'caTools', 'CausalImpact', 'cellranger', 'ChannelAttribution', 'checkmate', 'chron', 'Ckmeans.1d.dp',
           'class', 'classInt', 'cld2', 'cli', 'clipr', 'clisymbols', 'clock', 'cluster', 'clv', 'coda', 'codetools', 'coin', 'collections',
           'colorspace', 'colourpicker', 'combinat', 'commonmark', 'compiler', 'config', 'conflicted', 'conjoint', 'conquer', 'CORElearn', 'corrplot',
           'covr', 'cowplot', 'cpp11', 'crayon', 'credentials', 'crosstalk', 'crul', 'curl', 'CVST', 'cyclocomp', 'data.table', 'datasets', 'DBI',
           'dbplyr', 'dcurver', 'ddalpha', 'debugme', 'deepboost', 'deepnet', 'deldir', 'dendextend', 'DEoptimR', 'Deriv', 'desc', 'deSolve',
           'devtools', 'dfidx', 'diagram', 'DiagrammeR', 'dichromat', 'diffobj', 'digest', 'dimRed', 'diptest', 'doParallel', 'dotCall64', 'downlit',
           'downloader', 'dplyr', 'DRR', 'DT', 'dtplyr', 'dtw', 'e1071', 'earth', 'EBImage', 'ellipse', 'ellipsis', 'emmeans', 'entropy', 'eRm',
           'estimability', 'evaluate', 'expm', 'extrafont', 'extrafontdb', 'factoextra', 'FactoMineR', 'fansi', 'farver', 'fastmap', 'fastmatch',
           'fclust', 'fda', 'fds', 'ff', 'fftwtools', 'fields', 'fImport', 'flashClust', 'flexclust', 'flexmix', 'float', 'FNN', 'fontawesome',
           'fontBitstreamVera', 'fontLiberation', 'fontquiver', 'forcats', 'foreach', 'forecast', 'foreign', 'formatR', 'Formula', 'formula.tools',
           'fpc', 'fracdiff', 'fs', 'functional', 'furrr', 'futile.logger', 'futile.options', 'future', 'future.apply', 'gargle', 'gbm', 'gbRd',
           'gclus', 'gdata', 'gdtools', 'gender', 'generics', 'geometry', 'geosphere', 'gert', 'gfonts', 'ggfittext', 'ggforce', 'ggfortify', 'ggmap',
           'ggplot2', 'ggpubr', 'ggraph', 'ggrepel', 'ggsci', 'ggsignif', 'ggthemes', 'gh', 'gistr', 'git2r', 'gitcreds', 'glmnet', 'globals', 'glue',
           'gmodels', 'gmp', 'goftest', 'googledrive', 'googlesheets4', 'googleVis', 'gower', 'GPArotation', 'gplots', 'graphics', 'graphlayouts',
           'grDevices', 'grid', 'gridBase', 'gridExtra', 'gridtext', 'gsubfn', 'gtable', 'gtools', 'gutenbergr', 'h2o', 'hardhat', 'haven', 'hdf5r',
           'hdrcde', 'here', 'hexbin', 'highlight', 'highr', 'Hmisc', 'hms', 'htmlTable', 'htmltools', 'htmlwidgets', 'httpcode', 'httpuv', 'httr',
           'httr2', 'hunspell', 'ids', 'igraph', 'influenceR', 'ini', 'inline', 'interp', 'inum', 'ipred', 'irlba', 'isoband', 'ISOcodes',
           'iterators', 'janeaustenr', 'jomo', 'jpeg', 'jquerylib', 'jsonlite', 'kerasR', 'kernlab', 'KernSmooth', 'klaR', 'knitr', 'ks', 'labeling',
           'labelled', 'lambda.r', 'languageserver', 'lars', 'later', 'lattice', 'latticeExtra', 'lava', 'lazyeval', 'lda', 'leaflet',
           'leaflet.providers', 'leaps', 'lgr', 'libcoin', 'lifecycle', 'lightgbm', 'linprog', 'lintr', 'listenv', 'lme4', 'lmtest', 'lobstr',
           'locfit', 'locpol', 'logistf', 'lpSolve', 'lsa', 'ltm', 'lubridate', 'lutz', 'magic', 'magrittr', 'manipulate', 'mapproj', 'maps',
           'maptools', 'markdown', 'markovchain', 'MASS', 'matlab', 'Matrix', 'MatrixExtra', 'MatrixModels', 'matrixStats', 'mboost', 'mcclust',
           'mclust', 'memoise', 'methods', 'Metrics', 'mgcv', 'mice', 'microbenchmark', 'mime', 'miniCRAN', 'miniUI', 'minqa', 'mirt', 'misc3d',
           'mitml', 'mitools', 'mlapi', 'mlbench', 'mlogit', 'mnormt', 'ModelMetrics', 'modelr', 'modeltools', 'monitoR', 'msm', 'multcomp',
           'multcompView', 'multicool', 'munsell', 'mvtnorm', 'NbClust', 'ncdf4', 'ndjson', 'netrankr', 'network', 'neuralnet', 'NeuralNetTools',
           'ngram', 'nlme', 'nloptr', 'NLP', 'NMF', 'nnet', 'nnls', 'nonlinearTseries', 'nortest', 'nplr', 'numbers', 'numDeriv', 'OAIHarvester',
           'officer', 'opencage', 'openssl', 'openxlsx', 'operator.tools', 'ordinal', 'osmar', 'packrat', 'padr', 'pan', 'parallel', 'parallelly',
           'party', 'partykit', 'pbapply', 'pbkrtest', 'pcaPP', 'pdc', 'pdftools', 'PerformanceAnalytics', 'permute', 'pheatmap', 'phonTools',
           'pillar', 'pixmap', 'pkgbuild', 'pkgconfig', 'pkgdown', 'pkgload', 'PKI', 'plogr', 'plot3D', 'plotly', 'plotmo', 'plotrix', 'pls', 'plyr',
           'png', 'polyclip', 'polycor', 'polynom', 'pool', 'prabclus', 'pracma', 'praise', 'prettyunits', 'pricesensitivitymeter', 'pROC',
           'processx', 'prodlim', 'profileModel', 'profvis', 'progress', 'progressr', 'promises', 'proto', 'proxy', 'proxyC', 'pryr', 'ps', 'psych',
           'purrr', 'pwr', 'qap', 'qdapDictionaries', 'qdapRegex', 'qdapTools', 'qpdf', 'quadprog', 'Quandl', 'quanteda', 'quantmod', 'quantreg',
           'questionr', 'qvcalc', 'R.cache', 'R.methodsS3', 'R.oo', 'R.utils', 'R6', 'ragg', 'rainbow', 'randomForest', 'RANN', 'rappdirs', 'raster',
           'ratelimitr', 'rbenchmark', 'rbibutils', 'rbokeh', 'rcmdcheck', 'RcmdrMisc', 'RColorBrewer', 'Rcpp', 'RcppArmadillo', 'RcppEigen',
           'RcppExamples', 'RcppParallel', 'RcppProgress', 'RcppRoll', 'RcppTOML', 'RCurl', 'Rdpack', 'readbitmap', 'readr', 'readstata13', 'readxl',
           'recipes', 'recommenderlab', 'recosystem', 'registry', 'rematch', 'rematch2', 'remotes', 'renv', 'reprex', 'reshape', 'reshape2',
           'reticulate', 'rex', 'rfm', 'rgdal', 'rgexf', 'RgoogleMaps', 'RhpcBLASctl', 'riingo', 'rio', 'rjazz', 'rjson', 'RJSONIO', 'rlang', 'rle',
           'rmarkdown', 'Rmixmod', 'Rmpfr', 'rngtools', 'ROAuth', 'robustbase', 'ROCR', 'Rook', 'roxygen2', 'rpart', 'rpart.plot', 'rprojroot',
           'RPushbullet', 'rsample', 'RSclient', 'rsconnect', 'Rserve', 'rsparse', 'RSpectra', 'RSQLite', 'rstatix', 'rstudioapi', 'Rttf2pt1',
           'RUnit', 'rversions', 'rvest', 'rvg', 'rworldmap', 's2', 'sandwich', 'sass', 'satellite', 'scales', 'scatterplot3d', 'seewave',
           'segmented', 'selectr', 'seriation', 'servr', 'sessioninfo', 'sf', 'sfsmisc', 'shades', 'shape', 'shiny', 'shinyBS', 'shinydashboard',
           'shinyjs', 'signal', 'SimDesign', 'slam', 'slider', 'sn', 'sna', 'snow', 'SnowballC', 'soundgen', 'sourcetools', 'sp', 'spacyr', 'spam',
           'SparseM', 'sparsepp', 'spatial', 'spatstat', 'spatstat.data', 'spatstat.explore', 'spatstat.geom', 'spatstat.linnet', 'spatstat.model',
           'spatstat.random', 'spatstat.sparse', 'spatstat.univar', 'spatstat.utils', 'spData', 'splines', 'splus2R', 'sqldf', 'SQUAREM', 'stabs',
           'stationaRy', 'statmod', 'statnet.common', 'stats', 'stats4', 'stopwords', 'streamR', 'stringdist', 'stringi', 'stringr', 'strucchange',
           'styler', 'survey', 'survival', 'svglite', 'sys', 'systemfonts', 'tau', 'tcltk', 'tclust', 'TeachingDemos', 'tensor', 'tensorflow',
           'terra', 'testthat', 'text2vec', 'textcat', 'textshaping', 'tfautograph', 'tfruns', 'TH.data', 'tibble', 'tidygraph', 'tidyquant', 'tidyr',
           'tidyselect', 'tidytext', 'tidyverse', 'tiff', 'timechange', 'timeDate', 'timeSeries', 'timetk', 'tinytex', 'titanic', 'tm', 'tmvnsim',
           'tokenizers', 'tools', 'topicmodels', 'transcribeR', 'treeClust', 'treemapify', 'triangle', 'triebeard', 'trimcluster', 'tseries',
           'tsfeatures', 'tsne', 'TSP', 'TTR', 'tuneR', 'tweenr', 'twitteR', 'tzdb', 'ucminf', 'units', 'urca', 'urlchecker', 'urltools', 'uroot',
           'usethis', 'utf8', 'utils', 'uuid', 'vcd', 'vctrs', 'vegan', 'viridis', 'viridisLite', 'visNetwork', 'vroom', 'vscDebugger', 'waldo',
           'warp', 'waterfalls', 'webshot', 'whisker', 'withr', 'wk', 'wordcloud', 'writexl', 'xfun', 'xgboost', 'XML', 'xml2', 'xmlparsedata',
           'xopen', 'xplorerr', 'xtable', 'xts', 'yaml', 'zeallot', 'zip', 'zipfR', 'zoo')


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
