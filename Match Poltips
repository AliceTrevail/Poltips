### **************************************** ##########

### Import data #####

# import tide data
# using function defined in Import Poltips file

Tide_Pu2010 <- import.POLTIPS("E:/Data/Tide/PuffinTideTimes2010.txt")

# import tracking data
Kit <- read.csv("E:/Data/GPS Kittiwake ALLcolonies/Ki.csv", as.is = T)


### **************************************** ##########

### Match tracking data with nearest high water ######

# subset tide data to HW only
HW_Pu2010 <- Tide_Pu2010[Tide_Pu2010$Tide == "HW",]

# create posixct DateTime columns
HW_Pu2010$posixct <- as.POSIXct(paste(HW_Pu2010$Date, HW_Pu2010$Time), format="%d/%m/%Y %H:%M", origin="1970-01-01", tz = "GMT")
Kit$posixct <- as.POSIXct(paste(Kit$Date, Kit$Time), format="%d/%m/%Y %H:%M", origin="1970-01-01", tz = "GMT")

# new column of time of nearest high water
Kit$NearestHW <- as.POSIXct(mapply(function(x) nearest.time(x, HW_Pu2010), Kit$posixct), origin="1970-01-01", tz = "GMT")

# column of time around nearest high water
Kit$TimeAroundHW <- difftime(Kit$posixct, Kit$NearestHW, units = "hours")
Kit$TimeAroundHW <- as.numeric(Kit$TimeAroundHW)
