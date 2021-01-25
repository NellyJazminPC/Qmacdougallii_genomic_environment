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

#To run interactive mode
#imsn ()


