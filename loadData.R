# Load any necessary packages
if(!require(data.table)){install.packages("data.table")}
if(!require(plyr)){install.packages("plyr")}
if(!require(ggplot2)){install.packages("ggplot2")}

# Set working directory
setwd("~/ExData_Plotting2")

# Get source data
if(!file.exists("exdata-data-NEI_data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "exdata-data-NEI_data.zip", method="curl", quiet = TRUE)
}

if(!file.exists("Source_Classification_Code.rds")){
  unzip("exdata-data-NEI_data.zip", "Source_Classification_Code.rds")
}

if(!file.exists("summarySCC_PM25.rds")){
  unzip("exdata-data-NEI_data.zip", "summarySCC_PM25.rds")
}

# Load source data
if(!exists('dat')){
  SCC <- data.table(readRDS("Source_Classification_Code.rds"), key = "SCC")
  NEI <- data.table(readRDS("summarySCC_PM25.rds"), key = "SCC")

  # Join data.tables in "a very time and memory efficient" way
  # http://stackoverflow.com/questions/1299871/how-to-join-data-frames-in-r-inner-outer-left-right
  # Credit to Etienne Low-Décarie post
  dat <- SCC[NEI]

  # Remove obsolete objects from the environment
  rm(SCC,NEI)
}

# Save the current Graphical Parameters so that they can be reset
#if(!exists('op')){
#  op <- par()
#}


