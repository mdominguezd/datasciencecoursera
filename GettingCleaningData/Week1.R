## DOWNLOADING DATA

if (!file.exists("Data")){
  dir.create("Data") #Create directory if it doesn't already exists
}

fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile = "./Data/Cameras.csv", method = 'curl')
list.files("./Data")

dateDownloaded <- date()
dateDownloaded

View("./Data/Cameras.csv")

## READING LOCAL FLAT FILES

Cam_Data <- read.csv("./Data/Cameras.csv")
View(Cam_Data)

Cam_Data <- read.table("./Data/Cameras.csv", header = T, sep=',')
View(Cam_Data)

## READING EXCEL FILES

install.packages("readxl") ## Reading
library(readxl)

excel_Camera <- read_xlsx("./Data/EjemploExcel.xlsx")
View(excel_Camera)

install.packages("writexl") ## Writing
library(writexl)

write_xlsx(excel_Camera, path = './Data/ExcelEscrito.xlsx')


## READING XML files
install.packages("XML")
install.packages("RCurl")

library(RCurl)
library(XML)

url <- getURL("https://www.w3schools.com/xml/simple.xml")

doc <- xmlTreeParse(url, useInternalNodes = T)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

names(rootNode)

rootNode[[1]] # Get first element
rootNode[[1]][[2]] # Get name of first element

xmlSApply(rootNode, xmlValue) ## Get all values

xpathSApply(rootNode,"//name", xmlValue)

## READING JSON files

install.packages("jsonlite")

library(jsonlite)

jsonData <- fromJSON("https://api.github.com/users/jtleek/repos") #Read from JSON directly from url

names(jsonData)

names(jsonData$owner)

names(jsonData$owner$login)

myjson <- toJSON(iris, pretty = T) #Write into JSON
cat(myjson)


## DATA.TABLE package

install.packages("data.table")

library(data.table)

DF = data.frame(x=rnorm(9), y = rep(c("a","b","c"), each =3), z = rnorm(9)) # As data frame
DF

DT = data.table(x=rnorm(9), y = rep(c("a","b","c"), each =3), z = rnorm(9)) #As data table
DT

tables() #See all tables on the environment

DT[2,]

DT[DT$y == "a"]

DT[c(2,3)] # Filas 2 y 3

DT[,c(2,3)] # Columnas 2 y 3

DT[,list(mean(x), sum(z))] #Apply functions to columns

DT[,w:=z^2] #Add a new column
DT

DT[, m:= {tmp <- x+z; log2(tmp+5)}] # Multiple operations
DT

DT[, a:=x>0] #New boolean column 
DT

DT[,b:= mean(x+w), by=a] #New column grouped by another column (mean of (X+W) for all rows in which x>0 and mean of (x+w)for all rows x<0)
DT

#Special variables
set.seed(123)
DT <- data.table(x=sample(letters[1:3],1E5,T))
DT

# .N number of times a value appears in a column
DT[, .N, by=x]

# setting key
setkey(DT, x)
DT['a']

# Create joins
DT1 <- data.table(x = c('a','a','b', 'dt1'),y=1:4)
DT2 <- data.table(x = c('a','b', 'dt2'),z=5:7)

setkey(DT1, x); setkey(DT2, x)
merge(DT1,DT2)

# fast reading
big_dt <- data.frame(X = rnorm(1e6), y = rnorm(1E6))

file <- tempfile()

write.table(big_dt, file =file, row.names = FALSE,col.names = T, sep="\t", quote = FALSE )

system.time(fread(file))
system.time(read.table(file, header = T, sep = '\t'))

## QUIZ 1

# 1

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "./Data/Housing.csv", method = 'curl')
list.files("./Data")

house <- read.csv("./Data/Housing.csv")

sum(house[complete.cases(house$VAL), ]$VAL == 24)

# 2
house$FES

# 3
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURL, destfile = "./Data/NGAP.xlsx", method = 'curl')
list.files("./Data")

dat <- read_xlsx("./Data/NGAP.xlsx",skip = 17, n_max = 23-18)
dat <- dat[,7:15]
dat

sum(dat$Zip*dat$Ext,na.rm=T)

# 4
url <- getURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml")

doc <- xmlTreeParse(url, useInternalNodes = T)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

rootNode[[1]][[1]][[2]]

sum(xpathSApply(rootNode,"//zipcode", xmlValue)=="21231")

# 5
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile = "./Data/Housing2.csv", method = 'curl')
list.files("./Data")

DT <- read.csv("./Data/Housing2.csv")
DT <- data.table(DT)
system.time(DT[, mean(pwgtp15), by = SEX])
