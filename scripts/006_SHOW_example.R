#> Show things, typically data.


#>> Scripts with SHOW (like GLOBAL and FUNCTION) have no expected structure, unlike those who create files.

#>> Like GLOBAL and FUNCTION that only contain declarations, SHOW scripts should be fast to load. If you need computation, create a file to store
#>> their results and use the SHOW script just to display results.


cat('\n') # Empty line looks nice here.

#Note that all variables declared in lower numbered GLOBAL scripts can be used.
cat('My metaparameter x is :', this_varible_is_global$x, '\n')

#Same with functions.
cat('Model is              :', amazing_function('polynomial'), '\n')

#And with data.
cat('Parameter a           :', example_model$a, '\n')
cat('Parameter b           :', example_model$b, '\n')

cat('\n') # Empty line looks nice here.
