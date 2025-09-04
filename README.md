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
9.  **graph_cfa_cargasFACT_CFA15**
    **a** Datos leídos sin problemaresp15.csv tiene 27 filas y 15 columnas (item1...item15). La velocidad de lectura (9.26 MB/s) solo indica que el archivo es pequeño y se cargó rápido.
   **b** Estimación del CFA
   lavaan ajustó el modelo con 30 parámetros (15 cargas factoriales + 15 varianzas de error) usando máxima verosimilitud robusta (MLR).
   Aviso de «no positive definite»
   Aparece porque la matriz de covarianzas de los parámetros estimados tiene un autovalor negativo muy pequeño (−1.66 × 10⁻¹⁶).
   En la práctica es cero dentro del error numérico.
   Suele deberse a identificación débil (pocos sujetos, muchos parámetros) o alta colinealidad.
   Con n = 27 y 15 ítems el modelo está just-identificado; el aviso es esperable y no invalida el análisis, pero hay que interpretar con cautela.
   **c** Bondad de ajuste
   χ²(90) = 138.1, p = 0.001 → rechaza la igualdad perfecta modelo-datos.
   CFI = 0.74, TLI = 0.71 (umbares deseables ≥ 0.90/0.95).
   RMSEA = 0.14 (IC90 % 0.09-0.19); SRMR = 0.12.
   → El ajuste es mediocre: el modelo captura parte de la estructura, pero la muestra es pequeña y la varianza residual alta.
   Cargas factoriales estandarizadas
   Items 1-13 y 15 tienen cargas 0.43-0.81 (aceptables).
   item14 y item15 presentan cargas negativas o muy bajas (−0.07 y −0.20) y no significativas (p > 0.05), lo que sugiere que no miden bien el factor y podrían eliminarse o reformularse.
   Fiabilidad de constructo
   α = 0.884 y ω = 0.925 (alto); sin embargo, estas estimaciones se inflan porque se calculan sobre el modelo forzado a 15 ítems.
   Si se retiran item14 e item15, α y ω seguirían siendo altas y el ajuste mejoraría.
   Exportación de resultados
   Se crean dos archivos:
   ajuste_cfa_maas.csv → todos los índices de ajuste.
   cargas_factoriales_maas.csv → cargas, errores, z, p, etc.
   Diagrama
   lavaanPlot genera un grafo con las cargas; el aviso de versión solo indica que el paquete fue compilado con R 4.4.3, pero funciona.
   Resumen: el CFA corre, la fiabilidad es alta, pero el ajuste global es pobre principalmente por la muestra pequeña y dos ítems problemáticos. Se recomienda:
   Aumentar n (mínimo 5-10 por parámetro).
   **j** Revisar/redactar item14 e item15 o eliminarlos.
   
   
