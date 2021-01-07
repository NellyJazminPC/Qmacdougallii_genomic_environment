#Clean environment
rm(list=ls())

#Clean the data; we need to remove spacially repeated data in a radius of 1km2
source("2.1_clean_data.R")

#Extract the climatic values for each of the presence points
source("2.2_values_extraction.R")

#Analyze the correlation between the variables and discard those with high correlation values to avoid redundancy
source("2.3_variable_correlation.R")