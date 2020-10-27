#Instalacion de paquetes
#install.packages("tidyr")
#install.packages("ggplot2")
#install.packages("plyr")
#install.packages("dplyr")
#install.packages("eeptools")
getwd()
rm(list = ls(all=TRUE))
#Library
library(tidyr)
#install.packages("tidyr")
library(ggplot2)
library(plyr)


library(dplyr)
library(rlang)
#install.packages("eeptools")
library(eeptools)

#Cargar base de CV-error
tbl_cv=read.csv(file = "/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/cv_admixture.csv", header = TRUE )

cbbpalette <- c("#e51919", "#0707c6")

CV_error <- ggplot(data=tbl_cv, aes(x=K, y=CV, group=VCF, colour=VCF)) + 
  geom_line(size=2) + geom_point(size=3) + scale_colour_manual(values = cbbpalette) +
  theme_bw() + ylab("Error de validación cruzada") + scale_x_continuous(breaks=seq(0, 8, 1)) +
  theme(axis.title.x = element_blank(), axis.title.y =element_text(size=18), 
        axis.text.x  = element_text(vjust=0.5, size=14, face = "bold")) +
  theme(text = element_text(size=15)) + expand_limits(y=c(0.3,0.5)) + 
  scale_y_continuous(breaks = seq(0.3, 0.5, 0.05)) +
  theme(plot.margin=unit(c(1.5,1.5,1.5,1.5),"cm"),text = element_text(size=20)) 
CV_error

CV_error + coord_cartesian(ylim =c( 0.35, 0.5)) + theme(panel.grid.minor = element_blank(),
                                                        panel.grid.major = element_blank())


#Cargar archivos Q

admix1.2=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_79/admixture/1.1/var.79.1.1.sorted.2.Q"))
admix1.3=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_79/admixture/1.1/var.79.1.1.sorted.3.Q"))

admix2.2=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_79/admixture/2.1/var.79.2.1.sorted.2.Q"))
admix2.3=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_79/admixture/2.1/var.79.2.1.sorted.3.Q"))

admix3.2=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_Stacks/admixture/3.1/var.79.3.1.2.Q"))
admix3.3=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_Stacks/admixture/3.1/var.79.3.1.3.Q"))

admix4.2=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_Stacks/admixture/4.1/var.79.4.1.2.Q"))
admix4.3=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_Stacks/admixture/4.1/var.79.4.1.3.Q"))


qmacd=read.csv("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/Qmacdougalli_79ind_stacks.csv")
head(qmacd)
tail(qmacd)

#Renombrar columnas archivos Q

admix1.2<-`colnames<-`(admix1.2, c("K2","K1"))
head(admix1.2)
admix1.3<-`colnames<-`(admix1.3, c("K2", "K3","K1"))
head(admix1.3)

admix2.2<-`colnames<-`(admix2.2, c("K2","K1"))
head(admix2.2)
admix2.3<-`colnames<-`(admix2.3, c("K2", "K3","K1"))
head(admix2.3)

admix3.2<-`colnames<-`(admix3.2, c("K2","K1"))
head(admix3.2)
admix3.3<-`colnames<-`(admix3.3, c("K1", "K2","K3"))
head(admix3.3)

admix4.2<-`colnames<-`(admix4.2, c("K2","K1"))
head(admix4.2)
admix4.3<-`colnames<-`(admix4.3, c("K1", "K2","K3"))
head(admix4.3)

#Cbind
admix1.2<- cbind(admix1.2,qmacd)
head(admix1.2)
admix1.3<- cbind(admix1.3,qmacd)
head(admix1.3)

admix2.2<- cbind(admix2.2,qmacd)
head(admix2.2)
admix2.3<- cbind(admix2.3,qmacd)
head(admix2.3)

admix3.2<- cbind(admix3.2,qmacd)
head(admix3.2)
admix3.3<- cbind(admix3.3,qmacd)
head(admix3.3)

admix4.2<- cbind(admix4.2,qmacd)
head(admix4.2)
admix4.3<- cbind(admix4.3,qmacd)
head(admix4.3)


#Sorted
#fadmix_3 <- fadmix_3[order(fadmix_3$NUM_IND),]

#Gather

admix1.2_gather<- gather (admix1.2, key= K, value=admixture, K1:K2)
tail(admix1.2_gather)
admix1.3_gather<- gather (admix1.3, key= K, value=admixture, K2:K1)
tail(admix1.3_gather)

