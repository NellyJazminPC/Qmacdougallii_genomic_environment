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
- [**figures**](/figures)
- [**archive**](/archives)

---
## Information about this project  

### [info_project](/info_project)

This work will constitute the first step to study the local adaptation in candidate genes associated with certain environmental variables (clime and soil) in natural populations of an oak endemic to Mexico, **_Quercus macdougallii_**. This could help to detect geographic patterns of functional genomic variation and improve conservation plans for the species. Also, this project is close to two goals of [The Sustainable Development Goals (SDG)](https://sdgs.un.org/goals) proposed by the United Nations (UN). For the goal 15, because the information generated in this project is expected to help in the management of forests in a sustainable way and stop the loss of biodiversity that can occur due to lack of information on key species in the functioning of ecosystems. And for the goal 13, given that this oak is located in an area where indigenous communities try to conserve the biodiversity of their forests and at the same time maintain sustainable forest management.

<p align="center">

<img src="info_project/Pozuelos_Arbol-sacrificio_sagrado.jpg" width="400"/>

</p>
<p align="center">

For more information go to [info_project/Qmacdougallii.md](/info_project/Qmacdougallii.md)

---
## Data specifications (IN PROCESS)

### [**data**](/data)

Este directorio contendrá datos para los análisis genómicos, para la identificación de SNPs outliers para la especie y para la identificación de estos en posibles genes candidatos a adaptación local. Por otra parte, también contendrá datos de variables climáticas y ambientales 

 - **genomic** : El cual contiene secuencias de genes candidatos a adaptación local previamente identificados en la literatura y las secuencias obtenidas del trabajo de Pacheco-Cruz, 2019 así como el archivo VCF (variant call format) de los SNPs identificados.
    - **candidate_genes** :secuencias de genes previamente identificados y descritos en la literatura
    - **qmacd**           :secuencias de 80 individuos de la especie Q. macdougallii obtenidos a partir del trabajo de Pacheco-Cruz, 2019.
    - **outlier_SNPs**    :identificación de SNPs outliers para la especie Q. macdougallii a partir de las secuencias del trabajo de Pacheco-Cruz, 2019.


 - **climate** : El cual contiene las capas de las tres principales bases de datos públicas a utilizar
    - **wc** : Contiene las capas del sitio [WorldClim](https://www.worldclim.org/) con datos para el escenario actual y para cuatro escenarios bajo efectos de cambio climático
        - *actual*
        - *2050_4.5*
        - *2050_8.5*
        - *2070_4.5*
        - *2070_8.5*
     
     - **conagua**
     
     - **conabio**
 
 
 - **soil**    : Contiene los datos de las variables analizadas (contenido de C, P, N)




---        
## Metadata 

### [**metadata**](/metadata)

Este directorio contiene las coordenadas geográficas y la altitud de cada uno de los 80 individuos colectados y analizados en el trabajo de Pacheco-Cruz, 2019.

---
## Bin 

### [**bin**](/bin)

Este directorio contiene los scripts utilizados para realizar 

1.1 
1.2
1.3 
1.7

2.1
2.2
2.3


---
## Figures

### [**figures**](/figures)

Este directorio contiene las figuras generadas a partir de los scripts y los datos

---
## Archive

### [**archive**](/archive)

Este directorio contiene archivos de texto que se han generado durante los análisis pero no son extrictamente necesarios para la ejecución de los scripts.
  
