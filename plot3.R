#downoad data into current working directory and unzip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "data.zip")
unzip("data.zip")



library(plyr)
library(dplyr)

#NEI <- readRDS("Source_Classification_Code.rds")

#Read and process data for plot

SCC <- readRDS("SummarySCC_PM25.rds")
SCC_SUM <- ddply(filter(SCC, fips=="24510"), c("year","type"), summarise, total.emissions = sum(Emissions))


#Build Plot
png(filename = "plot3.png",width = 480,height = 480, units= "px")
p <- ggplot(SCC_SUM, aes(year, total.emissions))
p <- p + labs(x = "Year", y = "Total Emissions", title = "Baltimore City Type Emissions by Year")
p + geom_line(size = 2, aes(colour = factor(type))) 
dev.off()


