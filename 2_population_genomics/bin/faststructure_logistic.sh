#!/bin/bash
#Para faststructure, structure prior= simple

for i in 1 2 3 4 6 8 10; 

do python ~/proj/fastStructure/structure.py -K $i --input=variants.fil.79.fil4 --output=variants.fil.79.fil4.logistic --full --seed=200 --prior=logistic ;
done

python ~/proj/fastStructure/chooseK.py --input=variants.fil.79.fil4.logistic  > chooseK_variants.fil.79.fil4.logistic.txt

cat chooseK_variants.fil.79.fil4.logistic.txt
