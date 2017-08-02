#> Learn a model using training data, save the model.


#>> Again, a script generating a file (a model in this case, not a data file) that will load automatically or recomputed as necessary.


build_example_model <- function()
{
    # Note that, unlike in the previous case, where I had to load(file = 'data/example_raw_as_binary.RData'), I do not have to load example_training,
    # since example_training is not DONTAUTOLOAD.

    Y <- example_training$x_squared

    model <- list(type = 'polinomial', degree = 2, a = 1, b = 0)

    model
}


example_model <- build_example_model()

save(example_model, file = 'data/example_model.RData')
