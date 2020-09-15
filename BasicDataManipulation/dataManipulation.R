
# load the data directly from R
iris.data <- iris


# Get a glimpse of the data  -------------------------------------------------------------------

#get summary statistics and structure
str(iris.data)  #structure and classes of columns (Variables)
summary(iris.data) 
names(iris.data)
class(iris.data)
dim(iris.data)
nrow(iris.data)  # number of observations
ncol(iris.data)  # number of variables

#get a glimpse of the data
head(iris.data, n=5)
View(iris.data)  #open the entire data frame

head(iris.data$Sepal.Length, 5)  #get first rows of  specific column

tail(iris.data, 5)



# Rename columns ----------------------------------------------------------


#by name
names(iris.data)[names(iris.data)=='Sepal.Length'] <- 'SL'

#by position
names(iris.data)[2] <- 'SW'



# Add columns -------------------------------------------------------------

#let's say we have another variable, called Genus
Genus_vec <- c(rep('Iris', 150))


#we can add it using cbind (baseR)
cbind(iris.data, Genus_vec)

#or we can use brackets, or the dollar operator
iris.data$Genus <- Genus_vec
iris.data['Genus'] <- Genus_vec
iris.data[6] <- Genus_vec



# Remove columns ----------------------------------------------------------

iris.data$Genus  <- NULL
iris.data[["Genus"]] <- NULL
iris.data[,"Genus"]  <- NULL
iris.data[[6]]  <- NULL
iris.data[,6]  <- NULL
iris.data[,-6]
iris.data[,-c(2,6)]


# Add and remove rows -----------------------------------------------------

#add rows
rbind(iris.data, c(6.3, 2.1, 5.0, 2.6, 'virginica')) 
#or add a second df with the exact same columns : rdbind(iris.data, df2)

#remove rows
iris.data[-1,]
iris.data[-1:10,]
iris.data[-(row.names(iris.data)==1),] #by row name



# Filter rows based on condition ------------------------------------------


#e.g., all rows with Species==setosa
iris.data[iris.data['Species']=='setosa',]
iris.data[iris.data$Species =='setosa',]

#or all rows whose Sepal length is larger than 5.5
iris.data[iris.data['Sepal.Length']>5.5,]
iris.data[iris.data$Sepal.Length > 5.5,]

#or both
iris.data[(iris.data['Species']=='setosa')&(iris.data['Sepal.Length']>5.5),]
iris.data[(iris.data$Species=='setosa')&(iris.data$Sepal.Length>5.5),]

#what if we want only the petal lengths and widths of the above observations?
iris.data[(iris.data['Species']=='setosa')&(iris.data['Sepal.Length']>5.5),
          c('Petal.Length', 'Petal.Width')]
iris.data[(iris.data$Species=='setosa')&(iris.data$Sepal.Length>5.5),
          c('Petal.Length', 'Petal.Width')]



# Applying functions in data frames ---------------------------------------


#what if we need the mean numeric variables per column?

#we can use a for loop 
#mean per numeric column

total <- 0  #initiallize to 0 a variable to store the sum
for(i in 1:length(iris.data$Sepal.Length)){
  total <- sum(total, iris.data$Sepal.Length[i])
}
mean_val <- total/length(iris.data$Sepal.Length) #mean sepal length
print(paste0(names(iris.data)[1], ' : ' ,mean_val))


for(n in 1:4){
  total <- 0  #initiallize to 0 a variable to store the sum
 
   for(i in 1:length(iris.data[,n])){
    total <- sum(total, iris.data[i,n])
  }
  mean_val <- total/length(iris.data[,n]) #mean sepal length
  print(paste0(names(iris.data)[n], ' : ' ,mean_val))
  
}

#what if we want to add a new column containing the sum of all numeric variables of a row?

sums <- list()

for(i in 1:nrow(iris.data)){
  sums[i] <- sum(iris.data[i, 1:4])
}

sums <- unlist(sums)

iris.data$sums <- sums


#that was not to bad. But what if the df is too big?
# we have the "apply" family

#the more general apply(X, MARGIN, FUN, …)  | Margin: 1: rows, 2: columns
#Returns a vector/array/list of values obtained by applying a function to margins of an array or matrix.

apply(iris.data[,1:4], 2, mean)  #named vector
apply(iris.data[,1:4], 1, mean) #numeric vector


#lapply(X, FUN, …) : Applies a Function over a List or Vector and returns a list of values
lapply(iris.data$Sepal.Length, sum)
str(lapply(iris.data$Sepal.Length, sum))
unlist(lapply(iris.data$Sepal.Length, sum), recursive = F)

unlist(list('a', 'nba', 987, list(6546,6496,35)))


#sapply(X, FUN, …, simplify = TRUE, USE.NAMES = TRUE)
#Applies a function over a list/vector/data frame and returns a vector or matrix
sapply(iris.data[1:2], sum)
sapply(iris.data$Sepal.Length, sum)


#tapply(X, INDEX, FUN = NULL, …, default = NA, simplify = TRUE)
#Applies a function for each factor variable in a vector

