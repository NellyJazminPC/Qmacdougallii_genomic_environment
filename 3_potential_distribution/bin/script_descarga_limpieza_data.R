setwd("C:/Users/n311/Desktop/MAPA_QUERCUS_MAC/datos/")##carpeta donde guardar el archivo .csv
install.packages("raster")
install.packages("dismo")
install.packages("rJava")
install.packages("spocc")
install.packages("rgbif")
install.packages("rgeos")

library(raster)
library(rgdal)
library(dismo)
library(rJava)
library(sp)
library(maptools)
library(spocc)
library(rgbif)
library(rgeos)


rm(list=ls()) #elimina TODOS los objetos del ambiente de trabajo
############ Cargar archivo .csv con datos presencia de la especie #####################
sp1<- read.csv("./quercus_utm_r.csv")


data <- subset(sp1, !is.na(long) & !is.na(lat))
dups <- duplicated(data[, c("specie", "long", "lat")])# primer paso para quitar duplicados
dups2<- duplicated(data[, c("long", "lat")])# segundo paso para quitar duplicados
sum(dups2)# number of duplicates

resol <- 0.00833 ### QUITAR LOS DATOS REPETIDOS ESPACIALMENTE en un radio de 1km2
# Este número lo saque de ArcMap de las propiedades de las capas de bioclim que usare para modelar
clean_dup <- function(data,longitude,latitude,threshold=0.0){  data <- data[!is.na(data[,longitude]),]
dat_sp <- SpatialPointsDataFrame(data[,c(longitude ,latitude)],data)
dat_sp1 <- remove.duplicates(dat_sp, zero = threshold)
return(dat_sp1@data)}
data5 <- clean_dup(data,longitude = "long",latitude = "lat",threshold = resol)### datos espacilamente limpios

write.csv(data5, file = "./quercus_macdougallii_1km.csv") ### para guardar el archivo de puntos


