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


