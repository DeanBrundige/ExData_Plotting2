# Exploratory Data Analysis, Course Project 2

source('~/ExData_Plotting2/loadData.R')

s <- subset(dat, fips == "24510", select = c("year", "Emissions", "type"))
d <- with(s, aggregate(Emissions, by = list(year, type), FUN = "sum"))
colnames(d) <- c("year","type","emissions")

# Some places I found info for twiking these ggplot2 plots
# http://www.cookbook-r.com/Graphs/Axes_(ggplot2)/
# http://docs.ggplot2.org/current/theme.html

# This is an "ok" plot but has some minor x-axis issues 
#q <- qplot(year, emissions, data = d, geom = 'line', facets = .~ type)
#q <- q + scale_x_continuous(breaks=sort(unique(s$year)))

# This is good
p <- ggplot(d, aes(x = year, y = emissions, color = type)) 
p <- p + geom_line()
p <- p + scale_x_continuous(breaks=sort(unique(s$year)))
p <- p + ggtitle("Baltimore City, Maryland\nPM2.5 emissions by source type")
p <- p + ylab("Total PM2.5 Emissions")
p <- p + scale_colour_brewer(name = "Source type", palette="Set1")

png("plot3.png", width = 480, height = 480)
print(p)
dev.off()
