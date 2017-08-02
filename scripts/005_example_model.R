#> Learn a model using training data, save the model.


#>> This is just a script like the previous one (a data saving script) except that it produces a smaller file (supposedly) and that data is always
#>> loaded and available for the scripts whose number is bigger than this one. (Note it is not DONTAUTOLOAD, that why it loads.)


build_example_model <- function()
{
	# Note that, unlike in the previous case, where I had to load(file = 'data/example_raw_as_binary.RData') since example_raw_as_binary is
	# DONTAUTOLOAD, I do not have to load example_training, since example_training is not. example_training is available to all scripts whose number
	# is bigger than that of its creating script. rpipe will load it rather than build it, except when necessary.

	Y <- example_training$x_squared

	model <- list(type = 'polinomial', degree = 2, a = 1, b = 0)

	model
}


example_model <- build_example_model()

save(example_model, file = 'data/example_model.RData')
