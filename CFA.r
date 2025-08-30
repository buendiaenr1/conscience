# --- Paquetes y datos ---------------------------------------
install.packages(c("lavaan", "semPlot", "tidyverse", "lavaanPlot","caret"), quiet = TRUE)
library(tidyverse)
library(lavaan)
library(semPlot)
library(lavaanPlot)
library(caret)

datos <- read_csv("resp15.csv")

# --- CFA ----------------------------------------------------
modelo_reducido <- '
  Mindfulness =~ item1 + item2 + item3 + item4 + item5 +
                 item6 + item7 + item8 + item9 + item10 +
                 item11 + item12 + item13 + item14 + item15
'

fit <- cfa(modelo_reducido, data = datos, estimator = "MLR")

# --- Métricas clásicas de ajuste ----------------------------
ajuste <- fitMeasures(fit)

# --- Predicción para MAE / RMSE -----------------------------
fscores <- lavPredict(fit, method = "regression")[, 1]
obs_scores <- rowSums(datos %>% select(starts_with("item")))

mae  <- mean(abs(obs_scores - fscores))
rmse <- sqrt(mean((obs_scores - fscores)^2))

# --- Resultados ---------------------------------------------
cat(sprintf("CFI      : %.3f\n", ajuste["cfi"]))
cat(sprintf("TLI      : %.3f\n", ajuste["tli"]))
cat(sprintf("RMSEA    : %.3f\n", ajuste["rmsea"]))
cat(sprintf("SRMR     : %.3f\n", ajuste["srmr"]))
cat(sprintf("MAE      : %.3f\n", mae))
cat(sprintf("RMSE     : %.3f\n", rmse))

# --- Exportar -----------------------------------------------
bind_rows(
  tibble(metric = "MAE", value = mae),
  tibble(metric = "RMSE", value = rmse),
  enframe(ajuste)
) %>% write_csv("ajuste_cfa_maas_con_metricas.csv")

standardizedSolution(fit) %>% write_csv("cargas_factoriales_maas.csv")

# --- Visualización ------------------------------------------
lavaanPlot(model = fit, coefs = TRUE)




#fit <- cfa(modelo, data = datos, estimator = "MLR")

# --- Obtener puntuación latente -----------------------------
datos$Mindfulness <- lavPredict(fit, method = "regression")[, 1]

# Variable dependiente: suma de ítems
datos$score_total <- rowSums(datos %>% select(starts_with("item")))

# --- Validación cruzada -------------------------------------
set.seed(123)
train_control <- trainControl(method = "cv", number = 5)

model_cv <- train(
  score_total ~ Mindfulness,
  data = datos,
  method = "lm",
  trControl = train_control,
  metric = "MAE"
)

# --- Resultados ---------------------------------------------
cat("Validación cruzada (k = 5)\n")
cat("MAE medio (CV):", round(model_cv$results$MAE, 3), "\n")
cat("RMSE medio (CV):", round(sqrt(model_cv$results$RMSE), 3), "\n")
cat("R² medio (CV):", round(model_cv$results$Rsquared, 3), "\n")




# --- Comparación de valores reales, estimaciones y residuos ---
datos$score_pred <- predict(model_cv, datos)
datos$residuo    <- datos$score_total - datos$score_pred

tabla_comparacion <- datos %>% 
  select(score_total, score_pred, residuo) %>% 
  mutate(abs_residuo = abs(residuo),
         pct_error   = abs_residuo / score_total * 100)

print(tabla_comparacion)
write_csv(tabla_comparacion, "comparacion_residuos.csv")