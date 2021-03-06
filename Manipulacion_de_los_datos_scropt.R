library(dplyr)
library(stringr)
library(tidyr)

install.packages("tidyr")
install.packages("stringr")
#DATOS

getwd()
setwd("E:/ProyectoArgenitna/Tablas_rescate_denuncias_csv")

llamadas_denuncias_uno <-read.csv("1_Llamadas_denuncia.csv")
llamadas_denuncia_referidos_dos<-read.csv("2_Llamadas_denuncia_referidos.csv")
View(llamadas_denuncia_referidos_dos)
str(llamadas_denuncias_uno)

#Tablas de datos crudos tablas una
setwd("E:/ProyectoArgenitna/Datos_Crudos")
#Datos

llaamdas_denuncias_referidos_crudo <- read.csv("oficina-rescate-denuncias-referidos-202001-202112_data_cruda.csv")
View(llamadas_denuncias_referidos_crudo)

llamadas_denuncias_crudo <- read.csv("rescate-denuncias-202001-202112_data_cruda.csv")
View(llamadas_denuncias_crudo)

#################################
fechas_cruda <- data.frame(as.Date(llamadas_denuncias_crudo$�..fecha_ingreso))
names(fechas_cruda)[1]<- "Fecha_de_ingreso"
llamadas_denuncias_uno <- cbind(fechas_cruda, llamadas_denuncias_uno)

#Eliminar columana incorrecta

llamadas_denuncias_uno <- llamadas_denuncias_uno[,-2]

View(llamadas_denuncias_uno)
write.csv(llamadas_denuncias_uno,"llamadas_denuncias_uno_corregidas.csv")
#######################################

derivacion_fechas_cruda <-data.frame(llamadas_denuncias_uno$derivacion_fecha)
derivacion_fechas_cruda<- as.POSIXct(derivacion_fechas_cruda$llamadas_denuncias_uno.derivacion_fecha,
                                     format = "%m/%d/%Y %H:%M")
derivacion_fechas_cruda<- as.data.frame(derivacion_fechas_cruda)
llamadas_denuncias_uno <- llamadas_denuncias_uno[,-12]
names(derivacion_fechas_cruda)[1]<- "Derivacion_fechas"
llamadas_denuncias_uno <- cbind(llamadas_denuncias_uno,derivacion_fechas_cruda)

str(llamadas_denuncias_uno)

################################
fechas_referidos_crudo <- data.frame(as.Date(llaamdas_denuncias_referidos_crudo$fecha_ingreso_denuncia))
View(fechas_referidos_crudo)
str(fechas_referidos_crudo)

names(fechas_referidos_crudo)[1]<- "Fecha_de_ingreso_denuncia"

llamadas_denuncia_referidos_dos<-llamadas_denuncia_referidos_dos[,-2]

llamadas_denuncia_referidos_dos<- cbind(fechas_referidos_crudo, llamadas_denuncia_referidos_dos)
View(llamadas_denuncia_referidos_dos)
str(llamadas_denuncia_referidos_dos)

write.csv(llamadas_denuncia_referidos_dos,"llamadas_denuncias_referidos_dos_corregidas.csv")









##############################################################
#Manipulacion dela columna derivacion fecha

(date_fecha <- data.frame(llamadas_denuncias_uno$derivacion_fecha))
View(date_fecha)

###fh2=data.frame(as.POSIXct(date_fecha$llamadas_denuncias_uno.derivacion_fecha,format="%d/%m/%Y %H:%M"))
#View(fh2)
#la nueva tabla se separa para sacar la fecha
date_fecha <- str_split_fixed(date_fecha$llamadas_denuncias_uno.derivacion_fecha, " ", 2)
date_fecha<- data.frame(date_fecha)
names(date_fecha)<-NULL
names(date_fecha)[1]<-"Fecha_derivacion"
names(date_fecha)[2]<-"Hora_derivacion"

View(date_fecha)

#########################################


#########################################

##########################################

setwd("E:/Coder_house/ProyectoArgenitna")
coordenadas_argentina <- data.frame(read.csv("coordenadas_argentina.csv", F))
coordenadas_argentina <- separate(coordenadas_argentina,coordenadas_argentina$V2,
                                  c("coordenada_uno","coordenada_dos"), sep=", ")
coordenadas_argentina <- coordenadas_argentina %>% separate(V2,c("coordendad-uno"
                                                                 ,"coordenada_dos"),
                                                            sep=", ")
names(coordenadas_argentina)[1]="Provincia"
names(coordenadas_argentina)[2]="Latitud"
names(coordenadas_argentina)[3]="Longitud"
str(coordenadas_argentina)

coordenadas_argentina[2] <- as.numeric(coordenadas_argentina$Latitud)
coordenadas_argentina[3] <- as.numeric(coordenadas_argentina$Longitud)
coordenadas_argentina

write.csv(coordenadas_argentina, "provincias_ar.csv",row.names = F )
wri
