install.packages("haven")
#importing datasets
library(haven)
Age_and_Possible_Selves<-read_sav("localonly/Age and Possible Selves 9.6.19.sav")
#this dataset can be read in console
#This dataset is not tidy. re
#We need to sort the data variables by scales not by scale items. 
#All the possible selves measures, both quantitative and qualitative 
#are meaningful while information on the participants' location, 
#answer duration etc. are not necessary.

#use pivot_longer() to reshape the data
#use drop_na() or replace_na() to clean up the data to make it functional for analysis

#may need factor (), levles(), and fct_recode() for creating factors or recoding data

#summarize each scale
#for each scale, create an average value for each participants; use summarize(), mean()
#leave out the quantitative data for data analysis; use filter()

#will use regression, PROCESS models or extension models in jamovi for mediated moderation
#test mediation, moderation, and mediated moderation
#curvilinear relationship therefor age_squared
#the current dataset is not the final dataset that I will be using
#therefore this is only a draft for the possible plan of attack on data analysis