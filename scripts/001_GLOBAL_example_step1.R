#> A title is mandatory, in the first row, starting with #> (a single line.)

#>> All remarks starting with #>> will be included when the project is exported as .csv

# Any other remark are ignored.

#A file whose name starts with _GLOBAL_ is supposed to contain global variables like metaparameters.

this_varible_is_global <- list(stuff = c('foo', 'bar'), x = 3.14)	# And is autoloaded and declared in all scripts whose number is bigger than 001.
