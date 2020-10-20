# *Quercus macdougallii*: functional genomics and its relation with environmental variables
---
> ## **UNDER CONSTRUCTION**
---

In this repository you can find some analysis of population genomics, potential distribution, the identification of outliers SNPs and candidate genes to local adaptation.

---
## General repository structure
- [**info_project**](/info_project)
- [**data**](/data)
- [**metadata**](/metadata)
- [**bin**](/bin)
- [**output**](/output)
- [**archive**](/archives)

---
## Information about this project  

### [info_project](/info_project)

This work will constitute the first step to study the local adaptation in candidate genes associated with certain environmental variables (clime and soil) in natural populations of an oak endemic to Mexico, **_Quercus macdougallii_**. This could help to detect geographic patterns of functional genomic variation and improve conservation plans for the species. 

Also, this project is close to two goals of [The Sustainable Development Goals (SDG)](https://sdgs.un.org/goals) proposed by the United Nations (UN). For the goal 15, because the information generated in this project is expected to help in the management of forests in a sustainable way and stop the loss of biodiversity that can occur due to lack of information on key species in the functioning of ecosystems. And for the goal 13, given that this oak is located in an area where indigenous communities try to conserve the biodiversity of their forests and at the same time maintain sustainable forest management.

<p align="center">

<img src="info_project/Pozuelos_Arbol-sacrificio_sagrado.jpg" width="400"/>

</p>
<p align="center">

For more information go to [info_project/Qmacdougallii.md](/info_project/Qmacdougallii.md)

---
## Data specifications (IN PROCESS UNTIL PUBLICATION)

### [**data**](/data)

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
## Otros datos importantes

### [**metadata**](/metadata)

This directory contains the geographical coordinates and the altitude of each of the 80 individuals collected and analyzed in the work of [Pacheco-Cruz, 2019](http://oreon.dgbiblio.unam.mx/F/X3YHJ1BNV7S4YYHEPDPIIA1S4GF2I5UGQMS61QGRFB4AHKPCJ7-04791?func=full-set-set&set_number=023823&set_entry=000002&format=999).

---
## Scripts

### [**bin**](/bin)

This directory contains the scripts used to perform the analysis of functional genomics and its association with environmental variables (climate and soil) for *Q. macdugallii*.

1.1 
1.2
1.3 
1.7

2.1
2.2
2.3


---
## The output: figures and final report

### [**output**](/output)

Contains the figures generated from the scripts and the data, as well as a final report of everything obtained.

---

  
