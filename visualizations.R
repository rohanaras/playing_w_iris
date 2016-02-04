library(IRISSeismic)
library(maps)
iris <- new("IrisClient")

starttime <- as.POSIXct("2015-1-1", tx='GMT')
endtime <- starttime + 3600 * 24 * 365
yearEvents <- getEvent(iris, starttime, endtime)

yearEvents = yearEvents[order(yearEvents$magnitude),]
map()
points(yearEvents$longitude, yearEvents$latitude, pch=16, col=heat.colors(7)[floor(yearEvents$magnitude)], cex=1.5^(yearEvents$magnitude)/10)

filteredDF = yearEvents[!is.na(yearEvents$magnitude),]
magnitudes = filteredDF$magnitude
magnitudesTable = table(magnitudes)

hist(magnitudes, main = "Magnitude of Earthquakes from 2008-2015", ylab = 'Frequency', xlab = 'Magnitude')

plot(filteredDF$time, filteredDF$depth)

plot(magnitudesTable, xlab="Magnitude of Earthquake", ylab="Count", main="Number of Earthquakes by Magnitude")
plot(cumsum(magnitudesTable)) #need to fix this plot to have a linear x-axis

# granularDF = filteredDF[magnitudes != (floor(magnitudes/0.1)*0.1),]
# nrow(granularDF)
# map(main="Map of more granular data")
# points(granularDF$longitude, granularDF$latitude, pch=16, col='red', cex=(granularDF$magnitude/5)^2)
# summary(granularDF$longitude)
# summary(filteredDF$longitude)

# why does the second plot look bimodal? is it because there is some more granualar data?
