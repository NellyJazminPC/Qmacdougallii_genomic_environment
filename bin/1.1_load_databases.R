#### Set working directory to /bin/ folder
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


#Load the VCF file (variant call format)
var_snps_vcf <- read.vcfR("../data/var.79.inds.sorted.vcf")
var_snps_vcf

#Load metadata of the species
pop.data <- read.csv("../metadata/Qmacdougalli_79ind.csv")
head (pop.data)

#Verirify that the name of the samples in the VCF are the same as those in pop.data
all(colnames(var_snps_vcf@gt)[-1] == pop.data$NOM_IND)

#Converting the dataset to a genlight object

snps_genlight_sites <- vcfR2genlight(var_snps_vcf)

#We describe the ploidy of individuals
ploidy(snps_genlight_sites) <- 2
snps_genlight_sites@ploidy

#Determine populations through the collection site unless you have already determined which population each individual belongs to
pop(snps_genlight_sites) <- pop.data$SITIO

### Convert from genlight to genind and genclone

snps_sites_genind <- gl2gi(snps_genlight_sites, v=1)
snps_sites_genclone <- as.genclone(snps_sites_genind)