#organizes data according to a factor(Species) and applies a function in each group
tapply(iris.data$Sepal.Length, iris.data$Species, min)



# Handling missing values -------------------------------------------------

#let's suppose there is a vector c(8, 4, 9, NA, 43)
#the mean of that vector cannot be calculated unless we add the argument na.rm=TRUE
mean(c(8, 4, 9, NA, 43))
mean(c(8, 4, 9, NA, 43), na.rm = TRUE)  #first removes NAs and then calculates the mean


#let us create a df where 20% of the values are randomly replaced by NAs
set.seed(170794)   #when there is an element of randomness we always set a seed -> reproducible code
iris.na <- as.data.frame(lapply(iris.data[,-5], 
                                function(x) x[ sample(c(TRUE, NA), 
                                                      prob = c(0.80, 0.20), 
                                                      size = length(x), 
                                                      replace = TRUE) ]))
iris.na <- cbind(iris.na, iris.data$Species)

#first check if we have any NAs at all
anyNA(iris.data)
anyNA(iris.na)

#is it all NAs?


#NAs per column
sum(is.na(iris.na$Sepal.Length))

#NAs per row
sum(is.na(iris.na[2,]))
rowSums(is.na(iris.na))

#apply it in the entire df
colSums(is.na(iris.na))
apply(iris.na,2, function(x)sum(is.na(x)))
apply(iris.na,1, function(x)sum(is.na(x)))

#handling missing data

#1. Ignore 

#2. Remove all rows with NAs
iris.na[!anyNA(iris.na),]
iris.na[complete.cases(iris.na),]
na.omit(iris.na)

#loss of possibly important data

#3. Replace with column mean --- some say it is a "statistical malpractice" 
for(i in 1:4){
  iris.data[is.na(iris.na[,i]), i] <- mean(iris.data[,i], na.rm = TRUE)
}

#4. Replace with mean per group
df1 <- iris.data[iris.data$Species=='setosa',]
df2 <- iris.data[iris.data$Species=='virginica',]
df3 <- iris.data[iris.data$Species=='versicolor',]

for(df in c(df1, df2, df2)){
  for(i in 1:4){
    df[is.na(df[,i]), i] <- mean(df[,i], na.rm = TRUE)
  }
}

rbind(df1, df2, df3)

#5. Multiple Imputation (MICE, Amelia, missForest, Hmisc, mi)




# Basic Plotting  ----------------------------------------------------



# *Histograms --------------------------------------------------------------

hist(iris.data$Sepal.Length, freq = T,
     main = 'Sepal Length of Iris', xlab = 'Sepal Length', labels = T)



# *Density plots ----------------------------------------------------------

plot(density(iris.data$Sepal.Length), main = "Density of Iris' Sepal Length")



# *Bar plots --------------------------------------------------------------

#say we want the mean sepal length per category 
tapply(iris.data$Sepal.Length, iris.data$Species, mean)
barplot(tapply(iris.data$Sepal.Length, iris.data$Species, mean),
        main="mean Sepal Length",
        xlab="Iris species", 
        horiz= F)

#stacked bar plot -> let's use an example df from R01-lab

toydata <- data.frame(Age = c(45, 73, 13, 98, 75, 46, 43, 63, 67, 32), 
                      FirstName = c('Ann', 'Mark', 'Mary', 'Lisa', 'Luke', 
                                'Dan', 'John','Mer', 'Christina', 'Baily'), 
                      Sex = as.factor(c('Female', 'Male', 'Female', 'Female', 'Male', 'Male', 'Male',
                              'Female', 'Female', 'Female')), 
                      Smoking = as.factor(c('No', 'No', 'Yes', 'Yes', 'No', 
                                        'Yes', 'No', 'Yes', 'Yes', 'No')))

barplot(table(toydata$Smoking, toydata$Sex),
        main = 'Smoking status per gender',
        xlab = 'Gender',
        legend = rownames(table(toydata$Smoking, toydata$Sex)),
        col=c("darkblue","green"), 
        ylim = c(0,8),
        beside = T,
        horiz= F)



# *Piie charts ------------------------------------------------------------

pie(table(iris.data$Species), 
    labels = paste(names(table(iris.data$Species)), "\n", 
                                             table(iris.data$Species), sep=""),
    main="Pie Chart of Species\n (with sample sizes)") 



# *Boxplot ----------------------------------------------------------------

boxplot(iris.data$Sepal.Length ~ iris.data$Species, main='Iris',
        xlab='Species', ylab= 'Sepal Length', horizontal = F, 
        col=c("blue","orange","green"))




# *#Points(scatter plot) and lines ----------------------------------------

plot(iris.data$Sepal.Length, type = 'l', main = 'Sepal Length of Iris', 
     ylab = 'Sepal Length')  #l for line
plot(iris.data$Sepal.Length, type = 'p', main = 'Sepal Length of Iris', 
     ylab = 'Sepal Length')  #p for points
plot(iris$Sepal.Length, type = 'o', main = 'Sepal Length of Iris', 
     ylab = 'Sepal Length')  #o for overplotted
