#!/bin/bash

ruta_abs_bed=/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_4/variants.fil.79.fil4.bed

# -j número de procesadores
# -s random seed

for K in 1 2 3 4 5 6 7 8 9 10; 
do ./admixture --cv $ruta_abs_bed  $K -j10 -s time -B | tee log${K}.out; done

grep CV log*.out >chooseK.txt

cat chooseK.txt

