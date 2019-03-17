if (!require('catboost')) {
    devtools::install_github('catboost/catboost', subdir = 'catboost/R-package')
}

if (!require('lightgbm')) {
    # git clone --recursive https://github.com/Microsoft/LightGBM
    # cd LightGBM
    # Rscript build_r.R
}

if (!require('mxnet')) {
    # git clone --recursive https://github.com/apache/incubator-mxnet.git mxnet
    # cd mxnet/docs/install
    # ./install_mxnet_ubuntu_python.sh
    # ./install_mxnet_ubuntu_r.sh
}

if (!require('USAboundariesData')) {
    USAboundaries::us_boundaries(resolution = 'high')
}
