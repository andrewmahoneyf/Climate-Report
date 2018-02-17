#!/bin/bash
# --------------------------------------------------------------------------------
# document here the main bash commands you are using for the server access.  The file contains
# two parts: the first one for the commands you run on your laptop, and the second one for the
# commands on the remote server.
# 
# The question lists give your some guidance what to do and report but you are free to do it
# in a different way.  If you use a graphical frontend instead of scp for copying files,
# just say which one in the appropriate place.
#
# Note: this file does not to be runnable
#
# -------------------- local commands --------------------
# 1. create a directory for this project.
mkdir data
# 2. log onto the server
ssh drew102@info201.ischool.uw.edu
# 3. copy the small data subset from the server to your local machine
exit
scp drew102@info201.ischool.uw.edu:/opt/data/temp_prec_subset.csv.bz2 ./data/
# 4. copy your R-script to the server
sudo chmod +x maps.R
scp ./maps.R drew102@info201.ischool.uw.edu:~/drew102-a6
# 5. (after succesfully running the script remotely): copy the output files back to your computer
scp otoomet@info201.ischool.uw.edu:~/drew102-a6/*.jpeg .
# 6. inspect that the copy was successful
ls
open 

# -------------------- remote commands --------------------
# 1. explore the data directory '/opt/data'.  How do you find out the size of the files?
ssh drew102@info201.ischool.uw.edu
cd /opt/data
ls -l 
# 2. explore the first few lines of the small sample data
bzcat temp_prec_small.csv.bz2 | head -10
# 3. create a directory for this project
cd ~ && mkdir drew102-a6
# 4. (after copying your code from the laptop): inspect the files in the project directory
cd drew102-a6 && ls -al
# 5. run your script
Rscript maps.R
# 6. How do you install missing R packages?
R
install.packages("foo")
# or
Rscript -e "install.packages('foo')"
# 7. (after running the script): inspect the folder for output files
ls