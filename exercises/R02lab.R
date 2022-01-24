
# R02 Lab -----------------------------------------------------------------

# In the following exercises you will work with the diamonds dataset 
# which can be found in ggplot2 library. It contains information about the 
# prices and a series of other attributes for about 54,000 diamonds. You will 
# perform basic data, manipulation, extract summary statistics and visualize 
# interesting elements of this dataset, without loading any library. 



# Diamonds dataset --------------------------------------------------------

#The variables you will find in diamonds are:

# price: the price in US dollars 
# carat: weight of the diamond 
# cut: quality of the cut (Fair, Good, Very Good, Premium, Ideal)
# color: diamond colour, from D (best) to J (worst)
# clarity: a measurement of how clear the diamond is 
      #(I1 (worst), SI2, SI1, VS2, VS1, VVS2, VVS1, IF (best))
# x: length in mm 
# y: width in mm 
# z: depth in mm 
# depth: total depth percentage = z / mean(x, y) 
# table: width of top of diamond relative to widest point 


#load the data from ggplot2

diamonds <- ggplot2::diamonds



# Data manipulation -------------------------------------------------------

# 1. Alter the names of x, y and z columns (try not to use any reserved words)


# 2. Describe exhaustively the dataset

# 3. Create a new numeric column (named expensive) that takes 1 (==YES) if a 
# diamond's price is above the mean of that column or 0 (==NO) if it is below 
# that value


# 4. Create a second dataframe containing only the "expensive" diamonds, 
# of the best clarity

# 5. What is the mean cost of those diamonds? How many cost below and how
# many above that price point?

# 6. Apply a function to the original diamonds dataframe that returns the
# median value of numerical characteristics for each diamond cut. For 
# categorical variables you should return the mode [Q: what is the mode and 
# how is it computed?]

# 7. Use diamonds to create a new data frame that contains 30% missing values.
# a) How many NAs per row?
# b) How many NAs per column?
# c) How many NAs in total?
# d) Perform imputation of missing values with the mean (for numeric variables)
# or the mode (for categorical ones)


# Visualization -----------------------------------------------------------

# 8. Create (at least) 5 graphs best describing the original dataframe
# You can seek inspiration online but you can't use ggplot2
# For each plot, describe the reasoning behind your choise 
# and what it represents
# Try customizing your plots as much as possible and using the categorical
# variables to create stacked barplots

# 9. Save each plot you created as .png files and then save them all together 
# in a .pdf file
 
# 10. Create a multiple plot and save the results in a .pdf format
# You might use exhisting plots or create new ones

