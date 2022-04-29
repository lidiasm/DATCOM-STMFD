# Librería que permite aplicar tests estadísticos para comparar modelos entrenados
# sobre series temporales
library(tseries)

# Función que itera sobre una carpeta proporcionada y carga los ficheros CSV
# resultantes de la ejecución de un script MOA con el objetivo de obtener la
# última tasa de acierto correspondiente al modelo completamente validado.
# Como cada enfoque tiene una estructura de ficheros diferente, le proporcionaremos
# el número de la columna donde se encuentra la tasa de aciertos.
load_moad_results <- function(folder, n_acc_col) {
  # Leemos los diferentes ficheros CSV con los resultados de las diferentes
  # iteraciones
  files <- list.files(path=folder, full.names=TRUE, recursive=FALSE)
  # Cargamos los datos como dataframes y accedemos al último valor de la columna
  # que contiene la tasa de aciertos
  accuracy <- lapply(files, function(x) {
    data <- read.csv(x, header=TRUE)
    return(data[nrow(data), n_acc_col])
  })
  # Convertimos la lista de valores accuracy a un vector numérico
  return(unlist(accuracy, use.names=FALSE))
}

# Leemos las métricas resultantes de ambos clasificadores. Para ello especificamos
# - El nombre de la carpeta donde se encuentran los resultados
# - El número de la columna que contiene las tasas de aciertos, empezando desde 1
model1.acc <- load_moad_results("ejercicio_2.1.1", 3) 
model2.acc <- load_moad_results("ejercicio_2.1.2", 3) 
# Creamos un dataframe para representar los resultados
df <- data.frame(HoeffdingTree=model1.acc,
                 HoeffdingAdaptiveTree=model2.acc)
# Almacenamos las tasas de aciertos finales en un fichero CSV para construir una
# tabla con las precisiones de los modelos de cada técnica
write.csv(df, "ejercicio_2.1.csv") 
# Representamos ambas poblaciones en un boxplot
boxplot(df, col=c("orange", "purple"))

# Aplicamos los tests de Jarque Bera y Shapiro para comprobar si ambas 
# poblaciones siguen una distribución normal
# Hipótesis nula: los datos siguen una distribución normal
# Con una confianza del 95%, si el p-value > 0.05 -> los datos no son normales
jarque.bera.test(df$HoeffdingTree)
shapiro.test(df$HoeffdingTree)
jarque.bera.test(df$HoeffdingAdaptiveTree)
shapiro.test(df$HoeffdingAdaptiveTree)

# Test paramétrico de Student para comparar ambos clasificadores
## Para el enfoque online
t.test(df$HoeffdingTree, df$HoeffdingAdaptiveTree)

# Test no paramétrico de Wilcoxon para comparar ambos clasificadores
## Para el enfoque offline
wilcox.test(df$HoeffdingTree, df$HoeffdingAdaptiveTree)

# Media de la tasa de acierto para cada algoritmo
mean(df$HoeffdingTree)
mean(df$HoeffdingAdaptiveTree)