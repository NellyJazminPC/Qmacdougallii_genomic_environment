#First we need to clean work space
rm(list=ls()) 
#Then we call the libraries
library(sp)

############ Upload the file .csv, the presence data of the specie in UTM format #####################
metadata_inds <- read.csv("../metadata/Qmacdougalli_79ind.csv")

#This is just to detect duplicates
dups <- duplicated(metadata_inds[, c("specie", "long", "lat")])
sum(dups)

  ### Del archivo de metadata extraemos solo el nombre de la especie y las coordenadas de los individuos
species<-metadata_inds$specie
lat<-metadata_inds$lat
lon<-metadata_inds$long
data<-data.frame(species,lon,lat)


# Remove spacially repeated data in a radius of 1km2
# This number, 0.00833, I take it from the properties of the Worldclim layers that I will use to model
resol <- 0.00833

# Function to create objects of class SpatialPointsDataFrame and remove duplicates
clean_dup <- function(data,longitude,latitude,threshold=0.0){  data <- data[!is.na(data[,longitude]),]
dat_sp <- SpatialPointsDataFrame(data[,c(longitude ,latitude)],data)
dat_sp1 <- remove.duplicates(dat_sp, zero = threshold)
return(dat_sp1@data)}

### We have spatially clean data with the function clean_dup in accordance with the resolution already established
data_clean <- clean_dup(data,longitude = "lon",latitude = "lat",threshold = resol)
data_clean

### We can save this data in a new database that we will use for downstream analysis
write.csv(data_clean, file = "../results/databases/q_macd_1km_geo_coords.csv")


