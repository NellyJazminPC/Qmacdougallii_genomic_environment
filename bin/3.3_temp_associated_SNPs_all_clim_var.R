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


#########################################################################################
##running GF for temperature associated SNPs and ALL CLIMATIC VARIABLES
preds <- colnames(envGF)
specs <- colnames(temp_SNP)
nSites <- dim(envGF)[1]
nSpecs <- dim(temp_SNP)[2]
nSites
nSpecs

## GRADIENT FOREST MODELING ##

#account for correlations. # set depth of conditional permutation
maxLevel <- log2(0.368*nrow(envGF)/2)
maxLevel

#Fit gf models for reference SNPs 
temp1_gfmod <- gradientForest(cbind(envGF, temp_SNP), predictor.vars=colnames(envGF),
                              response.vars=colnames(temp_SNP), ntree=2000, compact=T, nbin =1001,
                              maxLevel=maxLevel, trace=T, corr.threshold=0.5)
temp1_gfmod

summary(temp1_gfmod)

write.table(temp1_gfmod$Y, file="temp1_gf_Y.txt")
write.table(temp1_gfmod$X, file="temp1_gf_X.txt")
write.table(temp1_gfmod$imp.rsq, file="temp1_gf_impRsq.txt")
write.table(temp1_gfmod$result, file="temp1_gf_result.txt")
write.table(temp1_gfmod$res.u, file="temp1_gf_res_u.txt")
write.table(temp1_gfmod$res, file="temp1_gf_res.txt")
temp1_gfmod$overall.imp
temp1_gfmod$overall.imp2

#plot output, see ?plot.gradientForest
#predictoroverallimportance
pdf(file="~/temp1_predictoroverallimportance.pdf")
plot.gradientForest(temp1_gfmod,plot.type="O")
dev.off()

temp1_predictors=names(importance(temp1_gfmod))
temp1_predictors

#splitsdensityplots
pdf(file="~/temp1_splitsdensityplots.pdf")
plot(temp1_gfmod, plot.type="S", imp.vars=temp1_predictors, leg.posn="topright", cex.legend=0.4, cex.axis=0.6, cex.lab=0.7, line.ylab=0.9, par.args=list(mgp=c(1.5, 0.5, 0), mar=c(3.1,1.5,0.1,1)))
dev.off()

#speciescumulativeplot #the legend identifies the top 5 most responsive SNPs for each predictor
pdf(file="~/temp1_speciescumulativeplot.pdf")
plot.gradientForest(temp1_gfmod, plot.type="Cumulative.Importance", imp.vars=temp1_predictors, show.overall=T, legend=T,common.scale=T,leg.posn="topleft", leg.nspecies=5, cex.lab=0.7, cex.legend=0.4, cex.axis=0.6, line.ylab=0.9, par.args=list(mgp=c(1.5, 0.5, 0), mar=c(3.1,1.5,0.1,1),omi=c(0,0.3,0,0)))
dev.off()

#predictorcumulative #show cumulative change in overall composition of the community, where changes occur on the gradient
pdf(file="~/temp1_predictorcumulative.pdf")
plot(temp1_gfmod, plot.type="C", imp.vars=temp1_predictors, show.species=F, common.scale=T, cex.axis=0.6, cex.lab=0.7, line.ylab=0.9, par.args=list(mgp=c(1.5, 0.5, 0), mar=c(2.5,1.0,0.1,0.5), omi=c(0,0.3,0,0)))
dev.off()

#R2
pdf(file="~/temp1_R2.pdf")
plot(temp1_gfmod, plot.type="P", show.names=F, horizontal=F, cex.axis=1, cex.labels=0.7, line=2.5)
dev.off()

#transform grid and environmental predictors
temp1_predictors <- names(importance(temp1_gfmod)[1:4])
temp1_predictors
#[1] "bio6"  "bio15" "MEM1"  "bio16"

temp1_tgrid=cbind(greengrid[,c("lon","lat")], predict.gradientForest(temp1_gfmod,greengrid[,temp1_predictors]))
temp1_Trns_site <- predict(temp1_gfmod)
write.table(temp1_tgrid, file="temp1_trans_predictors.txt")

