# Exploratory Data Analysis, Course Project 2

source('~/ExData_Plotting2/loadData.R')

t <- tapply(dat$Emissions, dat$year, sum)

x <- as.vector(dimnames(t)[[1]])
y <- as.vector(t)

# Some place I found info for twiking plots
# http://www.statmethods.net/advgraphs/axes.html
# http://stackoverflow.com/questions/5963047/do-not-want-scientific-notation-on-plot-axis
# http://stackoverflow.com/questions/6778425/avoid-overlapping-axis-labels-in-r

# Plot the line graph as 480x480 .png file
png("plot1.png", width = 480, height = 480)

# Bump up margins to accomidate perpendicular axis labels 
par(mar = c(op$mar[1]+1, op$mar[2]+3, op$mar[3], op$mar[4]), 
    mgp = c(op$mgp[1]+2, op$mgp[2], op$mgp[3])
)

plot(x, y, type = "b", pch = 21, xaxt = "n", yaxt = "n", lty = 3, 
     main = "PM2.5 from all emission sources", 
     xlab = "Year", 
     ylab = "Total PM2.5 emissions\n(millions)"
)

axis(1, at = x, labels = x, las = 2)
axis(2, at = y, labels = round(y/1000000, digits = 2), las = 2)

dev.off()
