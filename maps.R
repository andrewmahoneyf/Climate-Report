### This is the stump script to read the data and plot the maps
### You have to write the code suggested here.
### Feel free to follow the ideas in a different manner/in a different file.
### However, you have to submit your main code file.
###
### The file must be executable on the server!
### I.e. someone else must be able to just run it with 'Rscript maps.R'
### /on server/ and get the correct output.
library("data.table")
library(dplyr)
library(ggplot2)
library(mapproj)

## read the data
##
## hint1: figure out the correct format and use the correct function.
##
## hint2: read.table and friends are slow (about 6 min to read data).
## You may use data.table::fread instead (a few seconds)

require(data.table)
## system.time(DT <- fread(sprintf("bzcat %s | tr -d '\\000'", "./data/temp_prec_subset.csv.bz2")))
##   user  system  elapsed 
##  0.045   0.010   0.049 
system.time(DT <- fread(sprintf("bzcat %s | tr -d '\\000'", "/opt/data/temp_prec_small.csv.bz2")))
##   user  system  elapsed 
##  92.005  3.469  77.314  

## filter out North American observations
## Latitude between 24 and 65 degrees N 
## Longitude Western hemisphere > 180 degrees E
NorthAmerica <- DT %>% filter(longitude > 180, latitude > 15, latitude < 85)

## delete the original (large data) from R workspace
## this is necessary to conserve memory.
rm(DT)

## -------------------- do the following for 1960, 1987, 2014 and temp/precipitation --------------------

## select jpg graphics device
jpeg(filename = "Rplot%03d.jpeg", width = 480, height = 480, 
    units = "px", pointsize = 12, quality = 75, bg = "white")
     
## select the correct year - plot longitude-latitude and color according to the temp/prec variable
## I recommend to use ggplot() but you can use something else too.
dataJuly1960 <- NorthAmerica %>% filter(substr(time, 0, 7) == "1960-07")
dataJuly1987 <- NorthAmerica %>% filter(substr(time, 0, 7) == "1987-07")
dataJuly2014 <- NorthAmerica %>% filter(substr(time, 0, 7) == "2014-07")

## Note: if using ggplot, you may want to add "+ coord_map()" at the end of the plot.  This
## makes the map scale to look better.  You can also pick a particular map projection, look
## the documentation.  (You need 'mapproj' library).
## Warning: map projections may be slow (several minutes per plot).
map = map_data("world2", c("usa", "Canada", "Mexico", "Greenland", "Cuba", "Guatemala", "Belize", "El Salvador", "Honduras"))

## 1960
temp1960 = ggplot(dataJuly1960, aes(x=longitude,y=latitude,fill=airtemp)) + geom_tile() + ggtitle("July 1960 Air Temperature") ## + geom_point(aes(col=airtemp)) 
temp1960  + geom_polygon(data=map,aes(x=long, y=lat, group=group), colour="black", fill="white", alpha=0)       
precip1960 = ggplot(dataJuly1960, aes(x=longitude,y=latitude,fill=precipitation)) + geom_tile() + ggtitle("July 1960 Precipitation") ## + geom_point(aes(col=airtemp)) 
precip1960  + geom_polygon(data=map,aes(x=long, y=lat, group=group), colour="black", fill="white", alpha=0)       
## 1987
temp1987 = ggplot(dataJuly1987, aes(x=longitude,y=latitude,fill=airtemp)) + geom_tile() + ggtitle("July 1987 Air Temperature") ## + geom_point(aes(col=airtemp)) 
temp1987  + geom_polygon(data=map,aes(x=long, y=lat, group=group), colour="black", fill="white", alpha=0)       
precip1987 = ggplot(dataJuly1987, aes(x=longitude,y=latitude,fill=precipitation)) + geom_tile() + ggtitle("July 1987 Precipitation") ## + geom_point(aes(col=airtemp)) 
precip1987  + geom_polygon(data=map,aes(x=long, y=lat, group=group), colour="black", fill="white", alpha=0)       
## 2014
temp2014 = ggplot(dataJuly2014, aes(x=longitude,y=latitude,fill=airtemp)) + geom_tile() + ggtitle("July 2014 Air Temperature") ## + geom_point(aes(col=airtemp)) 
temp2014  + geom_polygon(data=map,aes(x=long, y=lat, group=group), colour="black", fill="white", alpha=0)       
precip2014 = ggplot(dataJuly2014, aes(x=longitude,y=latitude,fill=precipitation)) + geom_tile() + ggtitle("July 2014 Precipitation") ## + geom_point(aes(col=airtemp)) 
precip2014  + geom_polygon(data=map,aes(x=long, y=lat, group=group), colour="black", fill="white", alpha=0)       

## close the device
dev.off()

## -------------------- you are done.  congrats :-) --------------------