#pcs
temp1_PCs=prcomp(temp1_tgrid[,3:6], center=TRUE, scale.=FALSE)
temp1_PCs

summary(temp1_PCs)

# set up a colour palette for the mapping
a1 <- temp1_PCs$x[,1]
a2 <- temp1_PCs$x[,2]
a3 <- temp1_PCs$x[,3]
r <- a1+a2
g <- -a2
b <- a3+a2-a1
r <- (r-min(r)) / (max(r)-min(r)) * 255
g <- (g-min(g)) / (max(g)-min(g)) * 255
b <- (b-min(b)) / (max(b)-min(b)) * 255

nvs <- dim(temp1_PCs$rotation)[1] # number of variables
vec <- c("bio15", "bio16") 
lv <- length(vec)
vind <- rownames(temp1_PCs$rotation) %in% vec
# choose a scaling factor to plot the vectors over the grid
scal <- 60
xrng <- range(temp1_PCs$x[,1], temp1_PCs$rotation[,1]/scal)*1.1
yrng <- range(temp1_PCs$x[,2], temp1_PCs$rotation[,2]/scal)*1.1
pdf(file="~/temp1_PCplot.pdf")
plot((temp1_PCs$x[,1:2]), xlim=xrng, ylim=yrng, pch=".", cex=7, col=rgb(r,g,b, max = 255), asp=1)
# plot the other predictors with "+"
points(temp1_PCs$rotation[! vind,1:2]/scal, pch="+")  
# plot the chosen predictors as arrows
arrows(rep(0,lv), rep(0,lv), temp1_PCs$rotation[,1]/scal, temp1_PCs$rotation[,2]/scal, length = 0.1)
jit <- 0.0015
text(temp1_PCs$rotation[,1]/scal+jit*sign(temp1_PCs$rotation[,1]), temp1_PCs$rotation[,2]/scal+jit*sign(temp1_PCs$rotation[,2]), labels = vec)

# first predict the PCs for the transformed site data
temp1_PCsites <- predict(temp1_PCs,temp1_Trns_site[,temp1_predictors])
# plot all the sites as points on the biplot
points(temp1_PCsites[,1:2])
dev.off()

#plot these in geographic space

pdf(file="~/temp1_map.pdf")
green.pred <- predict(temp1_gfmod, greengrid[,temp1_predictors])
plot(temp1_tgrid[,c("lon","lat")],pch=15,cex=1.0,asp=1,col=rgb(r,g,b, max=255),main="SNP turnover in Q rugosa")
points(sites)
dev.off()
#clustered version
require(cluster)
ncl <- 8 
clPCs <- clara(temp1_PCs$x,ncl,sampsize=1000) 
# get the medoid colour palette
medcolR <- r[clPCs$i.med]
medcolG <- g[clPCs$i.med]
medcolB <- b[clPCs$i.med]

# re-plot the biplot -- coloured by cluster medoids
pdf(file="~/temp1_map_cluster.pdf")
plot((temp1_PCs$x[,1:2]), xlim=xrng, ylim=yrng,pch=".", cex=4, col=rgb(medcolR[clPCs$clustering], medcolG[clPCs$clustering], medcolB[clPCs$clustering],  max = 255), asp=1)
points(temp1_PCs$rotation[! vind,1:2]/scal, pch="+") 
arrows(rep(0,lv), rep(0,lv), temp1_PCs$rotation[,1]/scal, temp1_PCs$rotation[,2]/scal, length = 0.0625) 
text(temp1_PCs$rotation[,1]/scal+jit*sign(temp1_PCs$rotation[,1]), temp1_PCs$rotation[,2]/scal+jit*sign(temp1_PCs$rotation[,2]), labels = vec)

# plot the cluster medoids with ID number
text(clPCs$medoids[,1:2], labels = seq(1,ncl)) 
legend("bottomleft",as.character(seq(1,ncl)), pch=15, cex=1,col=rgb(medcolR,medcolG,medcolB, max = 255))
dev.off()

#export map for use in ArcGIS
greencols=rgb(r,g,b,max=255)
greencols2=col2rgb(greencols)
greencols3=t(greencols2)
gradients=cbind(temp1_tgrid[c("lon","lat")],greencols3)
write.csv(gradients,file="temp1_gradients4arcgis.csv")
