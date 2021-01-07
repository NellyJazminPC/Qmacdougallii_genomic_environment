#!/bin/bash 
#############################
#### Plink ####

#Para convertir archivo en formato PLINK (.ped y .map) a .bed

ruta_file=var.79.4.1.plk
output_name=var.79.4.1

~/programs_bioinf/plink-1.07-x86_64/plink --file $ruta_file --recodeAD --out $output_name


~/programs_bioinf/plink-1.07-x86_64/plink --file $ruta_file --make-bed --out $output_name 
