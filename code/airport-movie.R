library(ggplot2)

flights <- read.csv("http://www.public.iastate.edu/~hofmann/looking-at-data/data/jan19.csv")

source("airport-extra.R")

plotMap(getFlights(flights, 600, 2), 600) 

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


##################
library(ggplot2)
library(maps)
states <- map_data("state")
xlim <- range(states$long)
ylim <- range(states$lat)

library(cranvas)

flights <- read.csv("http://www.public.iastate.edu/~hofmann/looking-at-data/data/jan19.csv")
source("airport-extra.R")

loc <- updateData(getFlights(flights, 600, 2), time=600)

#loc <- rbind(loc, 
qflights <- qdata(loc, size=1)
qscatter(longitude, latitude, data=qflights, xlim=xlim, ylim=ylim)

mins <- seq(0,58, by=2)
hour <- seq(800, 1200, by=100)
seqs <- rep(hour, each=length(mins))
seqs <- seqs + mins


for (i in head(seqs,100)) {
	loc <- updateData(getFlights(flights, i, 2),i)
	fname <- paste("jan19-",i,".png",sep="")
	ggsave(file=fname, width=6, height=4)
#  for (j in 1:3) qflights[,j] <- loc[,j]

  Sys.sleep(.001)
}

print(q +
        geom_point(aes(x=longitude, y=latitude, size=delay), 
                   colour = I(alpha("black", 7/10)), data=loc) + scale_size(name="Arrival\nDelays", breaks=c(15, 60, 120, 240), labels=c("15 min",  "1h", "2h", "4h"), limits=c(0,300))
)

} else {
  print(q)
}

vp1 <- viewport(x=0.05, y=0.25, height=unit(2.5, "cm"), width= unit(2.5, "cm"), just=c("left","bottom"))
vp2 <- viewport(x=0.8, y=0.25, height=unit(2.5, "cm"), width= unit(2.5, "cm"), just=c("right","bottom"))

print(plotFace(time-300), vp=vp1)
print(plotFace(time), vp=vp2)

}




#vp2 <- viewport(x=-128,y=28, width=0.3, just=c("bottom", "left"))
plotFace <- function(time) {
  ho <- time %/% 100
  ho <- ho %% 12
  mi <- time %% 100
  
  face <- data.frame(cbind(x=c(rep((ho+mi/60)/12,2), rep(mi/60, 2)), y = c(0,0.5, 0,0.9)))
  face$id <- c("hour", "hour", "min", "min")
  
  clock <- data.frame(cbind(x=seq(0,1,length=100), y=rep(1,100)))
  clock$id <- "clock"
  face <- rbind(face,clock)
  
  
  q <- 
    qplot(x,y, geom="line", colour=I("grey65"), group=id, data=face, xlim=c(0,1)) + scale_x_continuous(breaks=seq(0,1, length=5), labels=rep("",5))+ coord_polar() +
    labs(x=NULL, y=NULL) +
    theme(plot.margin=unit(rep(0,4), "lines"),
          panel.background=element_blank(),
          panel.grid.minor= element_blank(),
          axis.title.x= element_blank(),
          axis.title.y= element_blank(),
          axis.line= element_blank(),
          axis.ticks= element_blank(),
          axis.text.y  = element_text(colour="#FFFFFF", lineheight=-10, size=0),
          axis.text.x  = element_text(colour="#FFFFFF", lineheight=-10, size=0)	  )
  return(q)
}

