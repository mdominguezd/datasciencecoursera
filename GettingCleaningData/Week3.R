## Subsetting and Sorting
set.seed(13435)
X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA

X

X[,1] # Subset one column
X$var1

X[1:2,"var2"] # First two rows in column var2


X[(X$var1 <= 3 & X$var3 > 11), ] #Using logical queries
X[which(X$var2 > 6), ] # Doesnt return NAs

sort(X$var1) #Increasing
sort(X$var2, decreasing = T, na.last = T) #sort in decreasing order and NAs at last

X[order(X$var1), ] # Order all the DF by one variable

X[2,1] = 1
X[order(X$var1, X$var3), ] # Order all the DF by two variables first variable first and second variable if repeated values in first variable

install.packages("plyr")
library(plyr)

arrange(X,var1)# Order all the DF by one variable using plyr

arrange(X,desc(var1))# Decreasing using plyr

X$var4 <- rnorm(5) # add to dataset
X

Y <- cbind(X, rnorm(5)) # Add column with cbind
Y

Z <- rbind(X, rnorm(4)) # Add row with rbind
Z

## SUMMARIZING DATA

fileURL <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"

download.file(fileURL, destfile = './Data/restaurants.csv', method='curl')

restData <- read.csv("./Data/restaurants.csv")

head(restData, 3) # first rows

tail(restData, 3) # Last rows

summary(restData) # Summary of the dataframe

str(restData) # Type of data and some values

quantile(restData$councilDistrict, na.rm = T) # Quantile

table(restData$zipCode, useNA = "ifany")

table(restData$councilDistrict, restData$zipCode) # Algo como pivot tables

sum(is.na(restData$councilDistrict)) # How many missing values

any(is.na(restData$councilDistrict)) # Logicals for any value in a column
all(restData$zipCode > 0) # Logical for all values in a column

colSums(is.na(restData))

all(colSums(is.na(restData)) == 0)

table(restData$zipCode == c("21212")) # Create table with logical

restData[restData$zipCode == c("21212", "21213"),] #Subset

data("UCBAdmissions") #New data

DF = as.data.frame(UCBAdmissions)

summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data= DF) # This is a pivot table
xt

object.size(DF) # Size of the Data in Bytes

## CREATING NEW VARIABLES


# Common variables to create (Missingness indicators, "Cutting up" quantitative variables, Applying transforms)

s1 <- seq(1,10, by=2); s1 #Create a sequence

s2 <- seq(1,10, length =3); s2

x <- c(1,3,8,25,100); seq(along = x) #Like range(len(x)) in Python

restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland") # Boolean column with T or F

table(restData$nearMe)

restData$zipWrong <- ifelse(restData$zipCode < 0, T, F) #Binary column if zipcode is wrong T else F

table(restData$zipWrong, restData$zipCode < 0)


restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode)) # CUT FUNCTION: Break data into quantiles Categorical variables
table(restData$zipGroups)

table(restData$zipGroups, restData$zipCode)

restData$zcf <- factor(restData$zipCode) #Factor variables
restData$zcf[1:10]
class(restData$zcf)

yesno <- sample(c("yes", "no"), size = 10, replace = T)
yesnofac = factor(yesno, levels = c("yes", "no")) # Create factor data with levels yes or no
relevel(yesnofac, ref = 'yes')
as.numeric(yesnofac) #If you wanna change it to numeric data


## RESHAPING DATA
install.packages('reshape2')
library(reshape2)

head(mtcars)

mtcars$carname <- rownames(mtcars)
mtcars$carname

carMelt <- melt(mtcars, id = c("carname","gear", "cyl"), measure.vars = c("mpg",'hp'))
head(carMelt)
carMelt


cylData <- dcast(carMelt, cyl ~ variable) # Count 
cylData

cylData <- dcast(carMelt, cyl ~ variable, mean) # Mean
cylData

tapply(InsectSprays$count, InsectSprays$spray, sum)

spIns = split(InsectSprays$count, InsectSprays$spray)
spIns

sprCount <- lapply(spIns, sum)
sprCount

unlist(sprCount)
sapply(spIns, sum)


library(plyr)
ddply(InsectSprays,.(spray), summarize, sum = sum(count)) #summarize data like a groupby in Python

