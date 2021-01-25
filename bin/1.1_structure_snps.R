#### 
rm(list = ls(all=TRUE))

### Libraries

library(vcfR)
library(ade4)
library(adegenet)
library(dartR) 
library(ggplot2)
library(poppr)
library(ape)
library(plotly)# For PCoA
library(directlabels) # For PCoA
library(pca3d)#For the gl.pcoa.plot.3d
library(igraph) #For Minimum spanning networks (MSN)
library(shiny) # To execute MSN interactive mode
library(scatterplot3d) #For 3D PCA
library(RColorBrewer)


#Cargar el archivo VCF (variant call format)
var_snps_vcf <- read.vcfR("../data/var.79.inds.sorted.vcf")
var_snps_vcf

#Cargar metadatos de la especie
pop.data <- read.csv("../metadata/Qmacdougalli_79ind.csv")
head (pop.data)

#Veririficar que el nombre las muestras en el VCF sean iguales a las del pop.data
all(colnames(var_snps_vcf@gt)[-1] == pop.data$NOM_IND)

#Converting the dataset to a genlight object

snps_genlight_sites <- vcfR2genlight(var_snps_vcf)

#Describimos las ploidia de los individuos
ploidy(snps_genlight_sites) <- 2
snps_genlight_sites@ploidy

#Determina las poblaciones mediante el sitio de colecta a menos que ya tengas determinada a que población pertenece cada individuo
pop(snps_genlight_sites) <- pop.data$SITIO

###Convertir de genlight a genind y a genclone

snps_sites_genind <- gl2gi(snps_genlight_sites, v=1)
snps_sites_genclone <- as.genclone(snps_sites_genind)

### Distance tree

tree <- aboot(snps_genlight_sites, tree = "nj", 
              distance = bitwise.dist, sample = 500, 
              showtree = F, cutoff = 50, quiet = T)

# write file to export database
#write.tree(tree, file = '../results/databases/tree_glfts_2pop_2pop_79.2.tre') # write file tree.tre (Newick file format)

# get pairwise taxa-taxa distance matrix
tree_qmacd=cophenetic(tree)

# print distance matrix d to text file
#write.table(tree_qmacd, file = 'taxa_pairwise_dist_qmacd.txt',sep = '\t', quote = FALSE, col.names=NA)

cols <- c("#7570B3", "#075277","#00B1E8","#1FC944",
          "#E6AB02", "#E7298A","#E07E34", "#F15858")

plot.phylo(tree, type = "cladogram", use.edge.length = T, rotate.tree = 170, 
           edge.color = "black", node.pos = 2, 
           show.tip.label = TRUE, edge.width = 1, cex = .6, font = 1, 
           tip.color =  cols[pop(snps_genlight_sites)], no.margin = F)

#######Extra
nodelabels(tree$node.label, adj = c(0.1, -0.5), frame = "n", cex = 0.6,font = 1, xpd = TRUE)
legend("topright", legend = c("Comaltepec-Yolox","Ixtlán"), fill = cols, border = FALSE, bty = "n", cex = 0.3)
axis(side = 1)
title(xlab = "Distancia genética (proporción de loci que son diferentes)", cex=0.5 )

#Arbol por sitios

#Cambiar los niveles de sitios a dos POP
#glnew <- gl.edit.recode.pop(snps_genlight_sites)
#levels(pop(glnew))

#Árbol nj que resume la similitud genética entre los sitios
tree_sitios_79.1 <- gl.tree.nj(snps_genlight_sites, type="fan")
#Exportar el arbol en formato .tre para abrirlo en Geneious
#write.tree(tree_sitios_79.1, file = 'tree_sitios_79.2.tre') # write file tree.tre (Newick file format)



### Analisis para conocer la dispersión de los datos
####PCoA####
pc <- gl.pcoa(snps_genlight_sites, nfactors=80)
names(pc)
barplot(pc$eig/sum(pc$eig)*100) 

#Para cambiar los márgenes
par("mar")
par(mar=c(1,2,1,2))

gl.pcoa.plot(pc, snps_genlight_sites, labels="pop", xaxis=2, yaxis=1, ellipse = F )


#Cambiar los niveles de sitios a dos POP
#glnew <- gl.edit.recode.pop(snps_genlight_sites)
#levels(pop(glnew))

#Just in case you wanna change the pops, for example insted of 8 pop it's only 2
#levels(pop(glnew)) <- c(rep("POP1",3),rep("POP2",5))
#gl.pcoa.plot(pc, snps_genlight_sites, labels="pop", xaxis=1, yaxis=2)
#Opcion interactiva
#gl.pcoa.plot(pc, glnew, labels="interactive", xaxis=2, yaxis=3)
#ggplotly()

