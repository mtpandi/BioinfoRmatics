
# dplyr -------------------------------------------------------------------

#load libraries
library(dplyr)


# load data
# we will explore the star wars characters
data <- starwars


# Get a glimpse of the data  -------------------------------------------------------------------
glimpse(data)

# what is now the class of "data"?
class(data)



# Rename columns ----------------------------------------------------------

#dplyr::rename(data, new_names = old_names)
rename(data, 'Hero' = 'name' )
data %>% rename('Hero' = 'name' ) %>% names
data %>% rename(c('Hero' = 'name',
                  'HEIGHT' ='height') ) %>% names

#data <- rename(data, 'Hero' = 'name' )


# Add or modify columns -------------------------------------------------------------

#modify existing columns
#let's change the height column to categorical 
#if less than 165 it becomes "short", if more than 165 it becomes "tall"
mutate(data, height = ifelse(height >= 165, "tall", "short")) 
data %>% mutate(height = ifelse(height >= 165, "tall", "short")) %>% View


#we might not want to modify an exhisting one but add a new
# whose values are based on an existing (e.g. height)

mutate(data, heightcat = ifelse(height >= 165, "tall", "short"))
data %>% mutate(heightcat = ifelse(height >= 165, "tall", "short")) %>% View


#add an entirely new variable
#let's say we have another variable, called newcol
mutate(data, newcol = 'blah')

data %>% mutate(newcol="blah",
                heightcat = ifelse(height >= 165, "tall", "short")) %>% View

#or we can use bind_cols
data %>% bind_cols(newcol=c(rep('blah', 87))) %>% View

# Select or remove columns ----------------------------------------------------------

#select by name columns
select(data, name)
data %>% select(c(name, height)) %>% names()

#remove by name columns
select(data, -name)
data %>% select(-c(name,height)) %>% names()


# Add rows -----------------------------------------------------

# just like before, use bind_rows
bind_rows(data[3,], data[12,]) %>% View()


# Filter rows  ------------------------------------------

#  based on condition (filter)
# let's get only male characters
data %>% filter(sex=='male')

#base on their position (Slice)
data %>% slice(1:3)
data %>% slice_head(n=4)
data %>% slice_tail(n=4)
data %>% slice_max(order_by = mass, n=2)
data %>% slice_min(order_by = mass, n=2)
data %>% slice_sample(n=87*0.1)
data %>% slice_sample(prop = 0.1)

#order_by is a helper function





# Arrange the observations ------------------------------------------------

data %>% arrange(mass)  #data re-ordered based on increasing mass
data %>% arrange(mass, sex)

data %>% arrange(desc(mass)) #data re-ordered based on descending mass

# desc is another helper function used with higher level ordering functions


# Group and Summarise ----------------------------------------------------------------

# me might want to group our data, using some categorical variable
# and then compute some statistic for each group


# group_by(grouping_variables) : groups the data
# ungroup() : undoes what group_by does

#summarise(grouped_data, summarization_function)
# e.g. What is the mean height for each gender in starwars dataset?

data %>% group_by(sex) %>% summarise(count = mean(height, na.rm = TRUE))

# other summarization functions:
# min(), max(), median(), first(), last(), nth(), n(): number,
# sd(): standard deviation, var(): variance 



# Joining data frames -----------------------------------------------------

df1 <- data[1:10, 1:3]
df2 <- data[8:20, c(1, 4:6)]

#column name is the key to combine the 2 data frames


#left join: keep the observations from the left sided 
# dataframe and add the columns from both

left_join(df1, df2, by='name')

#right_join: keep the observations from the right sided 
# dataframe and add the columns from both

right_join(df1, df2, by='name')


#inner_join: keep only the observations that are common 
# in the two dfs

inner_join(df1, df2, by='name')

#full join: all observations

full_join(df1, df2, by='name')

#anti_join: observations from the left-sided df, not found
# in the right sided

anti_join(df1, df2, by='name')

# Useful functions --------------------------------------------------------

#case_when: implementation of nested ifelse

# back on the example where we created a new column based on height
# now, we are interested in creating more than 2 height categories
# <=100 : short, 100<x<=160 : normal, 160<x<=190 : tall, >190 : giant

