setwd("~/Google Drive/Dissertation/CHARLS/china-province-border-data")
library(maptools)
library(ggplot2)
library(plyr)
China=readShapePoly('bou2_4p.shp')
China@data
plot(China,col=gray(924:0/924))
length(China)
names(China)
table(iconv(China$NAME, from = "GBK"))
China$NAME <- iconv(China$NAME, from = "GBK")
head(China)
class(fortify(China))
x <- data.frame(China,id=seq(0:924)-1) 
y <- fortify(China)
map <- join(x, y, type = "full")
unique(China@data$NAME)
population <- read.csv("population.csv") 
pop_map <- join(map, population, type="full")
pop_map$ruralper = pop_map$Rural/pop_map$Population
pop_map$age65per = pop_map$age65/pop_map$Sample
ggplot(pop_map,aes(x=long,y=lat,group=group, fill=ruralper)) +
  geom_polygon(colour="grey40") +
  scale_fill_gradient(low="white",high="steelblue") + 
  coord_map("polyconic") +
  labs(fill = "rural population \n(% of total population)") + 
  theme(             
    panel.grid = element_blank(),
    panel.background = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    legend.position = "left",
    legend.title = element_text(size = 5)
  )

ggplot(pop_map,aes(x=long,y=lat,group=group, fill=age65per)) +
  geom_polygon(colour="grey40") +
  scale_fill_gradient(low="white",high="steelblue") + 
  coord_map("polyconic") +
  labs(fill = "population ages 65 and above \n(% of total population)") + 
  theme(             
    panel.grid = element_blank(),
    panel.background = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    legend.position = "left",
    legend.title = element_text(size = 5)
  )