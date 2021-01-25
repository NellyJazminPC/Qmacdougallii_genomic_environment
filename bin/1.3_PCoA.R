### Analysis to know the dispersion of the data
### Principal Coordinate Analysis
##  PCoA
pc <- gl.pcoa(snps_genlight_sites, nfactors=80)
names(pc)

#Eigenvalues in a barplot
barplot(pc$eig/sum(pc$eig)*100) 

#Plot of PCoA
gl.pcoa.plot(pc, snps_genlight_sites, labels="pop", xaxis=2, yaxis=1, ellipse = F )

#Change site levels; with this line an interactive window will be displayed to change the levels manually
#glnew <- gl.edit.recode.pop (snps_genlight_sites)
#levels (pop (glnew))

#Just in case you wanna change the pops, for example insted of 8 pop it's only 2
#levels (pop (glnew)) <- c (rep ("POP1", 3), rep ("POP2", 5))
# gl.pcoa.plot (pc, snps_genlight_sites, labels = "pop", xaxis = 1, yaxis = 2)
#Interactive option
# gl.pcoa.plot (pc, glnew, labels = "interactive", xaxis = 2, yaxis = 3)
ggplotly ()

### To view it in 3D form --- ERROR
# gl.pcoa.plot.3d (pc, snps_genlight_sites)

