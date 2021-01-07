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


##########################################################################################
##running GF with climate_associated SNPs (candidates- cand)
preds <- colnames(envGF)
specs <- colnames(cand_SNP)
nSites <- dim(envGF)[1]
nSpecs <- dim(cand_SNP)[2]
nSites
nSpecs

# GRADIENT FOREST MODELING 
#account for correlations. # set depth of conditional permutation
maxLevel <- log2(0.368*nrow(envGF)/2)
maxLevel

#Fit gf models for reference SNPs 
cand_gfmod <- gradientForest(cbind(envGF, cand_SNP), predictor.vars=colnames(envGF),
                             response.vars=colnames(cand_SNP), ntree=2000, compact=T, nbin =1001,
                             maxLevel=maxLevel, trace=T, corr.threshold=0.5)
cand_gfmod

summary(cand_gfmod)

write.table(cand_gfmod$Y, file="cand_gf_Y.txt")
write.table(cand_gfmod$X, file="cand_gf_X.txt")
write.table(cand_gfmod$imp.rsq, file="cand_gf_impRsq.txt")
write.table(cand_gfmod$result, file="cand_gf_result.txt")
write.table(cand_gfmod$res.u, file="cand_gf_res_u.txt")
write.table(cand_gfmod$res, file="cand_gf_res.txt")
cand_gfmod$overall.imp

#plot output, see ?plot.gradientForest
#predictoroverallimportance
pdf(file="~/cand_predictoroverallimportance.pdf")
plot.gradientForest(cand_gfmod,plot.type="O")
dev.off()

cand_predictors=names(importance(cand_gfmod))
cand_predictors

#splitsdensityplots
pdf(file="~/cand_splitsdensityplots.pdf")
plot(cand_gfmod, plot.type="S", imp.vars=cand_predictors, leg.posn="topright", cex.legend=0.4, cex.axis=0.6, cex.lab=0.7, line.ylab=0.9, par.args=list(mgp=c(1.5, 0.5, 0), mar=c(3.1,1.5,0.1,1)))
dev.off()

#speciescumulativeplot #the legend identifies the top 5 most responsive SNPs for each predictor
pdf(file="~/cand_speciescumulativeplot.pdf")
plot.gradientForest(cand_gfmod, plot.type="Cumulative.Importance", imp.vars=cand_predictors, show.overall=T, legend=T,common.scale=T,leg.posn="topleft", leg.nspecies=5, cex.lab=0.7, cex.legend=0.4, cex.axis=0.6, line.ylab=0.9, par.args=list(mgp=c(1.5, 0.5, 0), mar=c(3.1,1.5,0.1,1),omi=c(0,0.3,0,0)))
dev.off()

#predictorcumulative #show cumulative change in overall composition of the community, where changes occur on the gradient
pdf(file="~/cand_predictorcumulative.pdf")
plot(cand_gfmod, plot.type="C", imp.vars=cand_predictors, show.species=F, common.scale=T, cex.axis=0.6, cex.lab=0.7, line.ylab=0.9, par.args=list(mgp=c(1.5, 0.5, 0), mar=c(2.5,1.0,0.1,0.5), omi=c(0,0.3,0,0)))
dev.off()

#R2
pdf(file="~/cand_R2.pdf")
plot(cand_gfmod, plot.type="P", show.names=F, horizontal=F, cex.axis=1, cex.labels=0.7, line=2.5)
dev.off()

#transform grid and environmental predictors
cand_predictors <- names(importance(cand_gfmod)[1:4])
cand_predictors
#[1] "MEM1"  "bio15" "bio6"  "MEM3"

cand_tgrid=cbind(greengrid[,c("lon","lat")], predict.gradientForest(cand_gfmod,greengrid[,cand_predictors]))
cand_Trns_site <- predict(cand_gfmod)
write.table(cand_tgrid, file="cand_trans_predictors.txt")
#pcs
cand_PCs=prcomp(cand_tgrid[,3:6], center=TRUE, scale.=FALSE)
cand_PCs
summary(cand_PCs)