# we need 3 nested ifelses
data %>%
  mutate(heightclass = ifelse(height<=100, 'short',
                              ifelse((height>100)&(height<=160), 'normal',
                                     ifelse((height>160)&(height<=190), 'tall',
                                            'giant')))) %>%
  select(height, heightclass) %>%
  View()


# or, we could use 1 case_when
data %>%
  mutate(heightclass = case_when(
    is.na(height) ~ NA_character_,
    height<=100 ~ 'short',
    (height>100)&(height<=160) ~ 'normal',
    (height>160)&(height<=190) ~ 'tall',
    TRUE ~ 'giant'
  )) %>%
  select(height, heightclass) %>%
  View()

# case_when(
#    condition1 ~ option1,
#    condition2 ~ option2,
#         ......
#    TRUE ~ finaloption )
#  TRUE here stands for "in any other case"


# distinct(.data, columnsofinterest, .keep_all = T/F) 
# Remove duplicates and keep 1st observation of each category
# distinct helps as select the unique observations, 
# based on the values of one or more columns
# setting .keep_all as TRUE returns only the unique rows
# and all the columns, while FALSE returns only the columns
# that were used for the distinction

distinct(data, homeworld, .keep_all = F)
distinct(data, homeworld, .keep_all = T)


#count(): count the number of observations that bbelong to a group
data %>% 
  group_by(species) %>%
  count()

# rowwise(): apply an operation to rows
data %>%
  rowwise() %>%
  mutate(meanval = mean(c(height, mass))) %>%
  select(height, mass, meanval) %>% 
  head(5)


# the %in% operator
#helps us check whether a value belongs in a list of values
c('cat', 'dog', 'bird', 'cat') %in% c('bird', 'dog')

data %>%
  mutate(friend = ifelse(species %in% c('Human', 'Wookiee', 'Droid'),
                         'YES', 
                         'NO')) %>%
  select(species, friend) %>% 
  View()


# A sequence of operations in starwars data -------------------------------

data %>%
  select(species, gender) %>%
  group_by(species, gender) %>%
  summarise(count = n())
  
data %>%
  filter(gender!='masculine') %>%
  select(height, mass, species) %>%
  filter(!(is.na(height)|is.na(mass))) %>%
  mutate(BMI = ( mass / ((height/100)^2))) %>%
  group_by(species) %>%
  summarise(medianBMI = median(BMI))


# Elegant Plotting  ----------------------------------------------------
library(ggplot2)

#we start by removing the last 3 columns 

data <- data %>%
  select(1:11) 

# Remeber:  NAs are plotted too, so you can use na.rm=TRUE to remove them


# *Scatterplots ----------------------------------------------------------

# a simple scatter plot of height and mass

ggplot(data, aes(mass, height)) + 
  geom_point() 

# you can customize the points
ggplot(data, aes(mass, height)) + 
  geom_point(size=2, shape=23) 

# maybe add titles
ggplot(data, aes(mass, height)) + 
  geom_point() +
  ggtitle('Starwars') + 
  xlab('Mass of character (kg)') +
  ylab('Height of character (cm)')

#what if we want to add colour based on the gender of each character?
# add it as an aesthetic
ggplot(data, aes(mass, height, color = gender)) + 
  geom_point() +
  ggtitle('Starwars') + 
  xlab('Mass of character (kg)') +
  ylab('Height of character (cm)')

# or add a different color to points
ggplot(data, aes(mass, height)) + 
  geom_point(color='red') +
  ggtitle('Starwars') + 
  xlab('Mass of character (kg)') +
  ylab('Height of character (cm)')


#maybe add a smoothed line to help you observe any patterns
ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  geom_point() +
  geom_smooth() + 
  ggtitle('Iris dataset') + 
  xlab('Sepal Length') +
  ylab('Sepal Width')


# linear model per Species
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) + 
  geom_point() +
  geom_smooth(method = 'lm',  se=TRUE) + # se determines the confidence intervals
  ggtitle('Iris dataset') + 
  xlab('Sepal Length') +
  ylab('Sepal Width')


#text instead of points
ggplot(data, aes(x=mass, y=height)) +
  geom_point() +
  geom_text(aes(label = name), check_overlap = T)


