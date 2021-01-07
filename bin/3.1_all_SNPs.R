# Description: This README file presents the commands used to run gradient forests analyses

library(gradientForest)

##upload input files
all_SNP=read.table("MAF_all.txt", header=T) # SNP data for 17 populations - all SNPs polymorphic in 5 or more pops (5353 SNPs)
head(all_SNP)


#cand_SNP=read.table("MAF_candidates.txt", header=T) # SNP data for 17 populations - climate_associated SNPs polymorphic in 5 or more pops
#prec_SNP=read.table("MAF_prec_cand.txt", header=T) #SNP data for 17 popultations - associated with precipitation only polymorphic in 5 or more pops
#temp_SNP=read.table("MAF_temp_cand.txt", header=T) #SNP data for 17 popultations - associated with temperature only polymorphic in 5 or more pops
#four=read.table("MAFone_SNP.txt",header=T) #SNP data for 17 populations - outlier FST+climate-associated

env=read.table("environ_gf.txt", header=T) #environental data (MEM and climatic)
envGF=env[, c("MEM1", "MEM2", "MEM3", "bio4", "bio6", "bio15", "bio16")] #precipitation and temperature

#pops=read.table("GF_lon_lat.txt", header=T)
#sites=pops[, c("lon", "lat")] #only lon-lat of 17 populations

##To know how grid_predictors.txt was created see readme_GF_maps.txt in dismo directory

###New grid data (10,000 random points - sent by Antonio)
#Grid=read.table("qrug_bcg_present.txt",header=T)  #environental data (MEM, lat, lon and climatic for a grid plus sampling points)
#grid=Grid[, c("lon", "lat")] #only lon-lat of grid
#greengrid=Grid[,c("lon", "lat","MEM1","MEM2","MEM3","bio4", "bio6", "bio15", "bio16")]
########################################################################################
##running GF for all SNPs
preds <- colnames(envGF)
specs <- colnames(all_SNP)
nSites <- dim(envGF)[1]
nSpecs <- dim(all_SNP)[2]
nSites
nSpecs

# GRADIENT FOREST MODELING 
#account for correlations. # set depth of conditional permutation
maxLevel <- log2(0.368*nrow(envGF)/2)
maxLevel

#Fit gf models for reference SNPs 
all_gfmod <- gradientForest(cbind(envGF, all_SNP), predictor.vars=colnames(envGF),
                            response.vars=colnames(all_SNP), ntree=1, transform = , compact=T, nbin =101,
                            maxLevel=maxLevel, trace=T, corr.threshold=0.5)

prueba <- cbind(envGF, all_SNP)


prueba <- as.data.frame(prueba)

class(prueba)

gradientForest(prueba,predictor.vars = colnames(prueba[,1:7]), 
               response.vars = colnames(prueba[,8:5360]))

gradientForest(cbind(envGF, all_SNP), predictor.vars=colnames(envGF),
               response.vars=colnames(all_SNP))




prueba
all_gfmod
summary(all_gfmod)

write.table(all_gfmod$Y, file="all_gf_Y.txt")
write.table(all_gfmod$X, file="all_gf_X.txt")
write.table(all_gfmod$imp.rsq, file="all_gf_impRsq.txt")
write.table(all_gfmod$result, file="all_gf_result.txt")
write.table(all_gfmod$res.u, file="all_gf_res_u.txt")
write.table(all_gfmod$res, file="all_gf_res.txt")
all_gfmod$overall.imp

#plot output, see ?plot.gradientForest
#predictoroverallimportance
pdf(file="~/all_predictoroverallimportance.pdf")
plot.gradientForest(all_gfmod,plot.type="O")
dev.off()

all_predictors=names(importance(all_gfmod))
all_predictors

#splitsdensityplots
pdf(file="~/all_splitsdensityplots.pdf")
plot(all_gfmod, plot.type="S", imp.vars=all_predictors, leg.posn="topright", cex.legend=0.4, cex.axis=0.6, cex.lab=0.7, line.ylab=0.9, par.args=list(mgp=c(1.5, 0.5, 0), mar=c(3.1,1.5,0.1,1)))
dev.off()

#speciescumulativeplot #the legend identifies the top 5 most responsive SNPs for each predictor
pdf(file="~/all_speciescumulativeplot.pdf")
plot.gradientForest(all_gfmod, plot.type="Cumulative.Importance", imp.vars=all_predictors, show.overall=T, legend=T,common.scale=T,leg.posn="topleft", leg.nspecies=5, cex.lab=0.7, cex.legend=0.4, cex.axis=0.6, line.ylab=0.9, par.args=list(mgp=c(1.5, 0.5, 0), mar=c(3.1,1.5,0.1,1),omi=c(0,0.3,0,0)))
dev.off()

#predictorcumulative #show cumulative change in overall composition of the community, where changes occur on the gradient
pdf(file="~/all_predictorcumulative.pdf")
plot(all_gfmod, plot.type="C", imp.vars=all_predictors, show.species=F, common.scale=T, cex.axis=0.6, cex.lab=0.7, line.ylab=0.9, par.args=list(mgp=c(1.5, 0.5, 0), mar=c(2.5,1.0,0.1,0.5), omi=c(0,0.3,0,0)))
dev.off()

