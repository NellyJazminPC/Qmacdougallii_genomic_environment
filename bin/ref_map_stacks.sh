##scrip para stacks genoma de referencia

#guardar path del directorio que contiene el archivo fasta

midirec=/home/alejandro/Escritorio/Quercus/Campos_Project_002/ref_map_prueba/input/
cd $midirec

## Limpieza de las secuencias fastq (riguroso)

for i in QM9*001 QM10*001 QM11*001 QM12*001 QM13*001 QM14*001 QM15*001 QM16*001; do docker run --rm -v $midirec:/data biocontainers/fastxtools /bin/bash -c "fastx_trimmer -f 1 -l 150 -v -i $i.fastq | \fastq_quality_filter -q 15 -p 90 -o clean/clean$i.fastq -v"; done

#guardar path del directorio que contiene el archivo fasta

midirec=/home/alejandro/Escritorio/Quercus/Campos_Project_002/ref_map_prueba/
cd $midirec

# Indexar genoma de referencia (se hace en un volumen que se monta en docker mediante Bowtie2)

docker run --rm -v $midirec:/data biocontainers/bowtie2 bowtie2-build Qlobata.v3.0.fasta Qlobata

#alinear a genoma de referencia 

for i in QM9*001 QM10*001 QM11*001 QM12*001 QM13*001 QM14*001 QM15*001 QM16*001; do docker run --rm -v $midirec:/data biocontainers/bowtie2 bowtie2 -x Qlobata -U input/clean/clean$i.fastq -S map_clean/map_clean_$i.sam; done

# Cambiar de formato SAM a BAM y realizar el sort e index de los archivos bam

for i in QM9*001 QM10*001 QM11*001 QM12*001 QM13*001 QM14*001 QM15*001 QM16*001; do docker run --rm -v $midirec:/data biocontainers/samtools samtools view -bS map_clean/map_clean_$i.sam > map_clean/map_clean_$i.bam
docker run --rm -v $midirec:/data biocontainers/samtools samtools sort map_clean/map_clean_$i.bam -o map_clean/sort/map_clean_$i.sorted.bam
docker run --rm -v $midirec:/data biocontainers/samtools samtools index map_clean/sort/map_clean_$i.sorted.bam; done
#borrar archivos sam y bam iniciales

rm map_clean/*.sam
rm map_clean/*.bam

#realizar el re_map.pl en stacks

ref_map.pl -T 3 --samples /home/alejandro/Escritorio/Quercus/Campos_Project_002/ref_map_prueba/map_clean/sort/ --popmap /home/alejandro/Escritorio/Quercus/Campos_Project_002/ref_map_prueba/../../popmap_quercus_map_clean.txt -o /home/alejandro/Escritorio/Quercus/Campos_Project_002/ref_map_prueba/prueba_ref/ 

