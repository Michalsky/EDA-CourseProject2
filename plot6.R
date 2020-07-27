#downoad data into current working directory and unzip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "data.zip")
unzip("data.zip")



library(plyr)
library(dplyr)

#NEI <- readRDS("Source_Classification_Code.rds")

#Read and process data for plot
SCC <- readRDS("SummarySCC_PM25.rds")
SCC_SUM_BAL <- ddply(filter(SCC, fips=="24510"), c("year", "type"), summarise, total.emissions = sum(Emissions))
SCC_SUM_BAL_MV <- filter(SCC_SUM_BAL, type=="ON-ROAD")
SCC_SUM_LAX <- ddply(filter(SCC, fips=="06037"), c("year", "type"), summarise, total.emissions = sum(Emissions))
SCC_SUM_LAX_MV <- filter(SCC_SUM_LAX, type=="ON-ROAD")



#Build Plot
png(filename = "plot6.png",width = 480,height = 480, units= "px")
par(mfrow = c(1,2))
with(SCC_SUM_BAL_MV, plot(year, total.emissions, type="b", lwd=3, xlab = "Year", ylab = "Total Emissions", main = "Total Emissions by Year in Baltimore City"))
abline(lm(SCC_SUM_BAL_MV$total.emissions~SCC_SUM_BAL_MV$year), col="green", lwd=2)
with(SCC_SUM_LAX_MV, plot(year, total.emissions, type="b", lwd=3, xlab = "Year", ylab = "Total Emissions", main = "Total Emissions by Year in Los Angeles City"))
abline(lm(SCC_SUM_LAX_MV$total.emissions~SCC_SUM_LAX_MV$year), col="red", lwd=2)
dev.off()


