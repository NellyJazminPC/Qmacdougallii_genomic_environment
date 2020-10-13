#Instalacion de paquetes
#install.packages("tidyr")
#install.packages("ggplot2")
#install.packages("plyr")
#install.packages("dplyr")
#install.packages("eeptools")
rm(list = ls(all=TRUE))
#Library
library(tidyr)
library(ggplot2)
library(plyr)
library(dplyr)
library(rlang)
library(eeptools)

fadmix_3=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/vcftools_filtrados/genetic_structure/admixture/var_filt_79/var.f79.3.Q"))

fcadmix_3=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/vcftools_filtrados/genetic_structure/admixture/var_filt_79/var.fc.79.3.Q"))

qmacd=read.csv("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/Qmacdougalli_79ind.csv")
head(qmacd)

head(fadmix_3)
head(fcadmix_3)

fadmix_3<-`colnames<-`(fadmix_3, c("K3", "K2","K1"))
head(fadmix_3)

fcadmix_3<-`colnames<-`(fcadmix_3, c("K3", "K2", "K1"))
head(fcadmix_3)

#
fadmix_3<- cbind(fadmix_3,qmacd)
head(fadmix_3)

fcadmix_3 <- cbind(fcadmix_3,qmacd)
head(fcadmix_3)

#Sorted

fadmix_3 <- fadmix_3[order(fadmix_3$NUM_IND),]
head(fadmix_3)

fcadmix_3 <- fcadmix_3[order(fcadmix_3$NUM_IND),]
head(fcadmix_3)

#Gather

fadmix_3_gather<- gather (fadmix_3, key= K, value=admixture, K1:K3)
tail(fadmix_3_gather)

fcadmix_3_gather<- gather (fcadmix_3, key= K, value=admixture, K1:K3)
tail(fcadmix_3_gather)



plot_fadmix_3 <- ggplot(data=fadmix_3_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + ylab("ADMIXTURE")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(0, 79, 1))+
  theme(legend.title= element_blank(),text = element_text(size=20))+
  ggtitle("Estructura genética f79")  + geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + geom_vline(aes(xintercept=69.5))
plot_fadmix_3

plot_fcadmix_3 <- ggplot(data=fcadmix_3_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + ylab("ADMIXTURE")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(0, 79, 1))+
  theme(legend.title= element_blank(),text = element_text(size=20))+
  ggtitle("Estructura genética fc79")  + geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + geom_vline(aes(xintercept=69.5))
plot_fcadmix_3



fadmix_2=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/vcftools_filtrados/genetic_structure/admixture/var_filt_79/var.f79.2.Q"))

fcadmix_2=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/vcftools_filtrados/genetic_structure/admixture/var_filt_79/var.fc.79.2.Q"))

head(fadmix_2)
head(fcadmix_2)

fadmix_2<-`colnames<-`(fadmix_2, c("K1", "K2"))
head(fadmix_2)

fcadmix_2<-`colnames<-`(fcadmix_2, c("K1", "K2"))
head(fcadmix_2)

fadmix_2<- cbind(fadmix_2,qmacd)
head(fadmix_3)

fcadmix_2 <- cbind(fcadmix_2,qmacd)
head(fcadmix_3)

#Sorted

fadmix_2 <- fadmix_2[order(fadmix_2$NUM_IND),]
head(fadmix_2)

fcadmix_2 <- fcadmix_2[order(fcadmix_2$NUM_IND),]
head(fcadmix_2)

#Gather

fadmix_2_gather<- gather (fadmix_2, key= K, value=admixture, K1:K2)
tail(fadmix_2_gather)

fcadmix_2_gather<- gather (fcadmix_2, key= K, value=admixture, K1:K2)
tail(fcadmix_2_gather)



plot_fadmix_2 <- ggplot(data=fadmix_2_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + ylab("ADMIXTURE")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(0, 80, 1))+
  theme(legend.title= element_blank(),text = element_text(size=20))+
  ggtitle("Estructura genética f79") + geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + geom_vline(aes(xintercept=69.5))
plot_fadmix_2

plot_fcadmix_2 <- ggplot(data=fcadmix_2_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + ylab("ADMIXTURE")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(0, 80, 1))+
  theme(legend.title= element_blank(),text = element_text(size=20))+
  ggtitle("Estructura genética fc79") + geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + geom_vline(aes(xintercept=69.5))
plot_fcadmix_2

# PLOT ALTITUD

plot_pop_alt_3<-ggplot(data=fcadmix_2_gather, aes(x=NUM_IND, y=ALT)) + 
  geom_line(stat="identity", color="#00cb5f") + ylab("Altitud msnm")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(1, 79, 1))
plot_pop_alt_3


###### FAST STRUCTURE

