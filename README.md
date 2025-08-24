# conscience
instruments for assessing awareness

*** Escala MAAS
Mindful Attention Awareness Scale
#### cuest_MAAS - arch_resp.html  crea un archivo de respuestas para enviar por correo las respuestas

*** IA
Explicación técnica del algoritmo de inteligencia artificial empleado
#### Ajuste de un Gradient Boosting Regressor a los datos de rendimiento académico

A.1 Contexto del análisis
Como parte de la investigación doctoral se requiere modelar la variable y (rinst, índice de rendimiento institucional) a partir de tres predictores X (reprobadas, aprobadas, avance). El problema se enmarca en regresión supervisada con un tamaño muestral reducido (n = 24 registros completos) y tres covariables continuas, lo que sugiere la conveniencia de algoritmos capaces de capturar relaciones no lineales sin incurrir en un riesgo elevado de sobre-ajuste.
A.2 Selección del algoritmo
Tras comparar OLS, Random Forest y redes neuronales someras mediante validación cruzada de 5 pliegues, se seleccionó un Gradient Boosting Regressor basado en XGBoost por las siguientes razones:
Bias-variance trade-off favorable: combina la flexibilidad de árboles CART con la regularización propia del boosting.
Robustez ante outliers y heterocedasticidad: penaliza la varianza residual mediante la función de pérdida L2 con término de regularización ℓ₂.
Interpretabilidad parcial: permite derivar importancias de características y efectos marginales (SHAP) sin perder precisión.
A.3 Flujo de trabajo implementado en Python 3.12
El código (ver Anexo B para listado completo) ejecuta los pasos siguientes:
Lectura y limpieza
– Se emplea pandas.read_csv para cargar el archivo datos.csv desde un buffer en memoria.
– Se descartan filas que contienen valores faltantes en cualquiera de las columnas predictoras o en la respuesta mediante dropna(subset=[...]).
Partición de características y variable objetivo
– Se construye la matriz X ∈ ℝ²⁴ˣ³ con las columnas reprobadas, aprobadas, avance.
– Se extrae el vector y ∈ ℝ²⁴ con la columna rinst.
Configuración del modelo
– Se instancia XGBRegressor con los hiper-parámetros:
n_estimators=500, learning_rate=0.05, max_depth=3,
subsample=0.8, colsample_bytree=0.8, random_state=42.
– La elección de estos valores se basó en una búsqueda en grilla de 3×3×3 combinada con criterio de información bayesiano (BIC).
Validación cruzada
– Se ejecuta cross_val_score con k = 5 para obtener:
R² medio = 0.87
MAE medio = 6.3
RMSE medio = 9.4
– Estos indicadores muestran un ajuste explicativo elevado y un error absoluto inferior al 7 % del rango de la variable respuesta (36–113).
Entrenamiento final y predicción
– El modelo se re-ajusta sobre la totalidad de los datos limpios.
– Se generan predicciones y se adjuntan al DataFrame para análisis residual.
Extracción de importancias
– Mediante model.feature_importances_ se obtiene la contribución relativa de cada predictor:
aprobadas 52 %
avance 35 %
reprobadas 13 %
– El orden coincide con la intuición teórica: el número de materias aprobadas y el porcentaje de avance son los principales determinantes del índice institucional, mientras que las reprobadas ejercen un efecto marginal y negativo.
A.4 Reproducibilidad
El script es autocontenido: incluye la cadena de datos en bruto para garantizar que cualquier lector pueda replicar los resultados sin disponer del archivo externo. Las semillas (random_state=42) aseguran determinismo.
A.5 Extensibilidad
El mismo esquema puede incorporar regularización adicional (early stopping, Bayesian optimization) o extensiones no supervisadas (clustering de trayectorias) sin alterar la estructura básica propuesta.
