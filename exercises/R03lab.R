
# R03 Lab -----------------------------------------------------------------

# In the following exercises you will work with the msleep dataset 
# which can be found in ggplot2 library and contains information about the 
# sleep hours and weight of 83 different mammanls. You will use dplyr and ggplot2
# to perform basic data manipulation, and gain insight of this dataset

# msleep dataset --------------------------------------------------------

#The variables you will find in diamonds are:

# name: common name
# genus
# vore: it the mammal carnivore, omnivore or herbivore?
# order
#	conservation: the conservation status of the animal
#	sleep_total: total amount of sleep (hours)
#	sleep_rem: rem sleep (hours)
#	sleep_cycle: length of sleep cycle (hours)
#	awake: amount of time spent awake (hours)
#	brainwt: brain weight (kgs)
#	bodywt: body weight (kgs)



#load libraries you need


#load the data



# Data manipulation -------------------------------------------------------

# 1. Describe exhaustively the dataset
# *Hint* start by using mutate_if to transform all characters to factors


# 2. Check for NAs
# a) How many NAs per row?
# b) How many NAs per column?
# c) How many NAs in total?
# d) Perform imputation of missing values with the mean of each genus for sleep rem
# and brainwt


# 3. Keep only rows, with a value in vore (non NA)


# 4. What is the mean hours of sleep and rem for Primates and Rodentia (order)?


# 5. What are the names of the 3 animals with the most sleep hours, in total?


# 6. Create a new column called rem_proportion [rem sleep/ total amount of sleep]


# 7. What are the mean sleep_total, sleep_rem, awake hour, brainwt and bodywt
# per vore (*Hint* group by and summarise), save the results in a new dataframe, 
# called 'sleepsums', save it as a csv and include it in your response



# Visualization -----------------------------------------------------------

# The purpose of creating plots is to answer questions regarding
# a dataset, in a way that makes the responses obvious to the observer

# 8. Create (at least) 5 elegant graphs best describing the original data frame
# You can seek inspiration online
# For each plot, describe the reasoning behind your choice 
# and what it represents
# Try customizing your plots as much as possible and using the categorical
# variables to create stacked and dodges barplots
# Some ideas for plots:

# a) How many animals per vore?
# b) How many animals per vore and per conservation status?
# c) Create a multiple plot with the distribution of values for all 
# numeric variables. Try to also add fill based on vore
# d) Choose 2 numeric variables that make sense and create a scatter plot
# e) create a plot using facet_wrap for the variable you created earlier (rem_proportion)
# with regards tp vore and conservation

# 9. Save each plot you created as .png files and then save them all together 
# in a .pdf file



