#############################################################################################
#First we need to clean work space
rm(list=ls()) 

# Load the library for VIF
library(usdm)

# Load the database
values_clim<- read.csv("../results/databases/q_macd_wc_values.csv")

# Correlation matrix, 
# Define which are the columns with the variables to make the correlation, considering the 19 variables
cormatriz <- cor(values_clim[,5:23])

#Export the figure
png("../results/figures/Qmacdougallii_WC_var_correlation.png")
corrplot(cormatriz, order = "hclust", method = "color",  type = "upper" , outline = F, tl.col = "black")
dev.off()

#Just the plot
corrplot(cormatriz, order = "hclust", method = "color",  type = "upper" , outline = F, tl.col = "black")


# To quantify the intensity of multicollinearity we can use another method, in Variance Inflation Factor (VIF)
vif(values_clim[,5:23])

# If it is high (greater than 10 or the value set by the user) then a reduction in steps is used to gradually eliminate them
# th: is the desired threshold value
no_corr <- vifstep(values_clim[,5:23], th=10) 
# To see which variables were left with low collinearity values
no_corr


