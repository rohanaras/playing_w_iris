library(IRISSeismic)
library(maps)
iris <- new("IrisClient")

starttime <- as.POSIXct("2015-1-1", tx='GMT')
endtime <- starttime + 3600 * 24 * 365
yearEvents <- getEvent(iris, starttime, endtime)

map()
points(yearEvents$longitude, yearEvents$latitude, pch=16, col=heat.colors(7)[rev(floor(yearEvents$magnitude))], cex=(yearEvents$magnitude/5)^2)

filteredDF = yearEvents[!is.na(yearEvents$magnitude),]
magnitudes = filteredDF$magnitude
magnitudesTable = table(magnitudes)

plot(magnitudesTable, xlab="Magnitude of Earthquake", ylab="Count", main="Number of Earthquakes by Magnitude")
plot(cumsum(magnitudesTable)) #need to fix this plot to have a linear x-axis

granularDF = filteredDF[magnitudes != (floor(magnitudes/0.1)*0.1),]
nrow(granularDF)
map(main="Map of more granular data")
points(granularDF$longitude, granularDF$latitude, pch=16, col='red', cex=(granularDF$magnitude/5)^2)
summary(granularDF$longitude)
summary(filteredDF$longitude)

# why does the second plot look bimodal? is it because there is some more granualar data?
