# Exploratory Data Analysis, Course Project 2

source('~/ExData_Plotting2/loadData.R')
library(sqldf)

# Use only data for coal combustion related sources and known counties
s <- subset(dat, grepl("Coal", EI.Sector) & ! is.na(as.numeric(fips)))

# Get the number of observations per county & year
f <- as.data.frame(unique(s$fips)) ; colnames(f) <- (c('fips'))
y <- sqldf('select fips, year, count(*) nr from s group by fips, year')

f <- cbind(f,sqldf('select y.nr "1999" from f left outer join y on y.year=1999 and y.fips=f.fips'))
f <- cbind(f,sqldf('select y.nr "2002" from f left outer join y on y.year=2002 and y.fips=f.fips'))
f <- cbind(f,sqldf('select y.nr "2005" from f left outer join y on y.year=2005 and y.fips=f.fips'))
f <- cbind(f,sqldf('select y.nr "2008" from f left outer join y on y.year=2008 and y.fips=f.fips'))

# Only use fips (ie: counties) that have measurements for each year
f <- subset(na.omit(f), select = c('fips'))
s <- subset(s, fips %in% f$fips)

t <- tapply(s$Emissions, s$year, mean)
x <- as.vector(dimnames(t)[[1]])
y <- as.vector(t)

png("plot4.png", width = 480, height = 480)

par(mar = c(op$mar[1]+1, op$mar[2]+3, op$mar[3], op$mar[4]), 
    mgp = c(op$mgp[1]+2, op$mgp[2], op$mgp[3])
)

plot(x, y, type = "b", pch = NA, xaxt = "n", yaxt = "n", lty = 3, 
     main = "US PM2.5\nfrom coal combustion-related sources", 
     xlab = "Year", 
     ylab = "Mean PM2.5 emissions"
)
axis(1, at = x, labels = x, las = 2)
text(x, y, labels = round(y, digits = 2), cex= 0.7)

dev.off()
