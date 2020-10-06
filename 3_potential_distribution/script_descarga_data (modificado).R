setwd("C:/Users/n311/Desktop/MAPA_QUERCUS_MAC/datos/")##carpeta donde guardar el archivo .csv

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
species1<- read.csv("./especies.csv/Abronia_oaxacae.csv")
sp1<- read.csv("./especies.csv/Anthurium_halmorei.csv")
sp2<- read.csv("./especies.csv/Aphelocoma_guerrerensis.csv")
sp3<- read.csv("./especies.csv/Aphelocoma_oaxacae.csv")

sp5<- read.csv("./especies.csv/Chlorospingus_oaxacae.csv")
sp6<- read.csv("./especies.csv/Chlorospingus_sms.csv")
sp7<- read.csv("./especies.csv/Cryptotis_peregrinus.csv")
sp8<- read.csv("./especies.csv/Cyanolyca_mirabilis.csv")
sp9<- read.csv("./especies.csv/Eupherusa_cyanophrys.csv")
sp10<- read.csv("./especies.csv/Eupherusa_poliocerca.csv")
sp11<- read.csv("./especies.csv/Megadontomys_thomasi.csv")

sp14<- read.csv("./especies.csv/Pinguicula_zecheri.csv")
sp15 <- read.csv("./especies.csv/faltan/Magnolia_iltisiana.csv")
sp16 <- read.csv("./especies.csv/faltan/Pseudoeurycea_mixcoatl.csv")
sp17 <- read.csv("./especies.csv/faltan/Thorius_grandis.csv")
sp18 <- read.csv("./especies.csv/faltan/Thorius_omiltemi.csv")

data <- subset(sp18, !is.na(lon) & !is.na(lat))
dups <- duplicated(data[, c("species", "lon", "lat")])# primer paso para quitar duplicados
dups2<- duplicated(data[, c("lon", "lat")])# segundo paso para quitar duplicados
sum(dups2)# number of duplicates

resol <- 0.00833 ### QUITAR LOS DATOS REPETIDOS ESPACIALMENTE en un radio de 1km2
# Este número lo saque de ArcMap de las propiedades de las capas de bioclim que usare para modelar
clean_dup <- function(data,longitude,latitude,threshold=0.0){  data <- data[!is.na(data[,longitude]),]
dat_sp <- SpatialPointsDataFrame(data[,c(longitude ,latitude)],data)
dat_sp1 <- remove.duplicates(dat_sp, zero = threshold)
return(dat_sp1@data)}
data5 <- clean_dup(data,longitude = "lon",latitude = "lat",threshold = resol)### datos espacilamente limpios

write.csv(data5, file = "./especies.csv/Thorius_omi_1km.csv") ### para guardar el archivo de puntos


