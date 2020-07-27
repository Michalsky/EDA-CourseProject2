#downoad data into current working directory and unzip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "data.zip")
unzip("data.zip")



library(plyr)

#NEI <- readRDS("Source_Classification_Code.rds")

#Read and process data for plot

SCC <- readRDS("SummarySCC_PM25.rds")
SCC_SUM <- ddply(SCC, "year", summarise, total.emissions = sum(Emissions))

#build plot
png(filename = "plot1.png",width = 480,height = 480, units= "px")
with(SCC_SUM, plot(total.emissions ~ year, xlab = "Year", ylab = "Total Emissions", main = "Total Emissions by Year", type ="l", lwd = "3"))
dev.off()


