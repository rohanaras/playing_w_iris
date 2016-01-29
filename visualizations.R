library(IRISSeismic)
iris <- new("IrisClient")

starttime <- as.POSIXct("2015-1-1", tx='GMT')
endtime <- starttime + 3600 * 24 * 365
yearEvents <- getEvent(iris, starttime, endtime)

map()
points(yearEvents$longitude, yearEvents$latitude, pch=16, col=heat.colors(7)[rev(floor(yearEvents$magnitude))], cex=(yearEvents$magnitude/5)^2)

magnitudes = table(yearEvents$magnitude[!is.na(yearEvents$magnitude)])

plot(magnitudes, xlab="Magnitude of Earthquake", ylab="Count", main="Number of Earthquakes by Magnitude")
plot(cumsum(magnitudes)) #need to fix this plot to have a linear x-axis
