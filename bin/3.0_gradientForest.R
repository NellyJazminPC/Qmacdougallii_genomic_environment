#Clean the environment
rm(list = ls(all=TRUE))
# Description of this script: In this script, other scripts in which the gradientForest analyzes were carried out in a modular way will be called with `source`

# We started running the GradientForest model for all SNPs
source("3.1_all_SNPs.R")

# Then, we run the GradientForest model with climate_associated SNPs (candidates- cand)
source("3.2_clim_associated_SNPs.R")

# Then, we run the GradientForest model for temperature associated SNPs and ALL CLIMATIC VARIABLES
source("3.3_temp_associated_SNPs_all_clim_var.R")
