library(ggplot2)

flights <- read.csv("http://www.public.iastate.edu/~hofmann/looking-at-data/data/jan19.csv")

source("airport-extra.R")

plotMap(getFlights(flights, 600, 2), 600) # first still picture for all flights that are in the air between 6:00 am and 6:02 am. 

mins <- seq(0,58, by=2)
hour <- seq(600, 1200, by=100)
seqs <- rep(hour, each=length(mins))
seqs <- seqs + mins

# working directory
getwd()

system("mkdir movie-stills")
setwd("movie-stills")
for (i in head(seqs, 60)) {
  fname <- paste("jan19-2006-",i,".png",sep="")
  png(fname, width=640, height=480)
	plotMap(getFlights(flights, i, 2),i)
#	ggsave(file=fname, width=6, height=4)
	dev.off()
}



