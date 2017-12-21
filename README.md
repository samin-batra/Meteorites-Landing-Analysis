# Meteorites-Landing-Analysis


This repository contains data about meteorite landings all over the world, spread over many years.
The dataset has been downloaded from Kaggle under the name and has been download from NASA's data portal. The link can be accessed here as:
https://www.kaggle.com/nasa/meteorite-landings

There's some invalid data, which has invalid latitudes/longitudes or years which are beyond 2016.
So, that part needs to be cleaned and can be done as, where meteorites.all is the variable containing the uncleaned data:
(This code is also mentioned on the above link)

meteorites.geo <- meteorites.all %>% 
filter(year>=860 & year<=2016) %>% # filter out weird years 
filter(reclong<=180 & reclong>=-180 & (reclat!=0 | reclong!=0))

The analysis includes a mapping of all landings to date on a world map.
It also includes mapping of landings in India.
There's a bar graph which displays the landings in every year since 1970.

Feedback is appreciated!
