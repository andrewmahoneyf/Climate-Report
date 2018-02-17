### This is the stump script to read the data and plot the maps
### You have to write the code suggested here.
### Feel free to follow the ideas in a different manner/in a different file.
### However, you have to submit your main code file.
###
### The file must be executable on the server!
### I.e. someone else must be able to just run it with 'Rscript maps.R'
### /on server/ and get the correct output.
install.packages("data.table")
install.packages("dplyr")
library("data.table")
library(dplyr)

## read the data
##
## hint1: figure out the correct format and use the correct function.
##
## hint2: read.table and friends are slow (about 6 min to read data).
## You may use data.table::fread instead (a few seconds)

require(data.table)
system.time(DT <- fread(sprintf("bzcat %s | tr -d '\\000'", "./data/temp_prec_subset.csv.bz2")))
##   user  system  elapsed 
##  0.045   0.010   0.049 
system.time(DT <- fread(sprintf("bzcat %s | tr -d '\\000'", "./data/temp_prec_small.csv.bz2")))
##   user  system  elapsed 
##  92.005  3.469  77.314  

## filter out North American observations
## Latitude between 24 and 65 degrees N 
## Longitude Western hemisphere > 180 degrees E
NorthAmerica <- DT %>% filter(longitude > 180, latitude > 24, latitude < 65)

## delete the original (large data) from R workspace
## this is necessary to conserve memory.
rm(DT)

## -------------------- do the following for 1960, 1987, 2014 and temp/precipitation --------------------

## select jpg graphics device
jpeg(filename = "Rplot%03d.jpeg",
     width = 480, height = 480, units = "px", pointsize = 12,
     quality = 75,
     bg = "white", res = NA, ...,
     type = c("cairo", "Xlib", "quartz"), antialias)
     
## select the correct year - plot longitude-latitude and color according to the temp/prec variable
## I recommend to use ggplot() but you can use something else too.
## 
## Note: if using ggplot, you may want to add "+ coord_map()" at the end of the plot.  This
## makes the map scale to look better.  You can also pick a particular map projection, look
## the documentation.  (You need 'mapproj' library).
## Warning: map projections may be slow (several minutes per plot).

## close the device

## -------------------- you are done.  congrats :-) --------------------

