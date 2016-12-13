setwd("/home/pedroig/R/VF")
data <-read.csv("Edu-Data.csv",header =T)

gera_Q3 <- function(vetor,nome){
  
  ###########Construcao da Tabela de Distribuicao de Frequencias###############
  jpeg(paste("/home/pedroig/R/Q3/",nome,"_distribuicao_freq.jpg",sep=""))
  h<-hist(vetor,main=paste("Tabela de distribuicao de \nfrequencias da variavel",nome),xlab = "Intervalos")
  dev.off()
  
  br<-h$breaks
  k<-length(br)-1
  f <-h$counts
  n <- sum(f)
  PM<-h$mids
  tam_intervalo<-br[2] - br[1]
  
  Intervalos<-0
  for(i in 1:(k)){
    Intervalos[i]<-paste(br[i],c("|-"),br[i+1], sep="")}
  
  dist<-cbind(Intervalos, PM, f)
  fr<-f/n
  F<-cumsum(f)
  Fra<-cumsum(fr)
  dist<-cbind(dist, F, fr, Fra)
  Total<-c("Total", NA, sum(f), NA, sum(fr), NA)
  dist<-rbind(dist, Total)
  rownames(dist)<-seq(1, k+1, 1)
  dist<-data.frame(dist)
  
  write.csv(dist, paste("/home/pedroig/R/Q3/",nome,".csv",sep=""))
  
  ####Grafico de frequencias acumuladas
  temp<-c(0,F)
  jpeg(paste("/home/pedroig/R/Q3/",nome,"_freq_acumuladas.jpg",sep=""))
  plot(br, temp, type="l", lty=2, main="Frequencias Acumuladas", xlab="Intervalos", ylab="Frequencias")
  points(br, temp, pch=16)
  dev.off()
  
  
  sink(paste("/home/pedroig/R/Q3/",nome,"_parametros.txt",sep=""))
  cat(paste("Parametros caculados para a variavel",nome,"\n\n"))
  
  ####Calcular Media, Mediana e Moda
  
  #Media
  x.bar<-weighted.mean(PM, f)
  cat("Media: ")
  cat(x.bar)
  cat("\n\n")
  
  #Mediana
  PMd<-n/2
  
  temp<-min(which(F>=PMd))
  Md<-br[temp]+((PMd-max(F[temp-1]))/f[temp])*tam_intervalo
  
  cat("Mediana: ")
  cat(Md)
  cat("\n\n")
  
  #Moda
  temp<-which(f==max(f))
  if(temp == 1 || temp == k){
    Mo<-PM[temp]
  }else{
    d1<-f[temp]-f[temp-1]
    d2<-f[temp]-f[temp+1]
    Mo<-br[temp]+(d1/(d1+d2))*tam_intervalo
  }
  
  cat("Moda: ")
  cat(Mo)
  cat("\n\n")
  
  #####Calcular a Variancia, Desvio padrao e o coeficiente de variacao
  
  ##Variancia
  
  Desvio = PM - x.bar
  Desvio2 = Desvio^2
  Desvio2f = Desvio2*f
  Var <- sum(Desvio2*f)/(n-1)
  
  cat("Variancia: ")
  cat(Var)
  cat("\n\n")
  
  ##Desvio padrao
  
  DP = sqrt(Var)
  
  cat("Desvio padrao: ")
  cat(DP)
  cat("\n\n")
  
  ##Coeficiente de Variacao
  
  CV = (DP/x.bar)*100
  cat("Coeficiente de variacao: ")
  cat(CV)
  cat("\n\n")
  
  ##Calculo de Q1 e Q3
  
  PQ1<-0.25*sum(f)
  
  temp<-which(F==min(F[which(F>=PQ1)]))
  Q1<-br[temp]+((PQ1-max(F[which(F<PQ1)]))/f[temp])*tam_intervalo
  
  PQ3<-0.75*sum(f)
  
  temp<-which(F==min(F[which(F>=PQ3)]))
  Q3<-br[temp]+((PQ3-max(F[which(F<PQ3)]))/f[temp])*tam_intervalo
  
  ##Calculo de P10 e P90
  
  PP10<-(0.10*sum(f))
  
  temp<-which(F==min(F[which(F>=PP10)]))
  
  fant=max(F[which(F<PP10)])
  if(fant==-Inf){fant=0}
  P10<-br[temp]+((PP10-fant)/f[temp])*tam_intervalo
  
  PP90<-(0.90*sum(f))
  
  temp<-which(F==min(F[which(F>=PP90)]))
  fant=max(F[which(F<PP90)])
  if(fant==-Inf){fant=0}
  P90<-br[temp]+((PP90-fant)/f[temp])*tam_intervalo
  
  ##Assimetria 
  
  Assimetria = (Q3 - 2*Md + Q1)/(Q3 - Q1)
  
  ClassAss <- function(x)
  {
    if( x > 0 )
      return ("Assimetria Positiva")
    if( x < 0 )
      return ("Assimetria Negativa")
    if( x == 0 )
      return ("Simetrica")
  }
  
  cat("Coeficiente de Assimetria: ")
  cat(Assimetria)
  cat("\n")
  cat("Classificacao ")
  cat(ClassAss(Assimetria))
  cat("\n\n")
  
  ##Curtose
  
  Curtose = (Q3 - Q1)/(2*(P90 - P10))
  
  ClassCur <- function(x)
  {
    if( x > 0.263 )
      return ("Distribuição Platicúrtica")
    if( x < 0.263 )
      return ("Distribuição leptocúrtica")
    if( x == 0.263 )
      return ("Distribuição mesocúrtica")
  }
  
  cat("Coeficiente de curtose: ")
  cat(Curtose)
  cat("\n")
  cat("Classificacao ")
  cat(ClassCur(Curtose))
  cat("\n\n")
  
  sink()
}

#####Executando codigo para as variaveis quantitativas
quantitativas<-c(10,11,12,13)
for (i in quantitativas) {
  vetor<-sapply(data[i],as.numeric)
  nome <- names(data)[i]
  gera_Q3(vetor,nome)
}