admix2.2_gather<- gather (admix2.2, key= K, value=admixture, K1:K2)
tail(admix2.2_gather)
admix2.3_gather<- gather (admix2.3, key= K, value=admixture, K2:K1)
tail(admix2.3_gather)

admix3.2_gather<- gather (admix3.2, key= K, value=admixture, K1:K2)
tail(admix3.2_gather)
admix3.3_gather<- gather (admix3.3, key= K, value=admixture, K1:K3)
tail(admix3.3_gather)

admix4.2_gather<- gather (admix4.2, key= K, value=admixture, K1:K2)
tail(admix4.2_gather)
admix4.3_gather<- gather (admix4.3, key= K, value=admixture, K1:K3)
tail(admix4.3_gather)

#Plot

plot_admix2.2 <- ggplot(data=admix2.2_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + scale_fill_manual("K", values = c("K2" = "#40B95B", "K1" = "#E07E34")) + 
  ylab("Coeficiente de pertenencia")+ xlab("Individuos")+ theme_bw() +
  theme(axis.title.x = element_blank(), 
        axis.title.y =element_text(size=18),
        axis.text.x  = element_blank()) +
  theme(legend.title= element_blank(),text = element_text(size=20))+
  geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + 
  geom_vline(aes(xintercept=69.5))
plot_admix2.2 


plot_admix2.3 <- ggplot(data=admix2.3_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + scale_fill_manual("K", values = c("K1" = "#00B1E8", "K3" = "#E07E34", "K2" = "#40B95B")) + 
  ylab("Coeficiente de pertenencia")+ xlab("Individuos")+ theme_bw() +
  theme(axis.title.x = element_blank(), 
        axis.title.y =element_text(size=18),
        axis.text.x  = element_blank()) +
  theme(legend.title= element_blank(),text = element_text(size=20))+
  geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + 
  geom_vline(aes(xintercept=69.5))
plot_admix1.3
plot_admix2.3
plot_admix3.3
plot_admix4.3

#"#1B9E77" "#D95F02" "#7570B3" "#E7298A" "#66A61E" "#E6AB02" "#A6761D" "#666666"
#VERDE     NARANJA   MORADO    ROSA       VERDE V   AMARILLO   MARRON   GRIS

# PLOT ALTITUD
(aes(colour = factor(cyl)))

plot_pop_alt_3<- ggplot(data=admix4.3_gather, aes(x=NUM_IND, y=ALT)) + 
  geom_line(stat="identity", color="#00cb5f") + geom_point(aes(colour=SITIO, size=ALT, alpha=1/20)) +
  scale_colour_manual("SITIO", values = c( "SITIO1" = "#7570B3", "SITIO2" = "#075277", "SITIO3" = "#00B1E8","SITIO4" = "#1FC944","SITIO5" = "#E6AB02", "SITIO6" = "#E7298A","SITIO7" = "#E07E34", "SITIO8" = "#F15858")) +
  ylab("Altitud msnm")+ xlab("Individuos")+ theme_bw() +
  theme(axis.title.x = element_blank(), axis.text.y = element_text(size=12),
        axis.title.y =element_text(size=18),
        axis.text.x  = element_blank()) +
  scale_x_continuous(breaks=seq(1, 79, 1)) +
  geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + 
  geom_vline(aes(xintercept=69.5))
plot_pop_alt_3



###### FAST STRUCTURE

fast_1.2_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_79/faststructure/1.1/var.79.1.1.logistic.2.meanQ"))
fast_1.3_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_79/faststructure/1.1/var.79.1.1.logistic.3.meanQ"))

fast_2.2_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_79/faststructure/2.1/var.79.2.1.logistic.2.meanQ"))
fast_2.3_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_79/faststructure/2.1/var.79.2.1.logistic.3.meanQ"))


###
#fast_3.2_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_Stacks/faststructure/3.1/var.79.3.1.simple.2.meanQ"))
#fast_3.3_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_Stacks/faststructure/3.1/var.79.3.1.simple.3.meanQ"))

#fast_4.2_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_Stacks/faststructure/4.1/var.79.4.1.simple.2.meanQ"))
#fast_4.3_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/CGUM_Stacks/faststructure/4.1/var.79.4.1.simple.3.meanQ"))


head(qmacd)

head(fast_1.2_simple)
head(fast_1.3_simple)

#Colnames

fast_1.2_simple<-`colnames<-`(fast_1.2_simple, c("K2","K1"))
head(fast_1.2_simple)
fast_1.3_simple<-`colnames<-`(fast_1.3_simple, c("K3", "K2","K1"))
head(fast_1.3_simple)

fast_2.2_simple<-`colnames<-`(fast_2.2_simple, c("K2","K1"))
head(fast_2.2_simple)
fast_2.3_simple<-`colnames<-`(fast_2.3_simple, c("K2", "K3","K1"))
head(fast_2.3_simple)

fast_3.2_simple<-`colnames<-`(fast_3.2_simple, c("K2","K1"))
head(fast_3.2_simple)
fast_3.3_simple<-`colnames<-`(fast_3.3_simple, c("K3", "K2","K1"))
head(fast_3.3_simple)

fast_4.2_simple<-`colnames<-`(fast_4.2_simple, c("K2","K1"))
head(fast_4.2_simple)
fast_4.3_simple<-`colnames<-`(fast_4.3_simple, c("K1", "K2","K3"))
head(fast_4.3_simple)

#Cbind
fast_1.2_simple<- cbind(fast_1.2_simple,qmacd)
head(fast_1.2_simple)
fast_1.3_simple<- cbind(fast_1.3_simple,qmacd)
head(fast_1.3_simple)

fast_2.2_simple<- cbind(fast_2.2_simple,qmacd)
head(fast_2.2_simple)
fast_2.3_simple<- cbind(fast_2.3_simple,qmacd)
head(fast_2.3_simple)

fast_3.2_simple<- cbind(fast_3.2_simple,qmacd)
head(fast_3.2_simple)
fast_3.3_simple<- cbind(fast_3.3_simple,qmacd)
head(fast_3.3_simple)

fast_4.2_simple<- cbind(fast_4.2_simple,qmacd)
head(fast_4.2_simple)
fast_4.3_simple<- cbind(fast_4.3_simple,qmacd)
head(fast_4.3_simple)


#Gather

fast_1.2_simple_gather<- gather (fast_1.2_simple, key= K, value=admixture, K2:K1)
tail(fast_1.2_simple_gather)
fast_1.3_simple_gather<- gather (fast_1.3_simple, key= K, value=admixture, K3:K1)
tail(fast_1.3_simple_gather)


fast_2.2_simple_gather<- gather (fast_2.2_simple, key= K, value=admixture, K2:K1)
tail(fast_2.2_simple_gather)
fast_2.3_simple_gather<- gather (fast_2.3_simple, key= K, value=admixture, K2:K1)
tail(fast_2.3_simple_gather)

fast_3.2_simple_gather<- gather (fast_3.2_simple, key= K, value=admixture, K2:K1)
tail(fast_3.2_simple_gather)
fast_3.3_simple_gather<- gather (fast_3.3_simple, key= K, value=admixture, K3:K1)
tail(fast_3.3_simple_gather)

fast_4.2_simple_gather<- gather (fast_4.2_simple, key= K, value=admixture, K2:K1)
tail(fast_4.2_simple_gather)
fast_4.3_simple_gather<- gather (fast_4.3_simple, key= K, value=admixture, K1:K3)
tail(fast_4.3_simple_gather)

#Plot

plot_fast_2.2 <- ggplot(data=fast_2.2_simple_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + scale_fill_manual("K", values = c("K2" ="#E07E34" , "K1" = "#40B95B")) + 
  ylab("Coeficiente de pertenencia")+ xlab("Individuos")+ theme_bw() +
  theme(axis.title.x = element_blank(), 
        axis.title.y =element_text(size=18),
        axis.text.x  = element_blank()) +
  theme(legend.title= element_blank(),text = element_text(size=20))+
  geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + 
  geom_vline(aes(xintercept=69.5))
plot_fast_1.2 
plot_fast_2.2 
plot_fast_3.2 
plot_fast_4.2 

plot_fast_1.3 <- ggplot(data=fast_1.3_simple_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + scale_fill_manual("K", values = c("K1" = "#00B1E8", "K2" = "#E07E34", "K3" = "#40B95B")) + 
  ylab("Coeficiente de pertenencia")+ xlab("Individuos")+ theme_bw() +
  theme(axis.title.x = element_blank(), 
        axis.title.y =element_text(size=18),
        axis.text.x  = element_blank()) +
  theme(legend.title= element_blank(),text = element_text(size=20))+
  geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + 
  geom_vline(aes(xintercept=69.5))

plot_fast_1.3
plot_fast_2.3
plot_fast_3.3
plot_fast_4.3


#Cloroplasto-FastStructure Simple

fast_5.2_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/Chloroplast_Stacks/faststructure/var.79.5.1.simple.2.meanQ"))
fast_5.3_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/Chloroplast_Stacks/faststructure/var.79.5.1.simple.3.meanQ"))

fast_5.6_simple=read.table(paste0("/media/nel_pc/n311_pc/Campos_Project_003_Analysis/data_metadata_5/Chloroplast_Stacks/faststructure/var.79.5.1.simple.6.meanQ"))

fast_5.2_simple<-`colnames<-`(fast_5.2_simple, c("K2","K1"))
head(fast_5.2_simple)
fast_5.3_simple<-`colnames<-`(fast_5.3_simple, c("K3" ,"K2","K1"))
head(fast_5.3_simple)
fast_5.6_simple<-`colnames<-`(fast_5.6_simple, c("K1", "K2","K3","K4", "K5","K6"))
head(fast_5.6_simple)

#Cbind
fast_5.2_simple<- cbind(fast_5.2_simple,qmacd)
head(fast_5.2_simple)
fast_5.3_simple<- cbind(fast_5.3_simple,qmacd)
head(fast_5.3_simple)
fast_5.6_simple<- cbind(fast_5.6_simple,qmacd)
head(fast_5.6_simple)

#Gather

fast_5.2_simple_gather<- gather (fast_5.2_simple, key= K, value=admixture, K2:K1)
tail(fast_5.2_simple_gather)
fast_5.3_simple_gather<- gather (fast_5.3_simple, key= K, value=admixture, K3:K1)
tail(fast_5.3_simple_gather)
fast_5.6_simple_gather<- gather (fast_5.6_simple, key= K, value=admixture, K1:K6)
tail(fast_5.6_simple_gather)

#Plot

plot_fast_5.2 <- ggplot(data=fast_5.2_simple_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + scale_fill_manual("K", values = c("K1" ="#E07E34" , "K2" = "#40B95B")) + 
  ylab("Coeficiente de pertenencia")+ xlab("Individuos")+ theme_bw() +
  theme(axis.title.x = element_blank(), 
        axis.title.y =element_text(size=18),
        axis.text.x  = element_blank()) +
  theme(legend.title= element_blank(),text = element_text(size=20))+
  geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + 
  geom_vline(aes(xintercept=69.5))
plot_fast_5.2 

plot_fast_5.3 <- ggplot(data=fast_5.3_simple_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + scale_fill_manual("K", values = c("K1" = "#00B1E8", "K2" = "#E07E34", "K3" = "#40B95B")) + 
  ylab("Coeficiente de pertenencia")+ xlab("Individuos")+ theme_bw() +
  theme(axis.title.x = element_blank(), 
        axis.title.y =element_text(size=18),
        axis.text.x  = element_blank()) +
  theme(legend.title= element_blank(),text = element_text(size=20))+
  geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + 
  geom_vline(aes(xintercept=69.5))
plot_fast_5.3


plot_fast_5.6 <- ggplot(data=fast_5.6_simple_gather, aes(x=NUM_IND, y=admixture, fill=K)) + 
  geom_bar(stat="identity") + scale_fill_manual("K", values = c("K6" = "#00B1E8", "K5" = "#E07E34", "K1" = "#40B95B", "K4"="#E7298A", "K2"= "#7570B3", "K3"= "#E6AB02")) + 
  ylab("Coeficiente de pertenencia")+ xlab("Individuos")+ theme_bw() +
  theme(axis.title.x = element_blank(), 
        axis.title.y =element_text(size=18),
        axis.text.x  = element_blank()) +
  theme(legend.title= element_blank(),text = element_text(size=20))+
  geom_vline(aes(xintercept=15.5)) + geom_vline(aes(xintercept=25.5)) + geom_vline(aes(xintercept=29.5)) + 
  geom_vline(aes(xintercept=39.5)) + geom_vline(aes(xintercept=49.5)) + geom_vline(aes(xintercept=59.5)) + 
  geom_vline(aes(xintercept=69.5))
plot_fast_5.6

#"SITIO1" = "#7570B3", "SITIO2" = "#075277", "SITIO3" = "#00B1E8","SITIO4" = "#1FC944","SITIO5" = "#E6AB02", "SITIO6" = "#E7298A","SITIO7" = "#E07E34", "SITIO8" = "#F15858"