#Para conocer el porcentaje de contribución de cada eigenvalue
gl.pcoa.scree(pc)

###  Para visaulizarlo en forma 3D---ERROR
#gl.pcoa.plot.3d(pc, snps_genlight_sites)

#####Minimum spanning networks####

snps_sites.dist <- bitwise.dist(snps_sites_genclone)
snps_sites.msn <- poppr.msn(snps_sites_genclone, snps_sites.dist, showplot = FALSE, include.ties = T)

node.size <- rep(2, times = nInd(snps_sites_genclone))
names(node.size) <- indNames(snps_sites_genclone)
vertex.attributes(snps_sites.msn$graph)$size <- node.size

set.seed(12345)
plot_poppr_msn(snps_sites_genclone, snps_sites.msn, 
               palette = cols,
               gadj = 500)

#Para ejecutar el modo interactivo
#imsn()


#####Principal components analysis####

cgum_79_1.pca <- glPca(snps_genlight_sites, nf=80)

#glPca(snps_genlight_sites)
sum(100*cgum_79_1.pca$eig/sum(cgum_79_1.pca$eig))
(cgum_79_1.pca$eig[1]/sum(cgum_79_1.pca$eig))*100
(cgum_79_1.pca$eig[2]/sum(cgum_79_1.pca$eig))*100
(cgum_79_1.pca$eig[3]/sum(cgum_79_1.pca$eig))*100
(cgum_79_1.pca$eig[4]/sum(cgum_79_1.pca$eig))*100


#Barplot de los eigenvalores
#Reajustar los márgenes
par("mar")
par(mar=c(4,4,4,4))
#Barplot
barplot(100*cgum_79_1.pca$eig/sum(cgum_79_1.pca$eig), main="PCA Eigenvalores")
title(ylab="Porcentaje de la varianza/explicada", line = 2)
title(xlab="Eigenvalores", line = 1)


#Scores
cgum_79_1.pca.scores <- as.data.frame(cgum_79_1.pca$scores)
cgum_79_1.pca.scores$pop <- pop(snps_genlight_sites)

#Plot del PCA

colors <- brewer.pal(n = nPop(snps_genlight_sites), name = "Dark2")
colors <- colors[as.numeric(cgum_79_1.pca.scores$pop)]

colores <- cols[as.numeric(cgum_79_1.pca.scores$pop)]


set.seed(12345)
p <- ggplot(cgum_79_1.pca.scores, aes(x=PC2, y=PC1), colours=colores)
p <- p + geom_point(size=4, alpha=0.7)  + 
  scale_color_manual(values = colores, name="Sitios", labels=c("PZ", "CR", "LS","MC", "MB", "CY", "MT","CZ")) 
p <- p + geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + theme_bw() 
p <- p + theme(legend.title = element_blank()) + theme(legend.text = element_text(size = 18)) +
  theme(axis.title.x = element_text(size=20), axis.text.x  = element_text(size=16)) +
  theme(axis.title.y = element_text(size=20), axis.text.y  = element_text(size=16)) + 
  xlab("PC2 %11.44") + ylab("PC1 %28.73")
p  + geom_text(aes(label=snps_genlight_sites$ind.names),hjust=-0.4, vjust=0.8, size=3)

#+ stat_ellipse(level = 0.9, size = 0.2)

### PCA 3D

cgum_79_1_pop.pca <- glPca(snps_genlight_sites, nf=80)
sum(100*cgum_79_1_pop.pca$eig/sum(cgum_79_1_pop.pca$eig))
(cgum_79_1_pop.pca$eig[1]/sum(cgum_79_1_pop.pca$eig))*100
(cgum_79_1_pop.pca$eig[2]/sum(cgum_79_1_pop.pca$eig))*100
(cgum_79_1_pop.pca$eig[3]/sum(cgum_79_1_pop.pca$eig))*100
(cgum_79_1_pop.pca$eig[4]/sum(cgum_79_1_pop.pca$eig))*100
#Barplot de los eigenvalores

cgum_79_1_pop.pca.scores <- as.data.frame(cgum_79_1_pop.pca$scores)
cgum_79_1_pop.pca.scores$pop <- pop(snps_genlight_sites)


library(scatterplot3d)
colors <- brewer.pal(n = nPop(snps_genlight_sites), name = "Dark2")
colors <- colors[as.numeric(cgum_79_1.pca.scores$pop)]

