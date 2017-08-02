#> Function declarations.


#>> A file whose name starts with _FUNCTION_ is supposed to contain global functions ONLY. It should load very fast!


#>> convert_wrong_to_right(): A silly name for an inefficient boolean NOT operator.
convert_wrong_to_right <- function(wrong)
{
	right <- !wrong

	right
}


#>> amazing_function(): Self proclaimed amazingness made simple.
amazing_function <- function(something)
{
	paste('Amazing', something, '!')
}
