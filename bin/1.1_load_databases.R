#### 
rm(list = ls(all=TRUE))

### Libraries

library(vcfR)
library(ade4)
library(adegenet)
library(dartR) 
library(ggplot2)
library(poppr)
library(ape)
library(plotly)# For PCoA
library(directlabels) # For PCoA
library(pca3d)#For the gl.pcoa.plot.3d
library(igraph) #For Minimum spanning networks (MSN)
library(shiny) # To execute MSN interactive mode
library(scatterplot3d) #For 3D PCA
library(RColorBrewer)


#Cargar el archivo VCF (variant call format)
var_snps_vcf <- read.vcfR("../data/var.79.inds.sorted.vcf")
var_snps_vcf

#Cargar metadatos de la especie
pop.data <- read.csv("../metadata/Qmacdougalli_79ind.csv")
head (pop.data)

#Veririficar que el nombre las muestras en el VCF sean iguales a las del pop.data
all(colnames(var_snps_vcf@gt)[-1] == pop.data$NOM_IND)

#Converting the dataset to a genlight object

snps_genlight_sites <- vcfR2genlight(var_snps_vcf)

#Describimos las ploidia de los individuos
ploidy(snps_genlight_sites) <- 2
snps_genlight_sites@ploidy

#Determina las poblaciones mediante el sitio de colecta a menos que ya tengas determinada a que población pertenece cada individuo
pop(snps_genlight_sites) <- pop.data$SITIO

###Convertir de genlight a genind y a genclone

snps_sites_genind <- gl2gi(snps_genlight_sites, v=1)
snps_sites_genclone <- as.genclone(snps_sites_genind)