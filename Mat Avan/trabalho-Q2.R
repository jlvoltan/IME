setwd("/home/pedroig/R/VF")

data <-read.csv("Edu-Data.csv",header =TRUE)

##############Tabela dados qualitativos(categoricos)#################
gera_tabela <- function(vetor,nome){
  tab<-table(vetor)
  f<-tab
  F<-cumsum(f)    # soma acumulada
  fr<-f/sum(f)    # proporcao
  Fra<-cumsum(fr) # proporcao acumulada
  
  dist<-cbind(f, F, fr, Fra)
  Total<-c(sum(f), NA, sum(fr), NA)
  dist<-rbind(dist, Total)
  
  write.csv(dist, paste("/home/pedroig/R/Q2/",nome,".csv",sep=""))
}

##Criar graficos de colunas (barras) para as frequencias absolutas de cada tabela e o 
##gráfico de setores para as frequencias relativas, de cada tabela

#Grafico de Barras
gera_grafico_barras <- function(vetor, nome){
  tab<-table(vetor)
  f<-tab
  jpeg(paste("/home/pedroig/R/Q2/",nome,"_barras.jpg",sep=""))
  barplot(f,main=paste("Grafico de Barras para frequencias \nabsolutas da variavel",nome), ylab= "Frequencia") 
  dev.off()
}

#Grafico de setores
gera_grafico_setores <- function(vetor, nome){
  tab<-table(vetor)
  f<-tab
  fr<-f/sum(f)    # proporcao
  rotulos = paste(names(f) ," (", 100*round(fr,3),"%)", sep="")
  
  jpeg(paste("/home/pedroig/R/Q2/",nome,"_setores.jpg",sep=""))
  pie(fr, labels = rotulos ,main=paste("Grafico de setores para frequencias \n relativas da variavel",nome))
  dev.off()
}

#####Executando funcoes para as variaveis qualitativas
qualitativas<-c(1,2,3,4,5,6,7,8,9,14,15,16)
for (i in qualitativas) {
  vetor<-data[i]
  nome <- names(data)[i]
  gera_tabela(vetor,nome)
  gera_grafico_barras(vetor,nome)
  gera_grafico_setores(vetor,nome)
}