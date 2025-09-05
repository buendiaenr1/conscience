install.packages(c("xgboost", "caret", "readr"), quiet = TRUE)
install.packages(c("lavaan", "tidyverse", "caret"), quiet = TRUE)
library(tidyverse)
library(lavaan)
library(caret)
library(xgboost)
library(caret)
library(lavaan)
library(readr)

datos <- read_csv("resp15.csv")   # asegúrate de que contenga item1:item15

# --- CFA ----------------------------------------------------
modelo_reducido <- '
  Mindfulness =~ item1 + item2 + item3 + item4 + item5 +
                 item6 + item7 + item8 + item9 + item10 +
                 item11 + item12 + item13 + item14 + item15
'

fit <- cfa(modelo_reducido, data = datos, estimator = "MLR")

#preparar los datos
# Datos ya cargados y con columnas Mindfulness y score_total
datos$Mindfulness <- lavPredict(fit, method = "regression")[, 1]
datos$score_total <- rowSums(datos %>% select(starts_with("item")))

# Convertir la matriz para XGBoost
X <- as.matrix(datos["Mindfulness"])
y <- datos$score_total

# validacion cruzada XGBOOST
set.seed(123)
train_control <- trainControl(method = "cv", number = 5)

xgb_model <- train(
  score_total ~ Mindfulness,
  data = datos,
  method = "xgbTree",
  trControl = train_control,
  metric = "RMSE",
  tuneGrid = expand.grid(
    nrounds = 100,
    max_depth = 2,
    eta = 0.1,
    gamma = 0,
    colsample_bytree = 0.9,
    min_child_weight = 1,
    subsample = 1
  )
)

# Métricas de desempeño
cat("XGBoost — Validación cruzada (k = 5)\n")
cat(sprintf("R² medio (CV): %.3f\n", R2(pred = predict(xgb_model), obs = y)))
cat("MAE medio (CV):", round(mean(abs(predict(xgb_model) - y)), 3), "\n")
cat("RMSE medio (CV):", round(sqrt(mean((predict(xgb_model) - y)^2)), 3), "\n")


# predicción y tabla de residuos
datos$score_pred <- predict(xgb_model)
datos$residuo    <- datos$score_total - datos$score_pred

tabla_comparacion <- datos %>% 
  select(score_total, score_pred, residuo) %>% 
  mutate(
    abs_residuo = abs(residuo),
    pct_error   = abs_residuo / score_total * 100
  )

print(tabla_comparacion)
write_csv(tabla_comparacion, "comparacion_residuos_xgboost.csv")

# exportar modelo XGBOSST
xgb.save(xgb_model$finalModel, "modelo_xgboost_final.json")






