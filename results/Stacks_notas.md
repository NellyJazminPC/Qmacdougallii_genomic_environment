### Pasos para Stacks
Al comenzar a usar Stacks, este no permitio el uso de los archivos con lecturas de diferentes tamaños, lo que se obtuvo antes con Trimmomatic y el comando:

-Se necesita instalar Java previo al uso de Trimmomatic https://www.java.com/es/download/

```
trimmomatic SE -threads 10 -phred33 ../data/raw/$i*.fastq ../data/0.2_Trimmomatic/$i.trimmed.fastq.gz CROP:140 HEADCROP:10 ;
```

Por lo que se volvio a correr el comando de Trimmomatic pero sin "LEADING:33 TRAILING:33 SLIDINGWINDOW:4:15 MINLEN:80"

Después visualizamos con FastQC

El comando para Stacks de novo

```
denovo_map.pl -T 8 -M 4 -o stacks_denovo/ --samples ../data/0.4_Trimmomatic  --popmap stacks_denovo/popfile_qmacd_stacks_stacks.txt --resume
```

Para correr populations
populations -P stacks_denovo --popmap stacks_denovo/popfile_qmacd_stacks_stacks.txt -p 8 -r 1 -t 8 --vcf --structure  --genepop

populations -P stacks_denovo_8sites --popmap stacks_denovo_9sites/popfile_qmacd_stacks_9sites.txt -p 8 -r 1 -t 8 --vcf --structure  --genepo

# Para Stacks con genoma de referencia
Para crear un contenedor en docker en donde poder usar bowtie2

```docker pull comics/bowtie2```

```docker run -v $midirec:/data -it comics/bowtie2 /bin/bash```

# Para indexar el genoma de referencia
```bowtie2-build bwaAll.fasta Qlobata```
