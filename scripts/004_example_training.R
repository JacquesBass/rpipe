#> Build the training data.frame.


#>> This is just a script like the previous one (a data saving script) except that it produces a (supposedly) smaller file and its resulting data is
#>> always loaded and available for the scripts whose number is bigger than this one's. (Note: It is not DONTAUTOLOAD, that's why it loads.)

#>> Also, rpipe will load it rather than build it, except when necessary (some file below it was updated or its data file is missing).


build_example_training <- function()
{
	# I have to load the required example_raw_as_binary explicitly, since it is DONTAUTOLOAD.

	load(file = 'data/example_raw_as_binary.RData')

	train = data.frame(x_squared = example_raw_as_binary$x^2, stringsAsFactors = FALSE)

	train
}


example_training <- build_example_training()

save(example_training, file = 'data/example_training.RData')