colores <- cols[as.numeric(cgum_79_1.pca.scores$pop)]
s3d1 <- scatterplot3d(cgum_79_1.pca.scores[,1:3], angle = 100, type='h', pch = 16, grid=TRUE, cex.symbols = 2, axis=TRUE, color = colors, box=F) 
my.lm <- lm(cgum_79_1.pca.scores$PC1 ~ cgum_79_1.pca.scores$PC2 + cgum_79_1.pca.scores$PC3)
s3d1$plane3d(my.lm)
legend(x=0,y=10,c("sample1","sample2"),cex=.8,col=c("red","blue"), pch=16)
#Agregar nombres
text(s3d1$xyz.convert(cgum_79_1.pca.scores[, 1:3]), 
     labels = rownames(cgum_79_1.pca.scores),cex= 0.8, adj =c(0,1.5), 
     col = "black", font = 2 )




#####DAPC#####
grp <- find.clusters(snps_sites_genind, max.n.clust=8)

table.value(table(pop(snps_sites_genind), grp$grp), col.lab=paste("inf", 1:8),
            row.lab=paste("ori", 1:8))

dapc1 <- dapc(snps_sites_genind, grp$grp)
scatter(dapc1)
summary(dapc1)
assignplot(dapc1, subset=1:79)
dapc1$assign



pnw.dapc <- dapc(snps_genlight_sites, var.contrib = TRUE, scale = FALSE , n.pca = NULL, n.da = nPop(snps_genlight_sites)-1)

#pnw.dapc <- dapc(gl.rubi, n.pca = 3, n.da = 2)
#mstree una lógica que indica si un árbol de expansión mínimo que vincula los grupos 
#y en función de las distancias cuadradas entre los grupos dentro de todo el espacio 
#debe agregarse a la gráfica (VERDADERO), o no (FALSO).
scatter(pnw.dapc, cell = 0, pch = 18:25, 
        cstar = 0, mstree = TRUE, lwd = 2, 
        lty = 2)


scatter(dapc1, col = cols, cex = 4, cell=0, cstar = 1, mstree = TRUE, 
        lwd = 2, lty = 2, legend = F, clabel = F, 
        posi.leg = "topleft" ,txt.leg=c("1", "2", "3","4"),
        scree.da = T, posi.da = "topright", posi.pca = "topright", 
        scree.pca = T , pch=20, solid = 0.4)




#dapc.H3N2 <- dapc(H3N2, var.contrib = TRUE, scale = FALSE, n.pca = 30, n.da = nPop(H3N2) - 1)

set.seed(12345)
#La gráfica de carga identifica bastante bien los alelos más discriminantes.
contrib <- loadingplot(pnw.dapc$var.contr, thres = 2e-3, lab.jitter = 1, main = NULL )

#Hacer un zoom a los ultimos 100
loadingplot(head(dapc1$var.contr[,1],5000), thres=2e-3)

temp <- seploc(snps_sites_genind) # seploc {adegenet} creates a list of individual loci.

snp28  <- tab(temp[["SSCAFFOLD-1_3063695"]]) # tab {adegenet} returns a matrix of genotypes
snp258 <- tab(temp[["SSCAFFOLD-1_20653770"]])
snp892 <- tab(temp[["SSCAFFOLD-10_24350220"]])
snp1056 <- tab(temp[["SSCAFFOLD-10_46956262"]])
snp3344 <- tab(temp[["SSCAFFOLD-15_5638038"]])
snp4789 <- tab(temp[["SSCAFFOLD-3_13582018"]])
snp7116 <- tab(temp[["SSCAFFOLD-7_49571214"]])
snp7868 <- tab(temp[["SSCAFFOLD-9_17549497"]])

# The following two commands find the average allele frequencies per population
(freq28 <- apply(snp28, 2, function(e) tapply(e, pop(snps_sites_genind), mean, na.rm = TRUE)))
(freq258 <- apply(snp258, 2, function(e) tapply(e, pop(snps_sites_genind), mean, na.rm = TRUE)))
(freq892 <- apply(snp892, 2, function(e) tapply(e, pop(snps_sites_genind), mean, na.rm = TRUE)))
(freq1056 <- apply(snp1056, 2, function(e) tapply(e, pop(snps_sites_genind), mean, na.rm = TRUE)))
(freq3344 <- apply(snp3344, 2, function(e) tapply(e, pop(snps_sites_genind), mean, na.rm = TRUE)))
(freq4789 <- apply(snp4789, 2, function(e) tapply(e, pop(snps_sites_genind), mean, na.rm = TRUE)))
(freq7116 <- apply(snp7116, 2, function(e) tapply(e, pop(snps_sites_genind), mean, na.rm = TRUE)))
(freq7868 <- apply(snp7868, 2, function(e) tapply(e, pop(snps_sites_genind), mean, na.rm = TRUE)))

