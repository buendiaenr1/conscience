# --- Paquetes y datos ---------------------------------------
install.packages(c("lavaan", "tidyverse", "caret"), quiet = TRUE)
library(tidyverse)
library(lavaan)
library(caret)

datos <- read_csv("resp15.csv")   # asegúrate de que contenga item1:item15

# --- CFA ----------------------------------------------------
modelo_reducido <- '
  Mindfulness =~ item1 + item2 + item3 + item4 + item5 +
                 item6 + item7 + item8 + item9 + item10 +
                 item11 + item12 + item13 + item14 + item15
'

fit <- cfa(modelo_reducido, data = datos, estimator = "MLR")

# --- Métricas clásicas de ajuste ----------------------------
ajuste <- fitMeasures(fit)

# --- Puntuación latente y total -----------------------------
datos$Mindfulness <- lavPredict(fit, method = "regression")[, 1]
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

# --- Resultados CV ------------------------------------------
cat("Validación cruzada (k = 5)\n")
cat("MAE medio (CV):", round(model_cv$results$MAE, 3), "\n")
cat("RMSE medio (CV):", round(sqrt(model_cv$results$RMSE), 3), "\n")
cat("R² medio (CV):", round(model_cv$results$Rsquared, 3), "\n")

# --- Métricas CFA -------------------------------------------
cat(sprintf("CFI      : %.3f\n", ajuste["cfi"]))
cat(sprintf("TLI      : %.3f\n", ajuste["tli"]))
cat(sprintf("RMSEA    : %.3f\n", ajuste["rmsea"]))
cat(sprintf("SRMR     : %.3f\n", ajuste["srmr"]))

# --- Comparación real vs estimado vs residuos ---------------
datos$score_pred <- predict(model_cv, datos)
datos$residuo    <- datos$score_total - datos$score_pred

tabla_comparacion <- datos %>% 
  select(score_total, score_pred, residuo) %>% 
  mutate(
    abs_residuo = abs(residuo),
    pct_error   = abs_residuo / score_total * 100
  )

print(tabla_comparacion)
write_csv(tabla_comparacion, "comparacion_residuos.csv")

# --- Exportar ajuste y cargas -------------------------------
# Convertir ajuste a tibble antes de unir
ajuste_df <- tibble(
  metric = names(ajuste),
  value  = as.numeric(ajuste)
)

bind_rows(
  tibble(metric = "MAE",  value = model_cv$results$MAE),
  tibble(metric = "RMSE", value = sqrt(model_cv$results$RMSE)),
  tibble(metric = "R2",   value = model_cv$results$Rsquared),
  ajuste_df
) %>% write_csv("ajuste_cfa_maas_con_metricas.csv")

standardizedSolution(fit) %>% write_csv("cargas_factoriales_maas.csv")
