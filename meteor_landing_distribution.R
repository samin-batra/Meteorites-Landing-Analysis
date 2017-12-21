#Packages needed
library('leaflet')
library('plyr')
library('dplyr')
library('ggplot2')

meteorites_data<-read.csv('meteorite-landings.csv')
meteorites_data<-meteorites_data %>% filter(year>=860 & year<=2016) %>%filter(reclong<=180 & reclong>=-180 & (reclat!=0|reclong!=0))

#Script for mapping meteorites data on a map
#meteorites_data$mass<-meteorites_data$mass/1000
meteorites_data<-meteorites_data[complete.cases(meteorites_data),]
meteorites_fell<-meteorites_data[meteorites_data$fall=="Fell",]
meteorites_found<-meteorites_data[meteorites_data$fall=="Found",]
m<-leaflet()%>%
  addProviderTiles(providers$CartoDB.DarkMatter)%>%
  addCircles(lng = meteorites_fell$reclong,lat = meteorites_fell$reclat,radius = ~(meteorites_fell$mass), color = "blue",fill = FALSE,data = meteorites_fell)%>%
  addCircles(lng = meteorites_found$reclong,lat = meteorites_found$reclat,radius = ~(meteorites_found$mass), color = "red",fill = FALSE,data = meteorites_found) %>%
  addLegend(position = 'bottomright',colors = c('blue','red'),values = ~fall,title="Meteorite landings")
  
#Mean mass of meteorites
mass_fell <- mean(meteorites_fell$mass)
mass_fallen <- mean(meteorites_found$mass)

#Meteorite distribution since 1970
meteorite_year<-meteorites_data %>% filter(year>=1970)
meteorite_year <- meteorite_year %>% group_by(year) %>% summarise(Count = n())
g<-ggplot(meteorite_year,aes(x = year, y=count))


#Meteorite landings in India
northmost_latitude = 36.0
southmost_latitude = 9.0
westmost_longitude = 70.0
eastmost_longitude = 94.0

meteorites_india <- meteorites_data %>% filter(reclat>=southmost_latitude & reclat<= northmost_latitude) %>% filter(reclong >= westmost_longitude & reclong <= eastmost_longitude)
meteorites_india
factPal <- colorFactor(c("red","blue"),meteorites_india$fall)


m<-leaflet(meteorites_india)  %>% setView(lng = 78.8718,lat = 21.7679,zoom = 2) %>% fitBounds(lng1 = westmost_longitude,lat1 = southmost_latitude,lng2 = eastmost_longitude,lat2 = northmost_latitude) %>% 
  addProviderTiles(providers$CartoDB.DarkMatter)%>%
  addCircles(lng = ~reclong,lat = ~reclat,radius = ~(mass*10), color = ~factPal(fall),fill = FALSE) %>%
  addLegend(position = "bottomright",pal = factPal,values = ~fall,title = "Meteorite Landings in India fall",opacity = 1)
  

#mass distribution of meteorite
meteorites_data %>% ggplot(aes(x = mass)) + geom_histogram(fill = "red") + scale_x_log10() + scale_y_log10() + labs(x = "Mass in grams", y = "Count",title = "Distributions of mass") + theme_bw()






