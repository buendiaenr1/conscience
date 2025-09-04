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

    **d** Exportación de resultados
   Se crean dos archivos:
   ajuste_cfa_maas.csv → todos los índices de ajuste.
   cargas_factoriales_maas.csv → cargas, errores, z, p, etc.
   Diagrama
   lavaanPlot genera un grafo con las cargas; el aviso de versión solo indica que el paquete fue compilado con R 4.4.3, pero funciona.
   Resumen: el CFA corre, la fiabilidad es alta, pero el ajuste global es pobre principalmente por la muestra pequeña y dos ítems problemáticos. Se recomienda:
   Aumentar n (mínimo 5-10 por parámetro).

    **j** Revisar/redactar item14 e item15 o eliminarlos.
   
   10. **ajuste_cfa_maas.csv**   contiene

        | Valor   | Etiqueta aprox.            | Interpretación                                             |

| ------- | -------------------------- | ---------------------------------------------------------- |

| 30      | npar                       | Número de parámetros estimados                             |

| 2.5579  | chisq/df                   | χ² / gl ≈ 1.54 (razón de χ²)                               |

| 138.13  | chisq                      | Estadístico χ² (modelo vs datos)                           |

| 90      | df                         | Grados de libertad                                         |

| 0.00084 | pvalue                     | p de χ² (< .05 ⇒ desajuste)                                |

| 140.35  | chisq.scaled               | χ² robusto MLR                                             |

| 0.00054 | pvalue.scaled              | p robusto                                                  |

| 0.984   | scaling.factor             | Factor de corrección MLR                                   |

| 295.68  | baseline.chisq             | χ² del modelo nulo                                         |

| 105     | baseline.df                | gl del nulo                                                |

| 0       | baseline.pvalue            | p del nulo                                                 |

| 1.001   | baseline.scaling.factor    | Factor MLR nulo                                            |

| 0.748   | cfi                        | Comparative Fit Index (≥ .90 deseable)                     |

| 0.706   | tli                        | Tucker-Lewis Index (≥ .90 deseable)                        |

| 0.735   | cfi.scaled                 | CFI robusto                                                |

| 0.691   | tli.scaled                 | TLI robusto                                                |

| 0.445   | nfi                        | Normed Fit Index                                           |

| 0.525   | nnfi                       | Non-Normed Fit Index                                       |

| 0.450   | pnfi                       | Parsimony NFI                                              |

| 0.767   | rfı                        | Relative Fit Index                                         |

| 0.740   | ifı                        | Incremental Fit Index                                      |

| 0.697   | rni                        | Relative Non-centrality Index                              |

| -659.93 | logl                       | Log-verosimilitud del modelo                               |

| -590.87 | logl.unrestricted          | Log-verosimilitud saturada                                 |

| 1379.87 | aic                        | AIC (menor = mejor)                                        |

| 1418.74 | bic                        | BIC (menor = mejor)                                        |

| 27      | n                          | Tamaño muestral                                            |

| 1325.55 | sabic                      | BIC ajustado por tamaño                                    |

| 0.949   | scaling.factor.h1          | Factor MLR H1                                              |

| 0.842   | scaling.factor.h0          | Factor MLR H0                                              |

| 0.141   | rmsea                      | Root Mean Square Error of Approx. (< .08 ó < .05 deseable) |

| 0.091   | rmsea.ci.lower             | límite inferior IC 90 %                                    |

| 0.186   | rmsea.ci.upper             | límite superior IC 90 %                                    |

| 0.9     | rmsea.pvalue               | p (RMSEA ≤ .05)                                            |

| 0.004   | rmsea.pvalue               | p (RMSEA ≤ .05) < .05 ⇒ rechaza buen ajuste                |

| 0.975   | rmsea.pvalue.larger        | p (RMSEA ≥ .08)                                            |

| 0.143   | rmsea.scaled               | RMSEA robusto                                              |

| 0.095   | rmsea.ci.lower.scaled      | IC inferior robusto                                        |

