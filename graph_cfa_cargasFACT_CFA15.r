

install.packages(c("lavaan", "semPlot", "tidyverse"))



#### cargar los datos
library(tidyverse)
library(lavaan)
library(semPlot)

# Cargar CSV
datos <- read_csv("resp15.csv")

# Verificar columnas
print(names(datos))


# Modelo reducido a 15 ítems
modelo_reducido <- '
  Mindfulness =~ item1 + item2 + item3 + item4 + item5 +
                 item6 + item7 + item8 + item9 + item10 +
                 item11 + item12 + item13 + item14 + item15
'

fit <- cfa(modelo_reducido, data = datos, estimator = "MLR")
summary(fit, fit.measures = TRUE, standardized = TRUE)

#### exportar resultados
# Índices de ajuste
fitMeasures(fit) %>%
  as.data.frame() %>%
  write_csv("ajuste_cfa_maas.csv")

# Cargas factoriales estandarizadas
standardizedSolution(fit) %>%
  write_csv("cargas_factoriales_maas.csv")


library(lavaanPlot)

lavaanPlot(model = fit, coefs = TRUE)