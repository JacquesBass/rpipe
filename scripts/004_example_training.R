#> Build the training data.frame.


#>> This is just a script like the previous one (a data saving script) except that it produces a smaller file (supposedly) and that data is always
#>> loaded and available for the scripts whose number is bigger than this one. (Note it is not DONTAUTOLOAD, that why it loads.)


build_example_training <- function()
{
	load(file = 'data/example_raw_as_binary.RData')

	train = data.frame(x_squared = example_raw_as_binary$x^2, stringsAsFactors = FALSE)

	train
}


example_training <- build_example_training()

save(example_training, file = 'data/example_training.RData')
