# conscience
instruments for assessing awareness

*** Escala MAAS
Mindful Attention Awareness Scale  
#### cuest_MAAS - arch_resp.html  crea un archivo de respuestas para enviar por correo las respuestas



1.  **alpha_omega.r** calcula el alfa de Cronbach y el ommega de los datos en resp15.csv.

2.  **comparación_residuos_xgboost.csv.** dato real, estimación de xgboost,residuo,residuo absoluto, porcentage de error.                               .

3.  **modelo_xgboost_final.json** Modelo creado para hacer las estimaciones de xgboosts.r.

4.  **o_metricas.r** Métricas posibles de usar, usar parte inicial con métrica correspondiente, y verificar su cumplimiento. Por ejemplo se muestra la invarianza que no cumple la información recabada.
5.  **persona1-copia.txt** Información recabada por el archivo repartido a la muestra de participantes cuest_MAAS-arch_resp.html.
   
6.  **resp15.csv** Respuestas de cada archivo personax.txt corresponde a cada renglon de este archivo, recortando el numero de columnas a 15 con n=27 renglones o personas que forman la muestra, ya que el original de 24 items o columnas no cumple los requisitos de estadística para usar metricas.
7.  **resp24.csv** Respuestas completas de 24 items de 27 personas del cuestinario MAAS.
8.  **xgboosts.r** Archivo de análisis principal de la investigación, crea la validación cruzada (k=5), crea los archivos comparación_residuos_xgboost.csv y modelo_xgboost_final.json"
9.  
