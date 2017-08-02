#> This writes (one of) the output files like csv, plots and pdfs.


#>> It is mandatory to use the "scripts" folder for scripts and the "data" folder for data created by them.
#>> It is recommended to use the "input" folder for raw input data and the "output" folder for pipeline results, but rpipe does not do anything
#>> with these folders except creating them when "rpipe.R init" is called.

#>> Again, all globals, functions and data (except DONTAUTOLOAD) declared or computed before are available.

#>> There is no imposed structure for OUTPUT scripts. One script can create more than one file.


cat('Writing predictions to output/my_preditions.csv ...')          # Nice to recall the output file name to the user.
write.csv(data.frame(x = 1:3), file = 'output/my_preditions.csv')
cat('Ok.\n')
