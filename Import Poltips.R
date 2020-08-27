### Import Poltips text file data to R ###

###### install and load packages ########

if(!"dplyr" %in% installed.packages())
  install.packages("dplyr")
library(dplyr)

if(!"readr" %in% installed.packages())
  install.packages("readr")
library(readr)

###### functions ########

# function to open text file saved from poltips software of high and low waters
import.POLTIPS <- function(x){
  
  # read in text file
  a <- read_table2(x,                                                      # read in .txt file
                  col_names = FALSE,                                       # dont use first row as column names
                  col_types = cols(X1 = col_date(format = "%d/%m/%Y"),     # date column with format
                                   X2 = col_time(format = "%H:%M"),        # time column with format
                                   X3 = col_number()),                     # tidal height as numeric
                  skip = 1)                                                # skip row one of plain text
  
  # convert to relevant format
  b <- as.data.frame(a)                         # convert to data frame
  colnames(b) <- c("Date", "Time", "Height")    # give relevant column names
  
  # name tides by high or low water. Poltips generates data for sequential tides so can use binary nature of data
  b$Tide <- "NA"                                                  # create empty column of tide type
  b$Tide[1] <- ifelse(b$Height[1] < b$Height[2], "LW", "HW")      # for row one, if height is lower than row 2 = "LW", else "HW"
  for (i in 2:NROW(b)){                                           # loop for remaining rows
    b$Tide[i] <- ifelse(b$Height[i] < b$Height[i-1], "LW", "HW")  # if height lower than row above = "LW", else "HW"
  }
  
  # return new data frame
  b
}

# function to return nearest time between date x and high water dataframe
nearest.time <- function(x, y, key = "posixct"){y[which.min(abs(difftime(x, y[,key]))),key]}


### **************************************** ##########

### Import data #####

# import tide data
Tide_Pu2010 <- import.POLTIPS("E:/Data/Tide/PuffinTideTimes2010.txt")
