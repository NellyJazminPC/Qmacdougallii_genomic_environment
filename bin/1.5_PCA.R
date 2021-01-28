##### Principal component analysis ####

cgum_79_1.pca <- glPca(snps_genlight_sites, nf=80)

#Get the values for the first four principal components
sum(100*cgum_79_1.pca$eig/sum(cgum_79_1.pca$eig))
(cgum_79_1.pca$eig[1]/sum(cgum_79_1.pca$eig))*100
(cgum_79_1.pca$eig[2]/sum(cgum_79_1.pca$eig))*100
(cgum_79_1.pca$eig[3]/sum(cgum_79_1.pca$eig))*100
(cgum_79_1.pca$eig[4]/sum(cgum_79_1.pca$eig))*100

#Readjust margins for plots
par("mar")
par(mar=c(4,4,4,4))
#Barplot of eigenvalues
barplot(100*cgum_79_1.pca$eig/sum(cgum_79_1.pca$eig), main="PCA Eigenvalores")
title(ylab="Porcentaje de la varianza/explicada", line = 2)
title(xlab="Eigenvalores", line = 1)


#Scores
cgum_79_1.pca.scores <- as.data.frame(cgum_79_1.pca$scores)
cgum_79_1.pca.scores$pop <- pop(snps_genlight_sites)

#PCA plot
cols <- c("#7570B3", "#075277","#00B1E8","#1FC944",
          "#E6AB02", "#E7298A","#E07E34", "#F15858")

colors <- brewer.pal(n = nPop(snps_genlight_sites), name = "Dark2")
colors <- colors[as.numeric(cgum_79_1.pca.scores$pop)]

colores <- cols[as.numeric(cgum_79_1.pca.scores$pop)]

#ggplot con esa tabla de scores
#agrego ggplot
set.seed(12345)
ggplot(cgum_79_1.pca.scores, aes(x=PC2, y=PC1)) + geom_point(aes(colour = pop), size = 4, alpha = 0.7) +
  scale_colour_manual(values = cols, name="Sitios", 
                      labels=c("PZ", "CR", "LS","MC", "MB", "CY", "MT","CZ")) + geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + theme_bw() + theme(legend.title = element_blank()) + theme(legend.text = element_text(size = 18)) +
  theme(axis.title.x = element_text(size=20), axis.text.x  = element_text(size=16)) +
  theme(axis.title.y = element_text(size=20), axis.text.y  = element_text(size=16)) + 
  xlab("PC2 %2.361") + ylab("PC1 %4.45") + geom_text(aes(label=snps_genlight_sites$ind.names),hjust=-0.4, vjust=0.8, size=3)


#+ stat_ellipse(level = 0.9, size = 0.2)

### PCA 3D

cgum_79_1_pop.pca <- glPca(snps_genlight_sites, nf=80)
sum(100*cgum_79_1_pop.pca$eig/sum(cgum_79_1_pop.pca$eig))
(cgum_79_1_pop.pca$eig[1]/sum(cgum_79_1_pop.pca$eig))*100
(cgum_79_1_pop.pca$eig[2]/sum(cgum_79_1_pop.pca$eig))*100
(cgum_79_1_pop.pca$eig[3]/sum(cgum_79_1_pop.pca$eig))*100
(cgum_79_1_pop.pca$eig[4]/sum(cgum_79_1_pop.pca$eig))*100


#Barplot of eigenvalues

cgum_79_1_pop.pca.scores <- as.data.frame(cgum_79_1_pop.pca$scores)
cgum_79_1_pop.pca.scores$pop <- pop(snps_genlight_sites)


colors <- brewer.pal(n = nPop(snps_genlight_sites), name = "Dark2")
colors <- colors[as.numeric(cgum_79_1.pca.scores$pop)]

colores <- cols[as.numeric(cgum_79_1.pca.scores$pop)]
s3d1 <- scatterplot3d(cgum_79_1.pca.scores[,1:3], angle = 100, type='h', pch = 16, grid=TRUE, cex.symbols = 2, axis=TRUE, color = colors, box=F) 
my.lm <- lm(cgum_79_1.pca.scores$PC1 ~ cgum_79_1.pca.scores$PC2 + cgum_79_1.pca.scores$PC3)
s3d1$plane3d(my.lm)
legend(x=0,y=10,c("sample1","sample2"),cex=.8,col=c("red","blue"), pch=16)

#Add the names of the individuals
text(s3d1$xyz.convert(cgum_79_1.pca.scores[, 1:3]), 
     labels = rownames(cgum_79_1.pca.scores),cex= 0.8, adj =c(0,1.5), 
     col = "black", font = 2 )



