#First we need to clean work space
rm(list=ls()) 
#Then we call the libraries
library(sp)
library(raster)

#Directory of the climate layers of the present
wc_path <- list.files("../metadata/climate/wc/actual/",pattern = "*.asc$",full.names = T)###crea el stack de las 19 variables climaticas del presente
layers_present<- stack(wc_path)

#Load the database obtained after cleaning. The database obtained in script 2.1
data_clean <- read.csv("../results/databases/q_macd_1km_geo_coords.csv")

# Extract the values of the 19 climatic variables for each of the presence points
values_clim <- data.frame(extract(layers_present,data_clean[,3:4]))
values_clim2<-data.frame(data_clean,values_clim)
# Skip the presence data without clim values
values_clim3 <- na.omit(values_clim2)
values_clim3 
# Export the database obtained in this script to use it later
write.csv(values_clim3, file = "../results/databases/q_macd_wc_values.csv") ### para guardar el archivo de puntos



