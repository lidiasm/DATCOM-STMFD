# Librería que permite aplicar tests estadísticos para comparar modelos entrenados
# sobre series temporales
library(tseries)

# Función que itera sobre una carpeta proporcionada y carga los ficheros CSV
# resultantes de la ejecución de un script MOA con el objetivo de recuperar las
# tasas de acierto obtenidas a partir del número de columna especificado
load_moad_results <- function(folder, n_acc_col) {
  # Leemos los diferentes ficheros CSV con los resultados de las diferentes
  # iteraciones
  files <- list.files(path=folder, full.names=TRUE, recursive=FALSE)
  # Cargamos los datos como dataframes y accedemos a la columna que contiene la 
  # tasa de aciertos
  accuracy <- lapply(files, function(x) {
    data <- read.csv(x, header=TRUE)
    return(data[, n_acc_col])
  })
  # Convertimos la lista de valores accuracy a un vector numérico
  return(unlist(accuracy, use.names=FALSE))
}

# Leemos las métricas resultantes de ambos clasificadores
model1.acc <- load_moad_results("ht_online_results", 5) #3
model2.acc <- load_moad_results("hat_online_results", 5) #3
# Creamos un dataframe para representar los resultados
df <- data.frame(HoeffdingTree=model1.acc,
                 HoeffdingAdaptiveTree=model2.acc)
# Representamos ambas poblaciones en un boxplot
boxplot(df, col=c("orange", "purple"))

# Aplicamos los tests de Jarque Bera y Shapiro para comprobar si ambas 
# poblaciones siguen una distribución normal
# Hipótesis nula: los datos no siguen una distribución normal
# Con una confianza del 95%, si el p-value > 0.05 -> los datos son normales
jarque.bera.test(df$HoeffdingTree)
shapiro.test(df$HoeffdingTree)
jarque.bera.test(df$HoeffdingAdaptiveTree)
shapiro.test(df$HoeffdingAdaptiveTree)

# Test no paramétrico de Wilcoxon para comparar ambos clasificadores
wilcox.test(df$HoeffdingTree, df$HoeffdingAdaptiveTree)

# Media de la tasa de acierto para cada algoritmo
mean(df$HoeffdingTree)
mean(df$HoeffdingAdaptiveTree)