##Scrip para denovo_map.pl en Stacks

#guardar path del directorio que contiene el archivo fasta

midirec=/home/alejandro/Escritorio/Quercus/Campos_Project_002/denovo_prueba_clean/
cd $midirec

## Limpieza de las secuencias fastq (riguroso)

for i in QM9*001 QM10*001 QM11*001 QM12*001 QM13*001 QM14*001 QM15*001 QM16*001; do docker run --rm -v $midirec:/data biocontainers/fastxtools /bin/bash -c "fastx_trimmer -f 1 -l 150 -v -i $i.fastq | \fastq_quality_filter -q 15 -p 90 -o clean/clean$i.fastq -v"; done

#Comprimir archivos fastq limpios (ya que stacks corre con archivos fastq.gz)

gzip -9 *fastq

#correr ensamble de novo con Stacks

denovo_map.pl -T 3 -m 3 -M 4 -n 4 -o /home/alejandro/Escritorio/Quercus/Campos_Project_002/prueba_denovo_clean --samples /home/alejandro/Escritorio/Quercus/Campos_Project_002/clean --popmap /home/alejandro/Escritorio/Quercus/Campos_Project_002/../popmap_clean.txt