ffast_st_3_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/vcftools_filtrados/genetic_structure/fast_structure/fast_structure_79/var.f79.simple.3.meanQ"))

ffast_st_3_logist=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/vcftools_filtrados/genetic_structure/fast_structure/fast_structure_79/var.f79.logistic.3.meanQ"))

qmacd=read.csv("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/Qmacdougalli_79ind.csv")

head(qmacd)
head(ffast_st_3_simple)
head(ffast_st_3_logist)

#Colnames
ffast_st_3_simple<-`colnames<-`(ffast_st_3_simple, c("K3", "K2","K1"))
head(ffast_st_3_simple)

ffast_st_3_logist<-`colnames<-`(ffast_st_3_logist, c("K3", "K2", "K1"))
head(ffast_st_3_logist)

# Cbind
ffast_st_3_simple<- cbind(ffast_st_3_simple,qmacd)
head(ffast_st_3_simple)

ffast_st_3_logist <- cbind(ffast_st_3_logist,qmacd)
head(ffast_st_3_logist)

#Sorted

ffast_st_3_simple <- ffast_st_3_simple[order(ffast_st_3_simple$NUM_IND),]
head(ffast_st_3_simple)

ffast_st_3_logist <- ffast_st_3_logist[order(ffast_st_3_logist$NUM_IND),]
head(ffast_st_3_logist)

#Gather

ffast_simple_3_gather<- gather (ffast_st_3_simple, key= K, value=admixture, K1:K3)
tail(ffast_simple_3_gather)

ffast_logist_3_gather<- gather (ffast_st_3_logist, key= K, value=admixture, K1:K3)
tail(ffast_logist_3_gather)



plot_ffast_simple_3 <- ggplot(data=ffast_simple_3_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + ylab("ADMIXTURE")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(0, 80, 1))+
  theme(legend.title= element_blank(),text = element_text(size=20))+
  ggtitle("Estructura genética f79 simple")  + geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + geom_vline(aes(xintercept=69.5))
plot_ffast_simple_3

plot_ffast_logist_3 <- ggplot(data=ffast_logist_3_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + ylab("ADMIXTURE")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(0, 80, 1))+
  theme(legend.title= element_blank(),text = element_text(size=20))+
  ggtitle("Estructura genética f79 logistic")  + geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + geom_vline(aes(xintercept=69.5))
plot_ffast_logist_3



fcfast_st_3_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/vcftools_filtrados/genetic_structure/fast_structure/fast_structure_79/var.fc.79.simple.3.meanQ"))

fcfast_st_3_logist=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/vcftools_filtrados/genetic_structure/fast_structure/fast_structure_79/var.fc.79.logistic.3.meanQ"))

head(fcfast_st_3_simple)
head(fcfast_st_3_logist)

fcfast_st_3_simple<-`colnames<-`(fcfast_st_3_simple, c("K3", "K2","K1"))
head(fcfast_st_3_simple)

fcfast_st_3_logist<-`colnames<-`(fcfast_st_3_logist, c("K3", "K2", "K1"))
head(fcfast_st_3_logist)

# Cbind
fcfast_st_3_simple<- cbind(fcfast_st_3_simple,qmacd)
head(fcfast_st_3_simple)

fcfast_st_3_logist <- cbind(fcfast_st_3_logist,qmacd)
head(fcfast_st_3_logist)

#Sorted

fcfast_st_3_simple <- fcfast_st_3_simple[order(fcfast_st_3_simple$NUM_IND),]
head(fcfast_st_3_simple)

fcfast_st_3_logist <- fcfast_st_3_logist[order(fcfast_st_3_logist$NUM_IND),]
head(fcfast_st_3_logist)

#Gather

fcfast_simple_3_gather<- gather (fcfast_st_3_simple, key= K, value=admixture, K1:K3)
tail(fcfast_simple_3_gather)

fcfast_logist_3_gather<- gather (fcfast_st_3_logist, key= K, value=admixture, K1:K3)
tail(fcfast_logist_3_gather)


plot_fcfast_simple_3 <- ggplot(data=fcfast_simple_3_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + ylab("ADMIXTURE")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(0, 80, 1))+
  theme(legend.title= element_blank(),text = element_text(size=20))+
  ggtitle("Estructura genética fc79 simple")  + geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + geom_vline(aes(xintercept=69.5))
plot_fcfast_simple_3

plot_fcfast_logist_3 <- ggplot(data=fcfast_logist_3_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + ylab("ADMIXTURE")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(0, 80, 1))+
  theme(legend.title= element_blank(),text = element_text(size=20))+
  ggtitle("Estructura genética fc79 logistic")  + geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + geom_vline(aes(xintercept=69.5))
plot_fcfast_logist_3

## K=2

ffast_st_2_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/vcftools_filtrados/genetic_structure/fast_structure/fast_structure_79/var.f79.simple.2.meanQ"))

