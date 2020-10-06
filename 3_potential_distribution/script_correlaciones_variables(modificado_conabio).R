#############################################################################################
###########Establecer correlaciones variables (Marco F. Ortiz y David Prieto-Torres##########
#############################################################################################
#install.packages(c("foreign", "corrplot", "usdm"))

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
install.packages("corrplot")
install.packages("usdm")
rm(list=ls()) #elimina TODOS los objetos del ambiente de trabajo
setwd("/media/nel_pc/n311_pc/MAPA_QUERCUS_MAC/worldclim/bioclim_cortes/")###directorio de las capas climaticas del presente
pca_path <- list.files(".",pattern = "*.asc$",full.names = T)###crea el stack de las 19 variables climaticas del presente
capas_presente<- stack(pca_path)

#Cargar la base de datos, por ejemplo (primero para archivos de texto, segundo para archivos csv):
setwd("../../datos/")###directorio de los puntos de presencia
datos <- read.csv("quercus_geog_todos_puntos.csv")###nombre del archivo de puntos de la especie


###########Crear archivo CSV para los puntos a usar en los modelos####
species<-datos$specie
lat<-datos$lat
lon<-datos$long
Specie_estudied<-data.frame(species,lon,lat)


presencias_clima <- data.frame(extract(capas_presente,Specie_estudied[,2:3]))###extrae los valores climaticos para cada uno de los puntos de presencia
presencias_clima2<-data.frame(Specie_estudied,presencias_clima)
presencias_clima3 <- na.omit(presencias_clima2)## omite mis datos de presencia sin valores climaticos.

#setwd("./limpios")##carpeta donde guardar el archivo .csv
write.csv(presencias_clima3[,1:3], file = "q_macd_todos_puntos_limpio.csv") ### para guardar el archivo de puntos

### Matriz de colinearidad y estimacion del Factor de inflacion de Varianza (VIF)
cormatriz <- cor(presencias_clima3[,4:22])#Definir cu?les son las columnas con las variables para hacer la correlaci?n (de la 1 a la 19)

png("correlacion_puntos_plot/Q_macdougallii_todos_puntos.png")
#windows()
corrplot(cormatriz, outline = T, tl.col = "black")
dev.off()

corrplot(cormatriz, order = "hclust", method = "pie",  type = "upper" , outline = F, tl.col = "black")








### Para saber cuales quitar mediante el Factor de inflación de Varianza (VIF). si VIF>4.0 implica multicolinearidad, hay que remover esas variables. Sin embargo, algunos autores recomiendan que esta bien con valores de VIF>10 [Montgomery and Peck (1992)], esto sugiere que la colinearidad entre estas variables ya no es un problema. Otros autores sugieren que idealmente debe ser menor a 1.5, ver Zuur et al. 2009. Mixed Effects Models and Extensions in Ecology with R. pp.478 para referencias
vif(presencias_clima3[,4:22])# Priemro vemos si hay alta colinearidad entre variables
# De ser alta (mayor a 10 o el valor que se fije por el usuario) entonces se usa una reducci?n en pasos para ir elimin?ndolas
no_corr <- vifstep(presencias_clima3[,4:22], th=10) # th: es el valor de umbral deseado;Para ver cuáles fueron las variables que quedaron sin colinearidad
no_corr

# No se como guardarlo :( en archivo de texto write(no_corr, file = "abronia_mar_nocorr.txt")

