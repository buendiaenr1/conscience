# 1. INVARIANCIA FACTORIAL
# (Permite saber si el MAAS mide igual para personas con puntuaciones altas vs. bajas, sin necesidad de género o semestre)

# 1) Asegurar repositorio CRAN
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# 2) Instalar semTools
install.packages("semTools", dependencies = TRUE)

# 3) Cargar
library(semTools)

library(lavaan)
library(semTools)
library(tidyverse)

# 1. Leer datos
datos <- read_csv("resp15.csv")

# 2. Crear variable total y grupo
datos <- datos %>%
  mutate(
    score_total = rowSums(across(starts_with("item"))),    # suma de los 15 ítems
    grupo       = ifelse(score_total < median(score_total), "baja", "alta")
  )

# 3. Modelo CFA
modelo_reducido <- '
  Mindfulness =~ item1 + item2 + item3 + item4 + item5 +
                 item6 + item7 + item8 + item9 + item10 +
                 item11 + item12 + item13 + item14 + item15
'

# 4. Invarianza
config <- cfa(modelo_reducido, data = datos, group = "grupo")
metric <- cfa(modelo_reducido, data = datos, group = "grupo", group.equal = "loadings")
scalar <- cfa(modelo_reducido, data = datos, group = "grupo", group.equal = c("loadings","intercepts"))

# 5. Comparación
lavTestLRT(config, metric, scalar) %>% print()
# Aporte artículo
# Detecta si los ítems funcionan igual en participantes con baja o alta atención plena.
# Si la invarianza se mantiene, se puede comparar puntuaciones entre grupos sin sesgo.



#2. CONSISTENCIA INTERNA
#(Valida la fiabilidad interna del MAAS-15)

library(psych)

# Alpha y Omega
alpha  <- alpha(datos %>% select(starts_with("item")), check.keys = FALSE)
omega  <- omega(datos %>% select(starts_with("item")))

cat("Alpha  :", round(alpha$total$raw_alpha, 3), "\n")
cat("Omega  :", round(omega$omega.tot, 3), "\n")

# Aporte artículo
# Alpha ≥ 0.80 y Omega ≥ 0.80 confirman que los 15 ítems miden un mismo constructo.
# Asegura que el instrumento es fiable en la muestra mexicana.



#3. DIFERENCIA CLÍNICAMENTE RELEVANTE (MCID)
# (Indica cuánto debe cambiar un participante para que la mejora sea percibida como “real”)

sd_half <- 0.5 * sd(datos$score_total)
cat("MCID (0.5 SD):", round(sd_half, 2), "puntos\n")

# Aporte artículo
# El MCID permite interpretar si una intervención de mindfulness genera cambios “clínicos”
# y fija puntos de corte para estudios longitudinales.




# Invarianza (validez de comparación entre grupos)
# Consistencia (fiabilidad interna)
# MCID (interpretación clínica de cambios)


# curva de información total
library(mirt)
mod_irt <- mirt(datos %>% select(starts_with("item")), 1, SE = TRUE)
itemfit(mod_irt)
plot(mod_irt, type = "info")  # TIF y IIF




