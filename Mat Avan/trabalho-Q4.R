setwd("/home/pedroig/R/VF")

data <-read.csv("Edu-Data.csv",header =TRUE)

##Tabela de dupla entrada

tab<-table(data$gender, data$NationalITy)
write.csv(tab, "/home/pedroig/R/Q4/tabela_dupla_entrada.csv")

##Grafico de Barras Duplas

jpeg("/home/pedroig/R/Q4/Grafico_barras_duplas.jpg")
barplot(tab, beside=T, legend = T)
barplot(tab, beside=T, col=c("pink", "blue"), main="Grafico de Barras Duplas")
legend("top", legend=c("Feminino", "Masculino"), fill=c("pink", "blue"))
dev.off()

##Barras Empilhadas

jpeg("/home/pedroig/R/Q4/Grafico_barras_empilhadas.jpg")
barplot(tab)
barplot(tab, legend = T)
barplot(tab, legend = T, col=c("pink", "blue"), main="Grafico de Barras Empilhadas")
dev.off()

##Barras complementares

p.tab<-prop.table(tab,2)

jpeg("/home/pedroig/R/Q4/Grafico_barras_complementares.jpg")
barplot(p.tab)
barplot(p.tab, legend = T)
barplot(p.tab, legend = T,col=c("pink", "blue"), main="Grafico de Barras Complementares")
dev.off()