ffast_st_2_logist=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/vcftools_filtrados/genetic_structure/fast_structure/fast_structure_79/var.f79.logistic.2.meanQ"))

head(ffast_st_2_simple)
head(ffast_st_2_logist)

ffast_st_2_simple<-`colnames<-`(ffast_st_2_simple, c("K1", "K2"))
head(ffast_st_2_simple)

ffast_st_2_logist<-`colnames<-`(ffast_st_2_logist, c("K1", "K2"))
head(ffast_st_2_logist)

#Cbind

ffast_st_2_simple<- cbind(ffast_st_2_simple,qmacd)
head(ffast_st_2_simple)

ffast_st_2_logist <- cbind(ffast_st_2_logist,qmacd)
head(ffast_st_2_logist)

#Sorted

ffast_st_2_simple <- ffast_st_2_simple[order(ffast_st_2_simple$NUM_IND),]
head(ffast_st_2_simple)

ffast_st_2_logist <- ffast_st_2_logist[order(ffast_st_2_logist$NUM_IND),]
head(ffast_st_2_logist)

#Gather

ffast_simple_2_gather<- gather (ffast_st_2_simple, key= K, value=admixture, K1:K2)
tail(ffast_simple_2_gather)


ffast_logist_2_gather<- gather (ffast_st_2_logist, key= K, value=admixture, K1:K2)
tail(ffast_logist_2_gather)


plot_ffast_simple_2 <- ggplot(data=ffast_simple_2_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + ylab("ADMIXTURE")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(0, 80, 1))+
  theme(legend.title= element_blank(),text = element_text(size=20))+
  ggtitle("Estructura genética f79 simple")  + geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + geom_vline(aes(xintercept=69.5))


plot_ffast_simple_2

plot_ffast_logist_2 <- ggplot(data=ffast_logist_2_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + ylab("ADMIXTURE")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(0, 80, 1))+
  theme(legend.title= element_blank(),text = element_text(size=20))+
  ggtitle("Estructura genética f79 logistic")  + geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + geom_vline(aes(xintercept=69.5))


plot_ffast_logist_2




fcfast_st_2_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/vcftools_filtrados/genetic_structure/fast_structure/fast_structure_79/var.fc.79.simple.2.meanQ"))

fcfast_st_2_logist=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/vcftools_filtrados/genetic_structure/fast_structure/fast_structure_79/var.fc.79.logistic.2.meanQ"))

head(fcfast_st_2_simple)
head(fcfast_st_2_logist)

fcfast_st_2_simple<-`colnames<-`(fcfast_st_2_simple, c("K1", "K2"))
head(fcfast_st_2_simple)

fcfast_st_2_logist<-`colnames<-`(fcfast_st_2_logist, c("K1", "K2"))
head(fcfast_st_2_logist)

# Cbind
fcfast_st_2_simple<- cbind(fcfast_st_2_simple,qmacd)
head(fcfast_st_2_simple)

fcfast_st_2_logist <- cbind(fcfast_st_2_logist,qmacd)
head(fcfast_st_2_logist)

#Sorted

fcfast_st_2_simple <- fcfast_st_2_simple[order(fcfast_st_2_simple$NUM_IND),]
head(fcfast_st_2_simple)

fcfast_st_2_logist <- fcfast_st_2_logist[order(fcfast_st_2_logist$NUM_IND),]
head(fcfast_st_2_logist)

#Gather

fcfast_simple_2_gather<- gather (fcfast_st_2_simple, key= K, value=admixture, K1:K2)
tail(fcfast_simple_2_gather)

fcfast_logist_2_gather<- gather (fcfast_st_2_logist, key= K, value=admixture, K1:K2)
tail(fcfast_logist_2_gather)


plot_fcfast_simple_2 <- ggplot(data=fcfast_simple_2_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + ylab("ADMIXTURE")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(0, 80, 1))+
  theme(legend.title= element_blank(),text = element_text(size=20))+
  ggtitle("Estructura genética fc79 simple")  + geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + geom_vline(aes(xintercept=69.5))
plot_fcfast_simple_2


plot_fcfast_logist_2 <- ggplot(data=fcfast_logist_2_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + ylab("ADMIXTURE")+ xlab("Individuos")+
  theme(axis.title.x = element_text(face="bold", size=14), 
        axis.title.y =element_text(face="bold", size=18),
        axis.text.x  = element_text(vjust=0.5, size=8, face = "bold")) +
  scale_x_continuous(breaks=seq(0, 80, 1))+
  theme(legend.title= element_blank(),text = element_text(size=20))+
  ggtitle("Estructura genética fc79 logistic")  + geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + geom_vline(aes(xintercept=69.5))
plot_fcfast_logist_2