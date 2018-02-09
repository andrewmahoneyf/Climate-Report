### This is the stump script to read the data and plot the maps
### You have to write the code suggested here.
### Feel free to follow the ideas in a different manner/in a different file.
### However, you have to submit your main code file.
###
### The file must be executable on the server!
### I.e. someone else must be able to just run it with 'Rscript maps.R'
### /on server/ and get the correct output.


## read the data
##
## hint1: figure out the correct format and use the correct function.
##
## hint2: read.table and friends are slow (about 6 min to read data).
## You may use data.table::fread instead (a few seconds)


## filter out North American observations


## delete the original (large data) from R workspace
## this is necessary to conserve memory.


## -------------------- do the following for 1960, 1987, 2014 and temp/precipitation --------------------

## select jpg graphics device

## select the correct year - plot longitude-latitude and color according to the temp/prec variable
## I recommend to use ggplot() but you can use something else too.
## 
## Note: if using ggplot, you may want to add "+ coord_map()" at the end of the plot.  This
## makes the map scale to look better.  You can also pick a particular map projection, look
## the documentation.  (You need 'mapproj' library).
## Warning: map projections may be slow (several minutes per plot).

## close the device

## -------------------- you are done.  congrats :-) --------------------

