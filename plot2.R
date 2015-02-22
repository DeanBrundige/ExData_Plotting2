# Exploratory Data Analysis, Course Project 2

source('~/ExData_Plotting2/loadData.R')

s <- subset(dat, fips == "24510", select = c("year","Emissions"))
t <- tapply(s$Emissions, s$year, sum)

x <- as.vector(dimnames(t)[[1]])
y <- as.vector(t)

# Plot the line graph as 480x480 .png file
png("plot2.png", width = 480, height = 480)

# Bump up margins to accomidate perpendicular axis labels 
par(mar = c(op$mar[1]+1, op$mar[2]+3, op$mar[3], op$mar[4]), 
    mgp = c(op$mgp[1]+2, op$mgp[2], op$mgp[3])
)

plot(x, y, type = "b", pch = 21, xaxt = "n", yaxt = "n", lty = 3, 
     main = "Baltimore City, Maryland\nPM2.5 from all emission sources", 
     xlab = "Year", 
     ylab = "Total PM2.5 emissions"
)

axis(1, at = x, labels = x, las = 2)
axis(2, at = y, labels = round(y, digits = 2), las = 2)

dev.off()
