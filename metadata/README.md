# Files in the `/ metadata /` folder

## ** 1.- `Qmacdougallii_79inds.csv` **
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

## ** 2.- ´quercus_geog_todos_puntos.csv´ **
This file in `.csv` format contains coordinates of 108 individuals with the WGS84 datum.

| Columns | Description |
| ---------- | ------- |
| specie = | Unified name for each sample to use MaxEnt |
| long = | Geographic coordinates WGS84 |
| lat = | Geographic coordinates WGS84 |