# First, set the plotting parameters
# mfrow = number of columns, rows
# mar   = plot margin size
# las   = axis label style (3: always vertical)
par(mfrow = c(2, 4), mar = c(5, 4, 4, 0) + 0.1, las = 3)

matplot(freq28, type = "b", pch = c("g", "a"),
        xlab = "SITIO", ylab = "Frecuencia alélica", main = "SNP # 28",
        xaxt = "n", cex = 1.5)
axis(side = 1, at = 1:8, lab = c("PZ","CR","LS","MC","MB","CY","MT","CZ"))

matplot(freq258, type = "b", pch = c("t", "c"),
        xlab = "SITIO", ylab = "Frecuencia alélica", main = "SNP # 258",
        xaxt = "n", cex = 1.5)
axis(side = 1, at = 1:8, lab = c("PZ","CR","LS","MC","MB","CY","MT","CZ"))

matplot(freq892, type = "b", pch = c("g", "a"),
        xlab = "SITIO", ylab = "Frecuencia alélica", main = "SNP #892",
        xaxt = "n", cex = 1.5)
axis(side = 1, at = 1:8, lab = c("PZ","CR","LS","MC","MB","CY","MT","CZ"))

matplot(freq1056, type = "b", pch = c("c", "t"),
        xlab = "SITIO", ylab = "Frecuencia alélica", main = "SNP #1056",
        xaxt = "n", cex = 1.5)
axis(side = 1, at = 1:8, lab = c("PZ","CR","LS","MC","MB","CY","MT","CZ"))

matplot(freq3344, type = "b", pch = c("g", "a"),
        xlab = "SITIO", ylab = "Frecuencia alélica", main = "SNP #3344",
        xaxt = "n", cex = 1.5)
axis(side = 1, at = 1:8, lab = c("PZ","CR","LS","MC","MB","CY","MT","CZ"))

matplot(freq4789, type = "b", pch = c("g", "a"),
        xlab = "SITIO", ylab = "Frecuencia alélica", main = "SNP #4789",
        xaxt = "n", cex = 1.5)
axis(side = 1, at = 1:8, lab = c("PZ","CR","LS","MC","MB","CY","MT","CZ"))

matplot(freq7116, type = "b", pch = c("a", "g"),
        xlab = "SITIO", ylab = "Frecuencia alélica", main = "SNP #7116",
        xaxt = "n", cex = 1.5)
axis(side = 1, at = 1:8, lab = c("PZ","CR","LS","MC","MB","CY","MT","CZ"))


matplot(freq7868, type = "b", pch = c("a", "t"),
        xlab = "SITIO", ylab = "Frecuencia alélica", main = "SNP #7868",
        xaxt = "n", cex = 1.5)
axis(side = 1, at = 1:8, lab = c("PZ","CR","LS","MC","MB","CY","MT","CZ"))






# Now we reset the plotting parameters to default
par(mfrow = c(1, 1), mar = c(5, 4, 4, 2) + 0.1, las = 0)

set.seed(999)
pramx <- xvalDapc(tab(snps_sites_genclone, NA.method = "mean"), pop(snps_sites_genclone))

set.seed(999)
system.time(pramx <- xvalDapc(tab(snps_sites_genclone, NA.method = "mean"), 
                              pop(snps_sites_genclone), n.pca = 5:20, n.rep = 1000, 
                              parallel = "multicore", ncpus = 6))

names(pramx) # The first element are all the samples
pramx[2:6]
scatter(pramx$DAPC,cex = 2,col = cols, cell=0, cstar = 1, legend = F, mstree = TRUE, lwd = 2, lty = 2,
        clabel = FALSE, posi.leg = "bottomleft", scree.pca = F, scree.da = F,
        posi.pca = "topleft", cleg = 0.75, xax = 1, yax = 2, inset.solid = 1, pch=19)


#compoplot(pnw.dapc,col = function(x) cols, posi = 'top')
compoplot(pramx$DAPC,col = cols, posi = 'top')

dapc.results <- as.data.frame(pramx$DAPC$posterior)
dapc.results$pop <- pop(snps_genlight_sites)
dapc.results$indNames <- rownames(dapc.results)

library(reshape)
dapc.results <- melt(dapc.results)

colnames(dapc.results) <- c("Original_Pop","Sample","Assigned_Pop","Posterior_membership_probability")

p <- ggplot(dapc.results, aes(x=Sample, y=Posterior_membership_probability, fill=Assigned_Pop))
p <- p + geom_bar(stat='identity') 
p <- p + scale_fill_manual(values = cols) 
p <- p + facet_grid(~Original_Pop, scales = "free")
p <- p + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 8))
p


