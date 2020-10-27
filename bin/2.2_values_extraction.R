rm(list=ls()) #elimina TODOS los objetos del ambiente de trabajo
#Librerias
library(sp)
library(raster)
library(rgeos)
library(maptools)
library(rgdal)
library(usdm)
library(foreign)
library(rJava)
library(spocc)
library(corrplot)
#install.packages("corrplot")
#install.packages("usdm")

#Directorio de trabajo
setwd("/media/nel_pc/n311_pc/MAPA_QUERCUS_MAC/worldclim/bioclim_cortes/")###directorio de las capas climaticas del presente

#Cargar capas
pca_path <- list.files(".",pattern = "*.asc$",full.names = T)###crea el stack de las 19 variables climaticas del presente
capas_presente<- stack(pca_path)

#Cargar la base de datos
setwd("../../datos/")###directorio de los puntos de presencia
datos <- read.csv("Datos-wordlclime_corregid.csv")###nombre del archivo de puntos de la especie
datos

###########Crear archivo CSV para los puntos a usar en los modelos####
species<-datos$specie
lat<-datos$x
lon<-datos$y
Specie_estudied<-data.frame(species,lon,lat)


presencias_clima <- data.frame(extract(capas_presente,Specie_estudied[,2:3]))###extrae los valores climaticos para cada uno de los puntos de presencia
presencias_clima2<-data.frame(Specie_estudied,presencias_clima)
presencias_clima3 <- na.omit(presencias_clima2)## omite mis datos de presencia sin valores climaticos.
presencias_clima3

#Exportar los resultados en un archivo .csv
write.csv(presencias_clima3, file = "datos_worldClim.csv") ### para guardar el archivo de puntos