spraySums <- ddply(InsectSprays, .(spray), summarize, sum = ave(count,FUN=sum)) # To add the information to every row in the dataframe
spraySums


## DPLYR PACKAGE
library(dplyr)


# Select: Return subset of the columns of dataframe
# filter: Extract subset of rows from a df based on logical conditions
# arrange: reorder rows of a df
# rename: renam variables ina df
# mutate: add new variables/columns or transform existing variables.
# summarize: Genenerate summary statistics of different variables in the df.


dim(Source)
str(Source)

names(Source)


head(select(Source, PM10:SO2)) # Select function subsetting by names
head(select(Source, -(PM10:SO2))) #Select everything except some columns

Source$Precipitacion <- as.numeric(Source$Precipitacion)
head(filter(Source, Precipitacion > 0)) #Filter Data with 


Source <- arrange(Source, DateTime) # Order the data
Source

Source <- rename(Source, MaterialParticulado10 = PM10) #Rename a column
head(Source)

Source$MaterialParticulado10 <- as.numeric(Source$MaterialParticulado10)
Source <- mutate(Source, PM10 = MaterialParticulado10-mean(MaterialParticulado10, na.rm = T)) # Create new Column with deviation from the mean
head(Source)


Source$Temp_4m <- as.numeric(Source$Temp_4m)
Source$RadSolar <- as.numeric(Source$RadSolar)
Source$VelViento <- as.numeric(Source$VelViento)

Source <- mutate(Source, temperatura = factor(1*(Source$Temp_4m > 10), labels = c("cold", "Hot"))) # Mutate function
head(Source)

HOT_COLD <- group_by(Source, temperatura)

summarize(HOT_COLD, RadSolar = mean(RadSolar, na.rm = T), VelViento = mean(VelViento, na.rm = T)) # Summarize data according to a group of data


# PIPELINE OPERATIONS (Todo en una sola linea)
Source %>% mutate(FrioCal = factor(1*(Source$Temp_4m > 10), labels = c("Frio", "Caliente"))) %>% group_by(FrioCal) %>% summarize(RadSolar = mean(RadSolar, na.rm = T), VelViento = mean(VelViento, na.rm = T))

# MERGING DATA

DF1 <- data.frame("id" = seq(1,10,by=1), 'solution_id' = sample(seq(1,10,by=1)))

DF2 <- data.frame("id" = seq(1,10,by=1), "answer" = round(runif(10)*100,digits = 0))

DF1
DF2


merge(DF1, DF2, by.x = 'solution_id', by.y = 'id') # Merged by column names specified

merge(DF1, DF2) # It meges all common column names


join(DF1, DF2) # Merges on the basis of a common variable

### QUIZ

# 1 
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = 'Data/Quiz3.csv')

DataQ3 <- read.csv('Data/Quiz3.csv')

DataQ31 <- mutate(DataQ3, agricultureLogical = (DataQ3$ACR == 3 & DataQ3$AGS == 6))
head(DataQ31)

which(DataQ31$agricultureLogical)

# 2

install.packages("jpeg")

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg', destfile = 'Data/Foto.jpg', method = 'curl')
Data_Foto = jpeg::readJPEG("Data/Foto.jpg", native = T)

quantile(Data_Foto, c(0.3,0.8))

# 3

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', destfile = 'Data/Quiz3_GDP.csv', method = 'curl')
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', destfile = 'Data/Quiz3_EDU.csv', method = 'curl')

GDP <- read.csv("Data/Quiz3_GDP.csv", skip = 4, nrows = 190)
View(GDP)

EDU <- read.csv("Data/Quiz3_EDU.csv")
View(EDU)

DF <- merge(GDP, EDU, by.y = 'CountryCode',  by.x = 'X')

unique(DF$CountryCode)

View(DF)

arrange(DF, desc(X.1))[13,]

# 4
DF %>% group_by(Income.Group) %>% summarize(X.1 = mean(X.1, na.rm = T))


# 5
DF$CuttedGDP <- cut(DF$X.1, breaks = quantile(DF$X.1, c(0, 0.2, 0.4, 0.6, 0.8, 1)))
table(DF$CuttedGDP, DF$Income.Group)
