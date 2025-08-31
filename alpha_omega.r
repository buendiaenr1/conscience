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

library(psych)

# Alpha y Omega
alpha  <- alpha(datos %>% select(starts_with("item")), check.keys = FALSE)
omega  <- omega(datos %>% select(starts_with("item")))

cat("Alpha  :", round(alpha$total$raw_alpha, 3), "\n")
cat("Omega  :", round(omega$omega.tot, 3), "\n")

