#downoad data into current working directory and unzip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "data.zip")
unzip("data.zip")



library(plyr)
library(dplyr)


#Read and process data for plot

NEI <- readRDS("Source_Classification_Code.rds")
NEI_COAL <- select(NEI, SSC, EI.SECTOR)
NEI_COAL <- NEI_COAL[grep("Coal", NEI_COAL$EI.Sector),]
SCC <- readRDS("SummarySCC_PM25.rds")
SCC_NEI_COAL <- merge(NEI_COAL,SCC, by="SCC")
SCC_COAL_SUM <- ddply(SCC_NEI_COAL, c("year","type"), summarise, total.emissions = sum(Emissions))


#Build plot
png(filename = "plot4.png",width = 480,height = 480, units= "px")
p <- ggplot(SCC_COAL_SUM, aes(year, total.emissions))
p <- p + labs(x = "Year", y = "Total Coal Emissions", title = "United States Coal Emissions by Year")
p + geom_line(size = 2, aes(colour = factor(type))) 
dev.off()


