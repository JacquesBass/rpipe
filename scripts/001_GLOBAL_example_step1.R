#> A title is mandatory, in the first row, starting with #> (a single line.)


#>> All remarks starting with #>> will be included when the project is exported as .csv

# Any other remarks are ignored.

#>> A file whose name starts with _GLOBAL_ is supposed to contain global variables ONLY like metaparameters. It should load very fast!


this_varible_is_global <- list(stuff = c('foo', 'bar'), x = 3.14)   # And is available in all scripts whose number is bigger than its own.
