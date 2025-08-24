import pandas as pd
import numpy as np
from xgboost import XGBRegressor
from sklearn.model_selection import cross_val_score
from sklearn.metrics import mean_absolute_error, mean_squared_error
import io

# Datos en formato CSV
data_raw = """rinst	reprobadas	aprobadas	avance
41	10	22	36
48	18	21	36
89	4	46	75
109	0	55	92
72	0	40	91
48	0	63	96
113	2	42	96
62	0	38	89
36	0	39	90
58	15	43	70
73	15	42	70
52	19	55	90
72	14	37	61
85	2	42	96
57	19	51	85
82	0	57	95
102	3	58	96
67	15	58	96
76	2	56	92
72	22	58	96
45	13		
77	0	57	95
39			
72	0	56	92
79	23	57	94
55	4	56	93"""

# Cargar datos
df = pd.read_csv(io.StringIO(data_raw), sep='\t')

# Limpiar datos: eliminar filas con valores faltantes en y o x
df = df.dropna(subset=['rinst', 'reprobadas', 'aprobadas', 'avance'])

# Definir X e y
X = df[['reprobadas', 'aprobadas', 'avance']]
y = df['rinst']

# Modelo
model = XGBRegressor(
    n_estimators=500,
    learning_rate=0.05,
    max_depth=3,
    subsample=0.8,
    colsample_bytree=0.8,
    random_state=42
)

# Validación cruzada
r2_scores = cross_val_score(model, X, y, cv=5, scoring='r2')
mae_scores = -cross_val_score(model, X, y, cv=5, scoring='neg_mean_absolute_error')
rmse_scores = np.sqrt(-cross_val_score(model, X, y, cv=5, scoring='neg_mean_squared_error'))

print("=== Métricas de validación cruzada ===")
print(f"R² promedio: {r2_scores.mean():.2f}")
print(f"MAE promedio: {mae_scores.mean():.2f}")
print(f"RMSE promedio: {rmse_scores.mean():.2f}")

# Entrenar modelo final y mostrar predicciones
model.fit(X, y)
df['predicción'] = model.predict(X)

print("\n=== Predicciones vs. Reales (primeras 5 filas) ===")
print(df[['rinst', 'predicción']].head())

# Importancia de características
importances = model.feature_importances_
feature_names = X.columns
importance_df = pd.DataFrame({'Variable': feature_names, 'Importancia (%)': importances*100})
importance_df = importance_df.sort_values(by='Importancia (%)', ascending=False)

print("\n=== Importancia de variables ===")
print(importance_df.to_string(index=False))