# set up a colour palette for the mapping
a1 <- cand_PCs$x[,1]
a2 <- cand_PCs$x[,2]
a3 <- cand_PCs$x[,3]
r <- a1+a2
g <- -a2
b <- a3+a2-a1
r <- (r-min(r)) / (max(r)-min(r)) * 255
g <- (g-min(g)) / (max(g)-min(g)) * 255
b <- (b-min(b)) / (max(b)-min(b)) * 255

nvs <- dim(cand_PCs$rotation)[1] # number of variables
vec <- c("bio15", "bio16") 
lv <- length(vec)
vind <- rownames(cand_PCs$rotation) %in% vec
# choose a scaling factor to plot the vectors over the grid
scal <- 60
xrng <- range(cand_PCs$x[,1], cand_PCs$rotation[,1]/scal)*1.1
yrng <- range(cand_PCs$x[,2], cand_PCs$rotation[,2]/scal)*1.1
pdf(file="~/cand_PCplot.pdf")
plot((cand_PCs$x[,1:2]), xlim=xrng, ylim=yrng, pch=".", cex=7, col=rgb(r,g,b, max = 255), asp=1)
# plot the other predictors with "+"
points(cand_PCs$rotation[! vind,1:2]/scal, pch="+")  
# plot the chosen predictors as arrows
arrows(rep(0,lv), rep(0,lv), cand_PCs$rotation[,1]/scal, cand_PCs$rotation[,2]/scal, length = 0.1)
jit <- 0.0015
text(cand_PCs$rotation[,1]/scal+jit*sign(cand_PCs$rotation[,1]), cand_PCs$rotation[,2]/scal+jit*sign(cand_PCs$rotation[,2]), labels = vec)

# first predict the PCs for the transformed site data
cand_PCsites <- predict(cand_PCs,cand_Trns_site[,cand_predictors])
# plot all the sites as points on the biplot
points(cand_PCsites[,1:2])
dev.off()

#plot these in geographic space

pdf(file="~/cand_map.pdf")
green.pred <- predict(cand_gfmod, greengrid[,cand_predictors])
plot(cand_tgrid[,c("lon","lat")],pch=15,cex=1.0,asp=1,col=rgb(r,g,b, max=255),main="SNP turnover in Q rugosa")
points(sites)
dev.off()
#clustered version
require(cluster)
ncl <- 8 
clPCs <- clara(cand_PCs$x,ncl,sampsize=1000) 
# get the medoid colour palette
medcolR <- r[clPCs$i.med]
medcolG <- g[clPCs$i.med]
medcolB <- b[clPCs$i.med]

# re-plot the biplot -- coloured by cluster medoids
pdf(file="~/cand_map_cluster.pdf")
plot((cand_PCs$x[,1:2]), xlim=xrng, ylim=yrng,pch=".", cex=4, col=rgb(medcolR[clPCs$clustering], medcolG[clPCs$clustering], medcolB[clPCs$clustering],  max = 255), asp=1)
points(cand_PCs$rotation[! vind,1:2]/scal, pch="+") 
#arrows(rep(0,lv), rep(0,lv), cand_PCs$rotation[vec,1]/scal, cand_PCs$rotation[vec,2]/scal, length = 0.0625) 
#text(cand_PCs$rotation[vec,1]/scal+jit*sign(cand_PCs$rotation[vec,1]), cand_PCs$rotation[vec,2]/scal+jit*sign(cand_PCs$rotation[vec,2]), labels = vec)
arrows(rep(0,lv), rep(0,lv), cand_PCs$rotation[,1]/scal, cand_PCs$rotation[,2]/scal, length = 0.0625) 
text(cand_PCs$rotation[,1]/scal+jit*sign(cand_PCs$rotation[,1]), cand_PCs$rotation[,2]/scal+jit*sign(cand_PCs$rotation[,2]), labels = vec)

# plot the cluster medoids with ID number
text(clPCs$medoids[,1:2], labels = seq(1,ncl)) 
legend("bottomleft",as.character(seq(1,ncl)), pch=15, cex=1,col=rgb(medcolR,medcolG,medcolB, max = 255))
dev.off()

#export map for use in ArcGIS
greencols=rgb(r,g,b,max=255)
greencols2=col2rgb(greencols)
greencols3=t(greencols2)
gradients=cbind(cand_tgrid[c("lon","lat")],greencols3)
write.csv(gradients,file="cand_gradients4arcgis.csv")
