
Se descargaron las capas de 90 m de resolución  http://idrisi.uaemex.mx/

Algo raro que note es que en Ubuntu me hacia falta instalar **unrar** y por ello no podía descomprimir los archivos.     
Después, al cargar las capas en QGIS 3.10.4 no permitia visualizarlas.      
Trate en ArcMap y logré cargar las capas pero al inicio me pedía asignar valores en pirámide, que el programa después creo en automático pero noté que hay varias capas que tienen el mismo valor a lo largo de todo el territorio mexicano.      

Para hacer un corte en todos los archivos `.tif` instale el SMD_ToolBox, un recordatorio fue este video https://www.youtube.com/watch?v=y4cwwlXQQJ0      
![2021-03-09 (2)](https://user-images.githubusercontent.com/25624961/110552642-52d98380-80fd-11eb-92cd-36b22173479c.png)

El proceso para hacer los cortes en lote         
![2021-03-09 (4)](https://user-images.githubusercontent.com/25624961/110558394-0b0c2980-8108-11eb-8dfd-5f0ce06afb30.png)

Después de obtener los cortes y en formato ``asc.`` faltaba definir la proyección para cada una de estas capas. Por ahora no encontré una forma de hacerlo en lotes por lo que lo hice de una en una      
![2021-03-09 (3)](https://user-images.githubusercontent.com/25624961/110558187-a8b32900-8107-11eb-8615-88aee3b623eb.png)


Realicé una rápida prueba con MaxEnt https://biodiversityinformatics.amnh.org/open_source/maxent/ para asegurarme que leyera las capas y así fue.   
El archivo que utilicé para las coordenadas fue ``Pcaesium_long_lat_maxent_R_extraccion - copia.csv``



Después hice el mismo proceso cortando las capas con el shapefile de corte_altiplano.       


