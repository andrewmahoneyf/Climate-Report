# Problem Set 6: Work on a Remote Server

This problem set asks you to complete a task on a _remote server_.
You use your laptop to develop the code and log in to the server,
however, the calculations will be done on the server.

Your task is to plot **temperature and precipitation maps** for **North
America**, for **July** month **1960** (first year in the data), **1987** (in the
middle of the observation period), and **2014** (the last year).
These maps _must be plotted on the server_.

Finally, you **create a report** in markdown where you include the
maps and briefly explain the data and your findings.  You also have to
**submit the code**--an R script that you run on the server (must be
run on the server, either from command line or from within R
environment), 
and a **session.sh** file where
you include the shell commands you use on your laptop and on the
server (this file does not have to be runnable).  The stubs of the three files are
included in the repo.


# The Problem

## Detailed Task List

1. Make sure you are familiar with the
   [remote-login appendix](https://info201.github.io/remote-server.html)
   in the
   book.
   
   You should know how to log in remotely, copy the files between
   the server and your computer, and execute R scripts remotely.
 
1. The data is located in `/opt/data`.  There are three
   temperature-precipitation files.  All have a similar structure.
   You have to work with the middle-sized one
   (`temp_prec_small.csv.bz2`).  Please don't use the large one
   (1960+) as processing that takes ~50% of the server's memory.

   From the command line, inspect the first few lines of data.  This
   contains [NOAA data](https://www.esrl.noaa.gov/psd/data/gridded/data.UDel_AirT_Precip.html) for land surface temperature and precipitation.
   It is a compressed
   file, so you need tools like `bzcat` to print it, you can select
   the first lines with `head` or use pager `more`.  The data contains the following
   variables: _longitude_, _latitude_,
   _time_, airtemp, precipitation.  An example of the data looks like
   this:
```
longitude,latitude,time,airtemp,precipitation
314.75,-14.25,1963-03-01,24.8999996185303,0.830000042915344
315.25,-14.25,1963-03-01,26.1000003814697,0
315.75,-14.25,1963-03-01,27.3999996185303,0
```
   There is one observation for each 0.5 degree of latitude and
   longitude.  Longitude is degree east (Western hemisphere has
   longitude > 180), Latitude degree north.  Temperature is the monthly mean (deg C),
   precipitation is the monthly sum (cm).  The records for sea surface
   are
   there but the values are missing.  There are also some missing values on
   land. 

1. In order to facilitate testing, I have included a small test file
   `temp_prec_subset.csv.bz2` in the same folder.  You may copy that file
   to your computer and use it for developing/testing the code. 
   
   *Pro tip:* Be sure to be on your local machine and **NOT** the server when pulling files off the server. 
   Think about the path that would be required on the server to access the file. 

Attempt to do the following steps by running it as a script
as `Rscript maps.R` at bash prompt.  If this does not work well, you can also
start an interactive R session and `source()` the file from there.

*Pro tip:* For Windows machines especially, there is no `Rscript` command. Either set it with a PATH in your 
local enviroment or run the script in RStudio. 

Note: it includes 170M observations, so just `read.csv()` takes
about 10 minutes.  (You may check out faster `fread()` function in
_data.table_ package).

1. Select the observations for North America.  You don't have to use
   the exact geographical borders, just broad latitude/longitude
   boundaries will do.
   
1. Select only observations for July 1960, July 1987, July 2014.

1. Make the maps: plot the longitude versus latitude, and color the
   tiles according to temperature or precipitation.  Do this for all
   the required years.  Make sure you save the plots into a png (or jpg)
   file by using the corresponding graphic device like
   `jpeg("map.jpg")`.  Don't forget to close the device afterwards!
   
   Note: there are many ways to create such maps in R, you may use
   _ggplot_, base R graphics functions, and other libraries.
   
1. Copy the map files from server to your laptop.

1. Write a brief report where you explain what did you find.  (The
   file _climate\_report.md_ gives you the stub).

1. Fill also out both sections in the `session.sh` file, describing
   which commands did you run.
   
That's it!


## Extra Credit

Use much faster `data.table::fread` instead of `read.table` (and
friends).  However, read the file by automatic parallel decompression
without decompressing it manually.  I.e. tell `fread` that the file
should be decompressed in parallel.

Compare the time it takes to read the data in different ways (if you
are using more than a single way).


## Notes on the server:

* the server's name is _info201.ischool.uw.edu_

* use your UW netid and password to log on.

* the data is in `/opt/data/`.

* the server should have plenty of disk space (500G), but may be low
  on memory (32G) if many people are working there at the same time.

* if you need to do something with superuser privileges, you have to
  contact Ott.

* it is a virtual machine with dynamic memory, so memory reports may be
  unreliable. 
  
