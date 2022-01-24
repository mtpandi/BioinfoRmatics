#Excercises


# 1. ----------------------------------------------------------------------

# 1.Install and load the xlsx library
install.packages('xlsx')
library(xlsx)

#my bad... xlsx is kinda tricky to get working
#https://stackoverflow.com/questions/23209152/cannot-install-libraryxlsx-in-r-and-look-for-an-alternative



# 2. ----------------------------------------------------------------------
# 2. Modify the read.csv and read.table functions as appropriate 
# in order to load the .txt and .csv iris datasets.
# Change the column names

iriscsv <- read.csv('iris.csv', header = T, sep = ';')
names(iriscsv)[1] <- 'Sepal_length'
iriscsv <- iriscsv[-151,]

iristxt <- read.table('iris.txt', header = T, sep='\t')
iristxt <- iristxt[-151,]


# 3. ----------------------------------------------------------------------

# 3. Create vectors of 10 observations
# - a numeric one, named "Age"
# - a character one filled with random names for men and women, named "FirstName"
# - a character one with 2 categories (Male and Female) and convert it to a factor, named "Sex" 
# - a logical one, named "Smoking"

Age <- c(45, 73, 13, 98, 75, 46, 43, 63, 67, 32)

FirstName <- c('Ann', 'Mark', 'Mary', 'Lisa', 'Luke', 'Dan', 'John',
               'Mer', 'Christina', 'Baily')

Sex <- c('Female', 'Male', 'Female', 'Female', 'Male', 'Male', 'Male',
         'Female', 'Female', 'Female')

Sex <- as.factor(Sex)

Smoking <- c(0, 1, 1, 1, 0, 1, 0, 0, 1, 0)


# 4. ----------------------------------------------------------------------

# 4. Create a data frame with the previous 4 vectors
toydata <- data.frame(Age, FirstName, Sex, Smoking)


# 5. ----------------------------------------------------------------------

# 5. Which function(s) would you use to output 
#  -basic descriptive statistics
#  -the type of each variable
#  -the number of columns
#  -the number of rows
#from this data frame? -- present your proposals in a well-framed table

summary(toydata)
str(toydata)
class(toydata)
nrow(toydata)
ncol(toydata)


# 6. ----------------------------------------------------------------------

# 6. How many men are smoking? How many women are non-smokers?
table(toydata$Smoking, toydata$Sex)


# 7. ----------------------------------------------------------------------

# 7. Use xlsx library to load the iris.xlsx file

irisxl <- xlsx::read.xlsx('iris.xlsx', sheetIndex = 1)
irisxl <- irisxl[-151,]



# 8. ----------------------------------------------------------------------

# 8. Using the same library, save the data frame you have created as .xlsx
xlsx::write.xlsx(toydata, 'toydata.xlsx', sheetName = 'Test')



# 9. ----------------------------------------------------------------------

# 9a. Write two functions that return 
# - the minimum value 

minf <- function(inpvec){
  
  testmin <- inpvec[1]
  
  for(i in 1:length(inpvec)){
    if(inpvec[i]<testmin){
      testmin<-inpvec[i]
    }
  }
  
  return(testmin)
}


# - the sum of minimum and maximum values
# of a vector

sumf <- function(inpvec){
  
  testmin <- inpvec[1]
  
  for(i in 1:length(inpvec)){
    if(inpvec[i]<testmin){
      testmin<-inpvec[i]
    }
  }
  
  testmax <- inpvec[1]
  
  for(i in 1:length(inpvec)){
    if(inpvec[i]>testmax){
      testmax<-inpvec[i]
    }
  }
  
  res <- testmin + testmax
  
  return(res)
}

# 9b. Create a vector of 5 numeric observations (using 'seq') in [1,100] -- apply both functions here
testvec <- c(seq(from=1, to=100, length.out = 5))

minf(testvec)
sumf(testvec)


# 10. ---------------------------------------------------------------------

# 10. write a simple if...else control structure, that prints either "Yes" or "No"
# based on whether the condition you set is met

x <- TRUE

if(isFALSE(x)){
  print('YES')
}else{
  print('NO')
}

#You can use different conditions in order to use as many relational operators you can
# (the rest of the structure can be the same)

y<- FALSE

if(y<x){               #FALSE==0 and TRUE==1, so y is indeed smaller than 1
  print('YES')
}else{
  print('NO')
}

if(((y+x)!=0)&(y<x)){
  print('YES')
}else{
  print('NO')
}



# 11. ---------------------------------------------------------------------

# 11. write a for loop
# -create a vector of 5 numerical observations
# -use a for loop that for each observation of the vector (1:length(inputvector)) 
# calculates the square root of that observation
test <- c(25, 100, 256, 36, 81)

for(i in 1:length(test)){
  print(test[i]**(1/2))
}


# 12. ---------------------------------------------------------------------

# 12. Create a list containing a vector (of 6 observations), a number, two characters and one NA
testl1 <- list(c(56, 12, 6, 35, 76, 25), 
              426,
              'DNA', 
              'PGx', 
              NA)

testl2 <- list(vec = c(56, 12, 6, 35, 76), 
              numb = 426,
              char1 = 'DNA', 
              char2 = 'PGx', 
              nada = NA)

# -How do you get the 4th observation of the vector?
testl1[[1]][4]

#if the positions of the list were named:
testl2$vec[4]
testl2[['vec']][4]

# -Update that list with a second vector of the same length
testl1[[6]] <- c(seq(from=1, to=14, length.out = 6))

testl2[[6]] <- c(seq(from=1, to=14, length.out = 6))
testl2[['newvec']] <- c(seq(from=1, to=14, length.out = 6))
testl2$newvec <- c(seq(from=1, to=14, length.out = 6))


# -Remove the last value of that second vector
testl1[[6]][-6]
testl1[[6]][1:5]
testl1[[6]][-length(testl1[[6]])]

testl2[[6]][-6]
testl2[[6]][1:5]
testl2[[6]][-length(testl2[[6]])]

testl2$newvec[-6]
testl2$newvec[1:5]
testl2$newvec[-length(testl2$newvec)]

testl2[['newvec']][-6]
testl2[['newvec']][1:5]
testl2[['newvec']][-length(testl2[['newvec']])]


# -Remove the second vector completely
testl1[[6]] <- NULL
testl1<- testl1[1:5]

testl2[[6]] <- NULL
testl2<- testl2[1:5]
testl2[['newvec']] <- NULL
testl2$newvec <- NULL