plot(x=iris$Petal.Length, y=iris$Petal.Width, type = 'p', main = 'Iris', 
     ylab='Petal Width', xlab = 'Petal Length')  #bivariate


#costumizing
plot(iris.data$Sepal.Length, type = 'l', lty = 2, #line type
     lwd = 2,  #line width
     main = "Iris",  ylab = "Petal Length")

plot(iris.data$Petal.Length, iris.data$Petal.Width, pch = 8,
     main = "Iris", xlab = "Petal Length", ylab = "Petal Width")

plot(iris.data$Petal.Length, iris.data$Petal.Width, pch = 8, col = 'green',
     main = "Iris Data", xlab = "Petal Length", ylab = "Petal Width")


plot(iris.data$Petal.Length, iris.data$Petal.Width, pch = 8, col = '#660033',
     main = "Iris Data", xlab = "Petal Length", ylab = "Petal Width",
     xlim = c(0,10), ylim= c(0,10))

plot(iris.data$Petal.Length, iris.data$Petal.Width, 
     col =iris.data$Species,
     main = "Iris Data", xlab = "Petal Length", ylab = "Petal Width",
     xlim = c(0,10), ylim= c(0,10))
legend('topright', legend = levels(iris.data$Species), 
       col=1:3, pch=1)


cols <- c("green","blue","orange")
plot(iris.data$Petal.Length, iris.data$Petal.Width, 
     col = cols[iris.data$Species], pch=19,
     main = "Iris Data", xlab = "Petal Length", ylab = "Petal Width",
     xlim = c(0,10), ylim= c(0,10))
legend("topleft", legend = levels(iris.data$Species), 
       col = cols, pch = 19, bty = "n")

#More complex plots
plot(Sepal.Length ~ Sepal.Width, iris.data, las=1, type="n")
points(Sepal.Length ~ Sepal.Width, subset(iris.data,Species=="setosa"),
       pch=1)
points(Sepal.Length ~ Sepal.Width, subset(iris.data,Species=="versicolor"),
       pch=10)
points(Sepal.Length ~ Sepal.Width, subset(iris.data,Species=="virginica"),
       pch=19)

set.iris <- subset(iris.data,Species=="setosa",pch=1)
ver.iris <- subset(iris.data,Species=="versicolor",pch=10)
vir.iris <- subset(iris.data,Species=="virginica",pch=19)

plot(Sepal.Length ~ Sepal.Width, iris) 
  par(las=0)
  points(Sepal.Length ~ Sepal.Width, subset(iris.data,Species=="setosa"),
         pch=1, col="blue")
  points(Sepal.Length ~ Sepal.Width, subset(iris.data,Species=="versicolor")
         ,pch=10, col="orange")
  points(Sepal.Length ~ Sepal.Width, subset(iris.data,Species=="virginica"),
         pch=19, col="green")
  abline(lm(Sepal.Length ~ Sepal.Width, set.iris),lty=1, col="blue")
  abline(lm(Sepal.Length ~ Sepal.Width, ver.iris),lty=2, col="orange")
  abline(lm(Sepal.Length ~ Sepal.Width, vir.iris),lty=3, col="green")
  title(xlab="Sepal Width", ylab="Sepal Length", col.lab="yellow")
  legend("topleft", cex=0.8, bty="n", 
         title="Species", c("I. setosa","I. versicolor","I. virginica"), 
         fill=c("blue", "orange","green"))
  



# *Multiple plots ---------------------------------------------------------

par(mfrow=c(2,2))
boxplot(iris.data$Sepal.Length~iris.data$Species, 
        main = "Boxplot of Sepal Length",
        xlab = "Species", ylab = "Sepal Length", 
        col = c("red","green3","blue"),
        cex.lab = 1.25)
hist(iris.data$Sepal.Length, main = "Histogram of Sepal Length",
     xlab = "Sepal Length", ylab = "Frequency", 
     col = c("grey"), cex.lab = 1.25)
plot(iris.data$Sepal.Length, type = 'l', lty = 2, lwd = 2, col = 'red',
     main = "Variation with of Petal Width and Petal Length",
     xlab = "Petal Length", ylab = "Petal Width", cex.lab = 1.25)
plot(iris.data$Petal.Length, iris.data$Petal.Width, pch = 8, col = 'yellow',
     main = "Scatter plot of Petal Width and Petal Length",
     xlab = "Petal Length", ylab = "Petal Width", cex.lab = 1.25)

#saving the plots
pdf("myplot.pdf")
boxplot(Sepal.Length~Species,data = iris.data,
        main = "Boxplot of Sepal Length",
        xlab = "Species", ylab = "Sepal Length", 
        col = c("yellow","green3","blue"))
dev.off()

png(filename = "myplot.png", width = 200, height = 300, 
    units = "cm", res = 300)
boxplot(iris.data$Sepal.Length~iris.data$Species, 
        main = "Boxplot of Sepal Length",
        xlab = "Species", ylab = "Sepal Length", 
        col = c("yellow","green3","blue"))
dev.off()


