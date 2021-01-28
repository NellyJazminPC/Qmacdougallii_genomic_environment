# *Quercus macdougallii*: genomic and environmental analysis
---


<H2 align=center> *** UNDER CONSTRUCTION  ***
</H2>  



---

**About this research project:**   

The *Quercus* genus, also known as oaks, is one of the most important groups in the forest ecosystems of the northern hemisphere [(Cavender-Bares, 2016)](https://www.cbs.umn.edu/sites/cbs.umn.edu/files/public/downloads/2016.cavender.journal.ios%2327.pdf). Currently, Mexico is the main center of diversification of the *Quercus* genus (approx. 150 spp.), of which about half (76 spp.) are endemic to the country ([Valencia, 2004](https://www.botanicalsciences.com.mx/index.php/botanicalSciences/article/view/1692); [Romero-Rangel *et al.,* 2015](https://www.internationaloaksociety.org/content/encinos-de-mexico-new-book-about-mexican-oaks-spanish-0))

This great diversity and endemism represent an important area of opportunity for studies of adaptation in long-lived tree species to environmental variables in the face of climate change, especially since their ability to face rapid environmental changes can indicate functional processes essential for their survival, being an ideal setting for functional genomics studies ([IPCC](https://www.ipcc.ch/); [Naidoo *et al.,* 2019](https://www.frontiersin.org/articles/10.3389/fpls.2019.00273/full)).


</p>
<p align="center">

<img src="info_project/Qmacd.jpg" width="600"/>

</p> 

The oak *Quercus macdougallii* Martínez (1963), is an **endangered** ([IUCN, 2020](https://www.iucnredlist.org/species/32765/2823034)) and **threatened** ([DOF, 2019](http://www.dof.gob.mx/nota_detalle.php?codigo=5578808&fecha=14/11/2019)) **endemic** species, which has a distribution restricted to the Sierra Juárez also known as Sierra Norte de Oaxaca ([Valencia, 2004](https://www.botanicalsciences.com.mx/index.php/botanicalSciences/article/view/1692); [Romero-Rangel *et al.,* 2015](https://www.internationaloaksociety.org/content/encinos-de-mexico-new-book-about-mexican-oaks-spanish-0)).


**For more information go to [info_project/README.md](info_project/README.md)**


## **Programs and dependencies required to use the scripts in this repository**

For now, in this repository we have scripts that are only based on the R language.

The version of R that has been used is 4.0.3 but previous versions work without problem.

The packages to be used are mentioned at the beginning of each script but are briefly mentioned here:

|    |
| -- |
|vcfR    |
|ade4    |
|adegenet |   
|dartR    |
|ggplot2  |  
|poppr   | 
|ape    |
|plotly   |
|directlabels |   
|pca3d    |
|igraph    |
|shiny    |
|scatterplot3d |  
|RColorBrewer |    
|sp   |
|raster   |
|usdm    |
|corrplot|

### For later    
**Although is not included for now, scripts using the GradientForest package only work with version 3.6 or lower.**

---

<H1 align=center>  Structure of this repository
</H1>  
  
``` 
├── /info_project/
├── /bin/
│   ├── 1.1_load_databases.R
|   ├── 1.2_distances_tree.R 
│   ├── 1.3_PCoA.R 
|   ├── 1.4_MSN.R 
│   ├── 1.5_PCA.R  
|   ├── 1.6_DAPC_SNPs_structure_plot.R
│   ├── 2.1_clean_data.R 
|   ├── 2.2_values_extraction.R 
│   ├── 2.3_variable_correlation.R  
│   └── /maxent/
│       └── maxent.jar
├── /data/
│   ├── var.79.inds.sorted.vcf
│   ├── /raw/ (in process)
│   └── /filter/ (in process)
├── /metadata/
│   ├── Qmacdougalli_79ind.csv
│   ├── quercus_geog_todos_puntos.csv 
│   ├── /soil/ (in process)
│   └── /climate/ (is to heavy to storage in this repo)
│       ├── /conabio/ 
│       ├── /conagua/ (in process)
│       └── /wc/
│           ├── /2050_4.5/  
|           ├── /2050_8.5/
|           ├── /2070_4.5/
|           ├── /2070_8.5/
|           └── /actual/
└── /results/
    ├── /figures/
    ├── /databases/
    ├── /niche_model_WC_actual/
    |   └── /plots/
    ├── /README_files/
    |   └── /figure-latex/   
    ├── README.nb.html
    └── README.Rmd
```

---

##  DETAILED REPOSITORY STRUCTURE 

---

## [**/bin/**](/bin)

This directory contains the scripts used to perform the genomic analysis of populations and the selection of environmental variables (only the climate at the moment) for further analysis.

**1. Genomic analysis**      

|                      |                            |
| -------------------- | -------------------------- |
|1.1_load_databases.R  |  This script starts by loading all the libraries to be used in the downstream analyzes as well as the VCF and CSV files |
|1.2_distances_tree.R  |  This script is to make a tree through a matrix of genetic distances             |
|1.3_PCoA.R            |  This script is to perform a principal coordinate analysis (PCoA) as well as their respective graphs            |
|1.4_MSN.R             |  This script is to make a minimal expansion network (MSN) analysis was also performed, which groups multilocus genotypes (MLG) by genetic distances between them  |
|1.5_PCA.R             |  This script is to do an analysis of principal components (PCA) and their corresponding plots  |
|1.6_DAPC_SNPs_structure_plot.R |  This script is for doing a Discriminant Analysis of Principal Components (ADCP) which was used to identify and describe groups of genetically related individuals    |
   
**2. Environment analysis**      

|                           |                    |
| ------------------------  | ------------------ |
|2.1_clean_data.R           | This script is for cleaning the data. The duplicates were searched and removed from the dataset of coordinates, likewise only the data with a certain resolution was retained, which has to do with the resolution of the WorldClim environmental layers|
|2.2_values_extraction.R    | This script is to obtain the values of the climatic variables from WorldClim for each coordinate retained in the previous script |
|2.3_variable_correlation.R | This script is to find those variables with low levels of collinearity |


_What's next?:_
_**3. GradientForest**_
>_GradientForest is a multivariate, machine learning approach that considers potential non-linear patterns in the data. GF partitions the allele frequency data at split values along the environmental gradients. Split importance, a measure of the amount of variation explained, is high in positions along the gradient where allelic change is large. Moving along the gradient, the split importance values are summed cumulatively to produce a step-like function for allele frequency change along the environmental gradient, thus quantifying and describing the shape of the relationship between genotypic and environmental data. When run on a large "random" SNP data set, we can infer the contribution of isolation by environment or how environment shapes neutral evolutionary processes such as drift and gene flow. When run on adaptive SNP variation, we can learn more about how selection shapes variation across natural landscapes._

---



## [**/data/**](/data) 

**(IN PROCESS UNTIL PUBLICATION)**

This directory will contain the genomic data until the publication of the scientific paper.

At the moment, in this folder you can find the VCF file, called **`var.79.inds.sorted.vcf`**. which contains 8,186 SNPs identified for the 79 individuals analyzed in the work of [Pacheco-Cruz, 2019](http://oreon.dgbiblio.unam.mx/F/X3YHJ1BNV7S4YYHEPDPIIA1S4GF2I5UGQMS61QGRFB4AHKPCJ7-04791?func=full-set-set&set_number=023823&set_entry=000002&format=999).


_What's next?:_

_The objective is to use the raw sequencing data and add in bin the scripts used for cleaning and filtering, as well as for the assembly and identification of SNPs (VCF file), using the Stacks, iPyrad and bwa-freebayes pipelines._

---        
## [**/metadata/**](/metadata)

This directory contains the `.csv` file of geographical coordinates, altitude and the site where each of the 80 individuals were collected and analyzed in the work of [Pacheco-Cruz, 2019](http://oreon.dgbiblio.unam.mx/F/X3YHJ1BNV7S4YYHEPDPIIA1S4GF2I5UGQMS61QGRFB4AHKPCJ7-04791?func=full-set-set&set_number=023823&set_entry=000002&format=999).

### There are two .csv files:

#### 1.- `Qmacdougallii_79inds.csv` 
This file in `.csv` format contains the other data we have from the collected individuals, of which we have the sequences and SNPS (vcf file).
          
| Columns | Description |
| ---------- | ------- |
 | ID = | In the ID with which the samples were sequenced |
| MUN = | In municipality where the individual is |
| NUM_IND = | The number of individuals, just to verify that there are 79 individuals |
| SITE = | The individual's collection site. There were 8 sites |
| POP = | The possible population to which the individuals belong according to the structure analysis |
| ALT = | The altitude of where the individual is, given in meters above sea level (in spanish _msnm_) |
| Category Altitude = | Four categories of altitude were made from the altitude of the individuals |
| NOM_IND = | Renaming of individuals in the ID column by replacing the `.` with` _` to avoid errors when identifying rows |
| X = | Coordinates in UTM |
| Y = | Coordinates in UTM |
| long = | Geographic coordinates WGS84 |
| lat = | Geographic coordinates WGS84 |
| specie = | Unified name for each sample to use MaxEnt |

####  2.- `quercus_geog_todos_puntos.csv` 
This file in `.csv` format contains coordinates of 108 individuals with the WGS84 datum.

| Columns | Description |
| ---------- | ------- |
| specie = | Unified name for each sample to use MaxEnt |
| long = | Geographic coordinates WGS84 |
| lat = | Geographic coordinates WGS84 |


### The other two folders that was not uploaded in this repo for storage purpose are:


#### **/climate/**  

Which contains the *shapes* and data of three main public databases to use.

#### *wc* :      
Contains the layers of the [WorldClim site](https://www.worldclim.org/) with data for the current scenario and four scenarios under the effects of climate change.  
          
|Current scenario      |        |         |         |         |
| ------ | ------ | ------- | ------- | ------- |
| **/actual/**  | **/2050_4.5/** | **/2050_8.5/** | **/2070_4.5/** | **/2070_8.5/** |
        
The layers: 

|      |        |
| ---- | ------ |
|BIO1  | Annual Mean Temperature|
|BIO2 | Mean Diurnal Range (Mean of monthly (max temp - min temp)) |
|BIO3 | Isothermality (BIO2 / BIO7) (× 100)    |
|BIO4 | Temperature Seasonality (standard deviation × 100) |  
|BIO5 | Max Temperature of Warmest Month   |
|BIO6 | Min Temperature of Coldest Month   |
|BIO7 | Temperature Annual Range (BIO5-BIO6)   |
|BIO8 | Mean Temperature of Wettest Quarter   | 
|BIO9 | Mean Temperature of Driest Quarter   |
|BIO10 | Mean Temperature of Warmest Quarter |  
|BIO11 | Mean Temperature of Coldest Quarter|   
|BIO12 | Annual Precipitation   |
|BIO13 | Precipitation of Wettest Month   |
|BIO14 | Precipitation of Driest Month   |
|BIO15 | Precipitation Seasonality (Coefficient of Variation)|    
|BIO16 | Precipitation of Wettest Quarter   |
|BIO17 | Precipitation of Driest Quarter   |
|BIO18 | Precipitation of Warmest Quarter |  
|BIO19 | Precipitation of Coldest Quarter|
     
#### *conabio* :      
Contains the files in .shape format, obtained from the CONABIO portal http://geoportal.conabio.gob.mx/

|       |       |
| ----- | ----- |
|EXL | Existence of firewood in Mexico at the municipal level   |
|EXP | Exposure   |
|PRE | Average annual precipitation   |
|RHS | Soil moisture regimes   |
|ACE | Modified specific catchment area (accumulation of water due to surface runoff)   |
|PDT | Pending   |
|EDA | Edaphology (soil type)   |
|ELE | Digital Elevation Model   |
|HGE | Hydrogeology (water retention capacity, through porosity and permeability of the soil and subsoil)   |
|TEM | Annual mean temperature |
 
 #### */soil/*     
 In process
 
 Contains the data of the analyzed variables (content of C, P, N)

---

## [**/results/**](/results)

Contains the figures and databases generated from the scripts and the data, as well as a final report of everything obtained.   

```
/ results /     
      ├── / figures /: contains the images generated in the scripts individually
      ├── / databases /: contains the databases, .csv files generated in the scripts individually  
      ├── / niche_model_WC_actual /: contains the results generated in the MaxEnt analysis       
      |      └── / plots /: contains the plots generated in the MaxEnt analysis    
      ├── / README_files /: folder generated from R-notebook
      |       └── / figure-latex /: contains the figures generated by the R-notebook       
      ├── README.nb.html: the R-notebook in .html format          
      └── README.Rmd: the R-notebook in Rmarkdown .Rmd format
```

---


