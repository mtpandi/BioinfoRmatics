
# set a working direcory  -------------------------------------------------
setwd("C:/Users/user/Desktop/PhD")

# check R version ---------------------------------------------------------

#type "version" on the console



# Install Libraries -------------------------------------------------------

### from CRAN
#install.packages('PackageName')

install.packages("praise")

### from Bioconductor
# if (!requireNamespace("BiocManager", quietly = TRUE)){
#   install.packages("BiocManager")
#   }
# BiocManager::install(“PackageName”)

if (!requireNamespace("BiocManager", quietly = TRUE)){
  install.packages("BiocManager")
  }
BiocManager::install("biomaRt")


### from github
# if (!requireNamespace("devtools", quietly = TRUE)){
#   install.packages("devtools")
# }
# devtools::install_github("DeveloperName/PackageName")

if (!requireNamespace("devtools", quietly = TRUE)){
  install.packages("devtools")
}
devtools::install_github("hadley/dplyr")



# load libraries ----------------------------------------------------------

# library(PackageName)
# PackageName::function

library(dplyr)
praise::praise()



# update R  ---------------------------------------------------------------

#if necessary - this step should be done on R's GUI
install.packages('installr')
installr::updateR() 




# Creating variables ------------------------------------------------------

x <- 5
45 -> y
x = 12
x <<- 5
8 ->> x

data <- 5
.data <- 3  # acceptable but not a good idea
data_2 <- 5
data.2 <- 5
5data <- 5
_data <- 5
Data <- 7




# Operators in R ----------------------------------------------------------

#arithmetic
5 + 3
5 - 8
5*2
6/2
7/2
7%%2
7%/%2
7^4
7**4

#relational
x <- 12
y <- 50

x>y
x>=y
x<y
x<=y
x==y
x!=y

#logical
(x>3)&(y<67)
(x>3)|(y<67)
!(y<67)
z <- c(2, NA, 7, 28, 9, 1000)
z[z>10]


z[!(z>25)]
z[is.na(z)]

z[!is.na(z)]





# Control Structures - Decision Making ------------------------------------

#if(condition){action}

x<-2

if(x>=3){
  print('It is!')
}

#if(condition){action}else{alternative}
x<-3
if(x<4){
  print('Yes')
}else{
  print('No')
}

#ifelse(condition, action, alternative)
x<-5
ifelse(x>4, print('Yes'), print('No'))


#switch(expression, case1, case2, case3, ...)

switch('sdf',  #expression
       foo={ print('foo')},  #case 1
       bar={ print('bar')},  #case2
       { print('default')}   #default
)





# Control Structures - Loops ----------------------------------------------

#for (value in vector) { statements }

for(i in 5:15){
  print(paste0('The number is ', i))
}

#while (test_expression) { Statement }

i <- 11
while(i<=10){
  print(paste0('The number is ', i))
  i <- i+1
}

# repeat {  commands     
#   if(condition) { break }
# }

i <- 1
repeat {
  print(i)
  i = i+1
  if (i > 10){
    break
  }
}







# Functions ---------------------------------------------------------------

#examples of built-in functions
exp(15)
abs(-89)
sqrt(89)
log()
log2()
log10()
factorial()
round(x, diggits = )
sin()
cos()
tan()
mean(x, trim=0, na.rm=TRUE)
sd()
median()
seq(from , to, by)
rep(x, ntimes)

#for strings
toupper()
tolower()
substr(x, start=n1, stop=n2)
grep(pattern, x , ignore.case=FALSE, fixed=FALSE)
sub(pattern, replacement, x, ignore.case =FALSE, fixed=FALSE) 
strsplit(x, split)
paste(..., sep="") 


#user defined functions

# functionname <- function(inputs){
#   body of function
#   return()
# }


#lets write the function for finding the mean of a vector
inp <- c(seq(2, 17, 1.5))


vecmean(z2)
mean(z2)

#I can also load my functions from external scripts using source('path-to-function/function.R')
source('vecmean.R')
vecmean(inp)


# Data input and output ---------------------------------------------------

read.table(file, header = FALSE, sep = "")

read.csv(file, header = TRUE, sep = ",")

read.csv2(file, header = TRUE, sep = ";")

read.delim(file, header = TRUE, sep = "\t")

read.delim2(file, header = TRUE, sep = "\t")


write.table(x, file = "",  sep = " ", row.names = TRUE)

write.csv(x, file = "",  sep = " ", row.names = TRUE)
write.csv2(x, file = "", sep = " ", row.names = TRUE)

#For example
write.csv(df, 'C:/Users/user/Desktop/PhD/Rintro/testdf.csv', sep=';', row.names = F)

#When working with excel files we need additional libraries
#readxl (read only)
readxl::read_excel(path, sheet = NULL)

readxl::read_xls(path, sheet = NULL)

readxl::read_xlsx(path, sheet = NULL)

#xlsx (read and write excel files)
xlsx::read.xlsx(file, sheetIndex, sheetName = NULL)

xlsx::read.xlsx2(file, sheetIndex, sheetName = NULL)

xlsx::write.xlsx(x, file, sheetName = "Sheet1", row.names = TRUE,
                 append = FALSE, showNA = TRUE,)

xlsx::write.xlsx2(x, file, sheetName = "Sheet1", row.names = TRUE, append = FALSE)


# Data Types -----------------------------------------------


#numeric
x <- 10
str(x)   #get a glimpse of a variable's structure
x <- 1.4
str(x)