#R2
pdf(file="~/all_R2.pdf")
plot(all_gfmod, plot.type="P", show.names=F, horizontal=F, cex.axis=1, cex.labels=0.7, line=2.5)
dev.off()

#transform grid and environmental predictors
all_predictors <- names(importance(all_gfmod)[1:4])
all_predictors
#[1] "MEM1"  "bio15" "MEM2"  "MEM3"

all_Trns_site <- predict(all_gfmod)
all_tgrid=cbind(greengrid[,c("lon","lat")], predict.gradientForest(all_gfmod,greengrid[,all_predictors]))
write.table(all_tgrid, file="all_trans_predictors.txt")
#pcs
all_PCs=prcomp(all_tgrid[,3:6], center=TRUE, scale.=FALSE)
all_PCs
summary(all_PCs)

# set up a colour palette for the mapping
a1 <- all_PCs$x[,1]
a2 <- all_PCs$x[,2]
a3 <- all_PCs$x[,3]
r <- a1+a2
g <- -a2
b <- a3+a2-a1
r <- (r-min(r)) / (max(r)-min(r)) * 255
g <- (g-min(g)) / (max(g)-min(g)) * 255
b <- (b-min(b)) / (max(b)-min(b)) * 255

nvs <- dim(all_PCs$rotation)[1] # number of variables
vec <- c("bio15", "bio16")
lv <- length(vec)
vind <- rownames(all_PCs$rotation) %in% vec
# choose a scaling factor to plot the vectors over the grid
scal <- 60
xrng <- range(all_PCs$x[,1], all_PCs$rotation[,1]/scal)*1.1
yrng <- range(all_PCs$x[,2], all_PCs$rotation[,2]/scal)*1.1
pdf(file="~/all_PCplot.pdf")
plot((all_PCs$x[,1:2]), xlim=xrng, ylim=yrng, pch=".", cex=7, col=rgb(r,g,b, max = 255), asp=1)
# plot the other predictors with "+"
points(all_PCs$rotation[! vind,1:2]/scal, pch="+")  
# plot the chosen predictors as arrows
arrows(rep(0,lv), rep(0,lv), all_PCs$rotation[,1]/scal, all_PCs$rotation[,2]/scal, length = 0.1)
jit <- 0.0015
text(all_PCs$rotation[,1]/scal+jit*sign(all_PCs$rotation[,1]), all_PCs$rotation[,2]/scal+jit*sign(all_PCs$rotation[,2]), labels = vec)

# first predict the PCs for the transformed site data
all_PCsites <- predict(all_PCs,all_Trns_site[,all_predictors])
# plot all the sites as points on the biplot
points(all_PCsites[,1:2])

#plot these in geographic space

pdf(file="~/all_map.pdf")
green.pred <- predict(all_gfmod, greengrid[,all_predictors])
plot(all_tgrid[,c("lon","lat")],pch=15,cex=1.0,asp=1,col=rgb(r,g,b, max=255),main="SNP turnover in Q rugosa")
points(sites)
dev.off()
#clustered version
require(cluster)
ncl <- 8 
clPCs <- clara(all_PCs$x,ncl,sampsize=1000) 
# get the medoid colour palette
medcolR <- r[clPCs$i.med]
medcolG <- g[clPCs$i.med]
medcolB <- b[clPCs$i.med]

# re-plot the biplot -- coloured by cluster medoids
pdf(file="~/all_map_cluster.pdf")
plot((all_PCs$x[,1:2]), xlim=xrng, ylim=yrng,pch=".", cex=4, col=rgb(medcolR[clPCs$clustering], medcolG[clPCs$clustering], medcolB[clPCs$clustering],  max = 255), asp=1)
points(all_PCs$rotation[! vind,1:2]/scal, pch="+") 
#arrows(rep(0,lv), rep(0,lv), cand_PCs$rotation[vec,1]/scal, cand_PCs$rotation[vec,2]/scal, length = 0.0625) 
#text(cand_PCs$rotation[vec,1]/scal+jit*sign(cand_PCs$rotation[vec,1]), cand_PCs$rotation[vec,2]/scal+jit*sign(cand_PCs$rotation[vec,2]), labels = vec)
arrows(rep(0,lv), rep(0,lv), all_PCs$rotation[,1]/scal, all_PCs$rotation[,2]/scal, length = 0.0625) 
text(all_PCs$rotation[,1]/scal+jit*sign(all_PCs$rotation[,1]), all_PCs$rotation[,2]/scal+jit*sign(all_PCs$rotation[,2]), labels = vec)

# plot the cluster medoids with ID number
text(clPCs$medoids[,1:2], labels = seq(1,ncl)) 
legend("bottomleft",as.character(seq(1,ncl)), pch=15, cex=1,col=rgb(medcolR,medcolG,medcolB, max = 255))
dev.off()

#export map for use in ArcGIS
greencols=rgb(r,g,b,max=255)
greencols2=col2rgb(greencols)
greencols3=t(greencols2)
gradients=cbind(all_tgrid[c("lon","lat")],greencols3)
write.csv(gradients,file="all_gradients4arcgis.csv")