| 0.189   | rmsea.ci.upper.scaled      | IC superior robusto                                        |

| 0.003   | rmsea.pvalue.scaled        | p robusta RMSEA ≤ .05                                      |

| 0.980   | rmsea.pvalue.larger.scaled | p robusta RMSEA ≥ .08                                      |

| 0.275   | srmr                       | Standardized RMR (< .08 deseable)                          |

| 0.116   | srmr                       | Standardized RMR (< .08 deseable)                          |

| 23.12   | crmr                       | Coefficient of variation of RMR                            |

| 25.26   | crmr\_nomi                 | CRMR sin ponderar                                          |

| 0.616   | gfi                        | Goodness-of-F Index                                        |

| 0.489   | agfi                       | Adjusted GFI                                               |

| 0.462   | pgfi                       | Parsimony GFI                                              |

| 0.410   | mfi                        | McDonald Fit Index                                         |

| 7.338   | ecvi                       | Expected Cross-Validation Index                            |


Resumen rápido

CFI/TLI ≈ 0.74/0.71 (por debajo del corte ≥ 0.90).

RMSEA ≈ 0.14 (IC 90 % 0.09-0.19) > 0.08 ⇒ ajuste mediocre.

SRMR ≈ 0.12 > 0.08 ⇒ residuos altos.

χ² significativo (p < .001) rechaza igualdad perfecta.

Global: el modelo de 15 ítems no alcanza los estándares de ajuste habituales (Q1) con n = 27; se recomienda aumentar la muestra y revisar/reducir ítems.


11. **cargas_factoriales_maas.csv**

    | Columna             | Descripción breve                                                        |
| ------------------- | ------------------------------------------------------------------------ |
| lhs                 | Variable latente (factor)                                                |
| op                  | Tipo de relación: `=~` carga factorial, `~~` varianza/error              |
| rhs                 | Ítem o variable observada                                                |
| est.std             | **Carga factorial estandarizada** (λ) o **varianza/error estandarizado** |
| se                  | Error estándar de la estimación                                          |
| z                   | Valor z (est / se)                                                       |
| pvalue              | Probabilidad asociada a z                                                |
| ci.lower / ci.upper | Intervalo de confianza 95 %                                              |

Cargas factoriales (=~)

| Ítem       | λ (est.std) | p        | Interpretación                 |
| ---------- | ----------- | -------- | ------------------------------ |
| item1      | 0.56        | < .001   | Carga media                    |
| item2      | 0.68        | < .001   | Buena                          |
| item3      | 0.76        | < .001   | Muy buena                      |
| item4      | 0.70        | < .001   | Buena                          |
| item5      | 0.71        | < .001   | Buena                          |
| item6      | 0.63        | < .001   | Buena                          |
| item7      | 0.81        | < .001   | Excelente                      |
| item8      | 0.72        | < .001   | Buena                          |
| item9      | 0.70        | < .001   | Buena                          |
| item10     | 0.77        | < .001   | Muy buena                      |
| item11     | 0.43        | .016     | Aceptable (baja)               |
| item12     | 0.71        | < .001   | Buena                          |
| item13     | 0.56        | .001     | Media                          |
| **item14** | **-0.07**   | **.725** | **No significativa; eliminar** |
| **item15** | **-0.20**   | **.403** | **No significativa; eliminar** |

**Varianzas de error (~~):**

Van de 0.35 (item7) a 0.99 (item14); valores altos indican poca variancia explicada por el factor.

item14 e item15 tienen las varianzas de error más altas (≈ 0.96-0.99), coherentes con sus cargas inútiles.

Varianza del factor (Mindfulness ~~ Mindfulness) = 1.00 (fijado para identificación).

**Conclusión práctica**

Conservar ítems 1-13 (todas las cargas λ ≥ 0.43 y significativas).

Descartar item14 e item15 (no aportan; empeoran el ajuste).

Con 13 ítems el modelo ganará parsimonia y fiabilidad.