#integer (integer number followed by L)
x <- 3L     
str(x)

#character
x <- 'Everybody loves R'     
str(x)
nchar(x)

#logical
x <- TRUE     
str(x)

#Complex (migadikoi)
x <- 2 + 3i
str(x)

#functions to examine individual objects
class() #returns the class of an object
typeof() #low-level category
str() 

#special values
4/0
0/0
log(-19)

#typecasting in R
#check the data type of an object
is.numeric()
is.character()
is.complex()

#change the data type
as.character()
as.numeric()
as.complex()

#same applies for data structures too
is.factor()
as.factor()
is.data.frame()
as.data.frame()






# Data structures ---------------------------------------------------------


#Vectors : all objects must be of the same data types

#vector(mode = "logical", length = 0)

vec1 <- c( 3, 4, 5)
vec2 <- c(3:5)
vec3 <- c(rep(4, 3))  #rep(x, times)
vec4 <- c(seq(from = 1, to = 10, by = 0.1))

charvec <- c('DNA', 'RNA', 'protein')
charvec2 <- c(3 , 5, 'Cat' , NA) #the numbers are converted to characters

bigvec <- c(charvec, 'mDNA')  #adding elements 
#two or more vectors) or vectors and other objects 
#can be combined -separated by comma - into 1 vector

numvec <- vec1 + vec2   #numeric vectors of the same length can be added element by element

logvec <- c(T, T, F)

#examining vectors :
length()
str()
class()
typeof()
is.na()
anyNA()

#more work with vectors

#maths with vectors
#add a number to all elements of a numeric vector
vec1 + 5
#apply a function
log(vec1)
sqrt(c(25, 9, 81))
#comparisons (per object)
vec1 < 4
#choosing objects from a vector using square brakets
bigvec[3]
bigvec[c(1, 4, 2)]
bigvec[-1]  #remove objects ffrom vector based on position
bigvec[-c(1,2)] 

#name the positions of a vector (same applies to lists too)
dnavec  <- c('A', 'T', 'G', 'C', 'U')
names(dnavec) <-  c('Adenine', 'Thymine', 'Guanine', 'Cytocine', 'Uracil')
dnavec

#now we can select or remove objects from our vector based on their name


#other usefull functions
min(vec1)
which.min(vec1)
max(vec1)
which.max(vec1)
range(vec1)
sum()
sort(vec1, decreasing = F)
order(vec1 ,decreasing = T)
rank()


#Factors
#factor(x = character(), levels, labels = levels, exclude = NA, ordered = is.ordered(x), nmax = NA)

fact <- factor(c("alpha","beta","gamma","alpha","beta"))
levels(fact)

# Rename by name: change "beta" to "two"
levels(x)[levels(x)=="beta"] <- "two"

# Rename by index in levels list: change third item, "gamma", to "three".
levels(x)[3] <- "three"

# Rename all levels
levels(x) <- c("one","two","three")

# Rename all levels, by name
levels(x) <- list(A="alpha", B="beta", C="gamma")


#Lists : might contain objects of different types

#accessing list objects
mixl <- list(3, 7, 'DNA', TRUE)
mixl[1]
mixl[[1]]
mixl2 <- list(3, 7, 'DNA', TRUE, list('A', 'B', 'C'))
mixl2[5]
mixl2[[5]]
mixl2[[5]][1]
mixl2[[5]][[1]]

#named lists
namedlist <- list(a = "DNA", b = 1:10, c = c('A', 'T', 'G', 'C'))
namedlist
names(namedlist)
namedlist$a
namedlist[[1]]

#delete list obect
namedlist$a <- NULL

#add a new list object
namedlist$d <- 3
mixl[[5]] <- 7

#Matrices
#matrix(data = NA, nrow = 1, ncol = 1, byrow = FALSE, dimnames = NULL)

A <- matrix(c(1:16), nrow = 4, ncol = 4, byrow = TRUE)
A[3,2]   #MATRIX[row, column]
A[1:2, 2:4]  #more than 1 elements
A[1,]   #select 1st row
A[,1]   #select 1st column
A[-1,]  #remove 1st row
A[,-1]  #remove 1st column
A[-1, -3] #remove 1st row and 3rd column
A[,2] > 8 #check if any elements of the 2nd column are larger than 8

#functions for matrices
dim(A)  #dimensions
det(A)  #determinant
t(A)   #transpose
nrow(A)
ncol(A)
eigen(A)  #eigen values & eigen vectors

#Arrays : multidimensional matrices 
#array(data = NA, dim = length(data), dimnames = NULL)

#Data frames
#data.frame(…, row.names = NULL, check.rows = FALSE,
#           check.names = TRUE, fix.empty.names = TRUE,
#          stringsAsFactors = default.stringsAsFactors())

df <- data.frame(colA = c(2, 5, 9, 3 , 1, 4, 0),
                 colB = c('C', 'A', NA, 'B', 'A', 'B', 'B'), 
                 stringsAsFactors = T)

summary(df)
str(df)
names(df)
rownames(df)

table(df$colB)

#add rows
df <- rbind(df, c(6, 'B'))

#add columns
df <- cbind(df, colC=c(T, F, T, T, T, F, F, T))

#access objects 
df['colA']
df$colA
df$colA[5]
df['colB', 3]  #dataframe[rows,columns]
df[1,2]


#Data tables

#Tibbles 

