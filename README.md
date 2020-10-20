# *Quercus macdougallii*: functional genomics and its association with environmental variables
---
> # ******************** **UNDER CONSTRUCTION** ********************
---

In this repository you can find some analysis of population genomics, potential distribution and the identification of *outliers SNPs* in candidate genes to local adaptation for an oak endemic to México.

---
## ---------------------   GENERAL REPOSITORY STRUCTURE ---------------------

- [**info_project**](/info_project)
- [**data**](/data)
- [**metadata**](/metadata)
- [**bin**](/bin)
- [**output**](/output)
- [**archive**](/archives)

---

## --------------------- DETAILED REPOSITORY STRUCTURE ---------------------

## [info_project](/info_project)  


**Information about this project:** This work will constitute the first step to study the local adaptation in candidate genes associated with certain environmental variables (clime and soil) in natural populations of an oak endemic to Mexico, **_Quercus macdougallii_**. This could help to detect geographic patterns of functional genomic variation and improve conservation plans for the species. 


  Overall objective for this project: 
  - Analyze the functional genomic variation of *Quercus macdougallii* to identify genes associated with environmental variables
  
  Specific objectives for this project:
  - 1.- Identify outlier SNPs that are in coding regions
  - 2.- Analyze this set of outlier SNPs with multivariate models to detect the presence of correlations between this and a set of environmental variables.
  - 3.- Validate the expression of candidate genes identified through analysis of differential expression.

<p align="center">

<img src="info_project/Pozuelos_Arbol-sacrificio_sagrado.jpg" width="400"/>

</p>
<p align="center">

For more information go to [info_project/Qmacdougallii.md](/info_project/Qmacdougallii.md)

---
## [**data**](/data) 

**(IN PROCESS UNTIL PUBLICATION)**

This directory will contain the data for genomic and environmental analyzes (climate and soil). 

 - **genomic** : This directory contains sequences of candidate genes for local adaptation previously identified in the literature and the sequences obtained from the work of [Pacheco-Cruz, 2019](http://oreon.dgbiblio.unam.mx/F/X3YHJ1BNV7S4YYHEPDPIIA1S4GF2I5UGQMS61QGRFB4AHKPCJ7-04791?func=full-set-set&set_number=023823&set_entry=000002&format=999). As well as the VCF file (variant call format) of the identified SNPs.
 
    - **candidate_genes** : Sequences of genes previously identified and described in the literature as candidate genes for local adaptation in trees
    - **qmacd**           : Sequences of 80 individuals of the species *Q. macdougallii* obtained from the work of Pacheco-Cruz, 2019.
    - **outlier_SNPs**    : Identification of **_outliers SNPs_** for *Q. macdougallii*.


 - **climate** : Which contains the *shapes* and data of three main public databases to use, WorldClim, CONABIO and CONAGUA.
    - **wc** : Contains the layers of the [WorldClim site](https://www.worldclim.org/) with data for the current scenario and four scenarios under the effects of climate change.
        - *actual*
        - *2050_4.5*
        - *2050_8.5*
        - *2070_4.5*
        - *2070_8.5*
     
     - **conagua**
     
     - **conabio**
 
 
 - **soil**    : Contains the data of the analyzed variables (content of C, P, N)




---        
## [**metadata**](/metadata)

This directory contains the geographical coordinates and the altitude of each of the 80 individuals collected and analyzed in the work of [Pacheco-Cruz, 2019](http://oreon.dgbiblio.unam.mx/F/X3YHJ1BNV7S4YYHEPDPIIA1S4GF2I5UGQMS61QGRFB4AHKPCJ7-04791?func=full-set-set&set_number=023823&set_entry=000002&format=999).

---


## [**bin**](/bin)

This directory contains the scripts used to perform the analysis of functional genomics and its association with environmental variables (climate and soil) for *Q. macdugallii*.

**1. Genomic analysis**


**2. Environment analysis**
2.1_clean_data.R
2.2_value_extraction.R



---


## [**output**](/output)

Contains the figures generated from the scripts and the data, as well as a final report of everything obtained.

---

  
