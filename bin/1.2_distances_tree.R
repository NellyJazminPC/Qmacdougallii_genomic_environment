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

# Tree of distances by sites
#Change site levels to two POPs
#glnew <- gl.edit.recode.pop(snps_genlight_sites)
#levels(pop(glnew))

# Tree based on neighbor joining NJ, summarizing genetic similarity between sites
tree_sitios_79.1 <- gl.tree.nj(snps_genlight_sites, type="fan")
tree_sitios_79.1
#Export the tree in .tre format to open it in Geneious
#write.tree(tree_sitios_79.1, file = 'tree_sitios_79.2.tre')