# *Histograms --------------------------------------------------------------

 
# plot a single continuous variable

ggplot(data, aes(height)) + 
  geom_histogram() 

ggplot(data, aes(height)) + 
  geom_freqpoly()

# you can make your bins more narrow and your plots more detailed
# by altering binwidth argument
ggplot(data, aes(height)) + 
  geom_histogram(binwidth = 1) 

# Density plot ------------------------------------------------------------

ggplot(data, aes(height)) + 
  geom_density()

# alpha : color opacity (0-1)
ggplot(data, aes(height, fill=gender)) + 
  geom_density(alpha=0.4)

# *Bar plots --------------------------------------------------------------

# for categorical variables
ggplot(data, aes(sex)) +
  geom_bar()

# Horizontal bar plot
ggplot(data, aes(sex)) +
  geom_bar() + 
  coord_flip()

#maybe add a second categorical variable
# does gender affect sex?
ggplot(data, aes(sex, fill = gender)) +
  geom_bar(position = 'stack') #stacked

ggplot(data, aes(sex, fill = gender)) +
  geom_bar(position = 'dodge') #dodged

#add text that shows how many characters belong to each category
# for geom_text we need to define at least the label argument
ggplot(data, aes(sex)) +
  geom_bar() +
  geom_text(stat='count', aes(label=..count..), vjust=-1)

# now, let's do a bar plot with percentages
ggplot(data, aes(sex)) +
  geom_bar(aes(y=(..count..)/sum(..count..))) +
  scale_y_continuous(labels=scales::percent) +
  ylab("relative frequencies")

# and add text
ggplot(data, aes(x= sex)) + 
  geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent((..count..)/sum(..count..)),
                 y= (..count..)/sum(..count..) , group=1), stat= "count", vjust = -.5) +
  labs(y = "Percent", fill="sex") +
  scale_y_continuous(labels = scales::percent)


# *Boxplot ----------------------------------------------------------------


# so, lets run a summary for mass
summary(data$height)

#and now plot it
ggplot(data, aes(y=height)) +
  geom_boxplot()

# what of we are interested in height per gender
# add an extra aesthetic determined by gender
# color : an outline
# fill : the color that fills the boxplot
ggplot(data, aes(y=height, x = gender, fill=gender)) +
  geom_boxplot()

# add statistic summaries : add mean
ggplot(data, aes(y=height, x = gender, fill=gender)) +
  geom_boxplot() + 
  stat_summary(fun.y=mean, geom="point", shape=23, size=1)

# a beautiful variation of boxplots : violin plots
ggplot(data, aes(y=height, x=gender, fill=gender)) +
  geom_violin()

#change the order of elements
ggplot(data, aes(y=height, x=gender, fill=gender)) +
  geom_violin() +
  scale_x_discrete(limits=c(NA, 'feminine', 'masculine'))

# *Aesthetics overriding --------------------------------------------------
ggplot(data, aes(mass, height, color= gender)) +
  geom_point() +
  xlim(NA, 200)

ggplot(data, aes(mass, height, color= gender)) +
  geom_point(aes(color = sex)) +
  xlim(NA, 200)


# *Titles -----------------------------------------------------------------

#let's create a simple violin plot to use as a base
plot <- ggplot(data, aes(y=height, x=gender, fill=gender)) +
  geom_violin()

# main
plot + ggtitle('Height of character per gender')

# axes
plot + xlab('Gender of character')
plot + ylab('Height of character')

# legends
plot + labs(title = 'Height of character per gender', 
            y ='Height of character', 
            x = 'Gender of character', 
            fill = '*Gender*')  # fill, colour, whatever else we want

# in addition we can adjust the looks of the titles in theme(), using element_text()
plot + theme(
  plot.title = element_text(),
  axis.title.x = element_text(),
  axis.title.y = element_text(),
  legend.title = element_text())


# arguments we can add to element_text()
#family : font family
#face : font face. Possible values are “plain”, “italic”, “bold” and “bold.italic”
#colour : text color
#size : text size in pts
#hjust : horizontal justification (in [0, 1])
#vjust : vertical justification (in [0, 1])


# *Legends ----------------------------------------------------------------
# change the legend's position 
# use a character [ “left”,“top”, “right”, “bottom” ]
# or use a vector with x and y coordinates [c(x,y)]
plot + theme(legend.position = 'top')

# remove the legend
plot + theme(legend.position = 'none')


# *Colours ----------------------------------------------------------------

# change the hue
plot + scale_fill_hue(l=40, c=35)
# alternatively, scale_colour_hue(lightness, chroma- color intensity)

# change colours in continuous axes
ggplot(data, aes(mass, height, color = birth_year)) + 
  geom_point() +
  scale_color_gradient(low="blue", high="purple")


# while in discrete axes:

# manually add colors
plot + 
  scale_fill_manual(values=c( "#004986", "#FFC845"))

#use a palette
library(RColorBrewer)
plot + 
  scale_fill_brewer(palette="Dark2")



#  Themes -----------------------------------------------------------------

# black and white 
plot + theme_bw()

# grey (the default)
plot +  theme_grey()

# classic
plot + theme_classic()

# minimal
plot + theme_minimal()

# just the data
plot + theme_void()

# dark
plot + theme_dark()

# light
plot + theme_light()


# *Multiple plots ---------------------------------------------------------

# we can use par() to combine individual plots as previously
par(mfrow=c(2,2))


#  *Faceting --------------------------------------------------------------
# and we can facet - create the same plot for subsets of the data
# each subset is created according to a categorical variable

# facet_wrap
# plot the height in a barplot for each sex
ggplot(data, aes(height)) +
  geom_bar() +
  facet_wrap(~sex)
  

# facet_grid
# what if we want to create the first scatter plot, but now for
# every gender separetely
ggplot(data, aes(mass, height)) +
  geom_point() + 
  facet_grid(rows = vars(gender))

ggplot(data, aes(mass, height)) +
  geom_point() + 
  facet_grid(cols = vars(gender))

# and now use sex as well
ggplot(data, aes(mass, height)) +
  geom_point() + 
  facet_grid(rows = vars(gender), cols = vars(sex))

#maybe we just want to use sex to add color
ggplot(data, aes(mass, height, color = sex)) +
  geom_point() + 
  facet_grid(rows = vars(gender))

# Saving the plots --------------------------------------------------------
ggsave('plot.png', plot, 
       #scale = 2,
       height = 10,
       width = 5,
       units = 'in',
       dpi = 600)



# *Viridis ----------------------------------------------------------------

# and now, my favorite color palette out there

# plots courtesy of Y. Wendy Huynh https://bookdown.org/yih_huynh/Guide-to-R-Book/
# and Ariel E. Meilij https://rpubs.com/ameilij/EDA_lesson3

library(viridis)

df <- diamonds


ggplot(df, aes(price)) + 
  geom_histogram() +
  ggtitle("Diamond Price Distribution") + 
  xlab("Diamond Price U$") + 
  ylab("Frequency") + 
  theme_light() 


ggplot(df, aes(clarity, price, color=clarity)) + 
  geom_boxplot() + 
  ggtitle("Diamond Price according Clarity") + 
  xlab("Clarity") + ylab("Diamond Price U$") + 
  scale_color_viridis(discrete = TRUE) +
  theme_minimal()

ggplot(df, aes(x=cut, fill=color)) +
  geom_bar()  + 
  scale_fill_viridis(discrete = TRUE, option = 'cividis') + 
  theme_light()

ggplot(df, aes(carat, price, color = clarity)) + 
  geom_point() +
  scale_color_viridis(discrete = TRUE, option = 'magma') 

ggplot(df, aes(price, fill = cut)) + 
  geom_histogram() +
  ggtitle("Diamond Price Distribution by Cut") + 
  xlab("Diamond Price U$") + 
  ylab("Frequency") + 
  theme_minimal() + 
  facet_wrap(~cut) +
  scale_fill_viridis(discrete = TRUE)

diamonds %>% 
  group_by(clarity, cut) %>% 
  summarize(m = mean(price)) %>% 
  ggplot(aes(x = clarity, y = m, group = cut, color = cut)) +
  geom_point() +
  geom_line() +
  theme_light() +
  facet_wrap(~cut)
