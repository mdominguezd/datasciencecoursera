## EDITING TEXT VARIABLES

data = read.csv("Data/Cameras.csv")
names(data)

tolower(names(data))

splitNames = strsplit(names(data), "\\.")
splitNames


myList <- list(letters = c("A","B","C"), numbers = 1:3, matrix(1:25,ncol=5))
head(myList)

myList[1]


splitNames[[6]][1]

firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)

sub("\\.","", names(data)) # Solo el primero

gsub("\\.","", names(data)) # todos


grep("Alameda", data$intersection) #Search intersections where Alameda appears

grepl("Alameda", data$intersection) # True False to subset

table(grepl("Alameda", data$intersection))

grep("Alameda", data$intersection, value = T)


install.packages("stringr")

library(stringr)

nchar("Martin") # Returns 6. 
length("Martin") # Returns 1 a string is not a list in R

substr("Martin Dom", 4, 6)

paste("Martin", "DOMIN", sep = " ") #separation with " "

paste0("Martin", "DOMIN") # No separation

str_trim("  MArt   ") # Cut spaces before and after the name

## REGULAR EXPRESSIONS

# ^ represents start of the line

# $ represents end of the line

# [Bb][Uu][Ss][Hh] either capital or lower case 

# [0-9][a-zA-Z] range of characters

# [^?.]$ Dentro de corchetes ^ funciona como negacion, busco finales de linea sin . o ?

# . sirve como cualquier caracter 9.11 puede buscar "9 11" o "9-11"

# | one word ore the other comida|bebida busca ambas

# ^([Gg]ood|[Bb]ad) Good or good or Bad or bad in beggining of line

# George( [Ww]\.)? [Bb]ush Question mark indicates that expression is optional

# * indicates repetitions any number of times

# + indicates repetitions at least one of the itmes

# {} range, minimum and maximum


## WORKING WITH DATES

d1<-date()

d2 <- Sys.Date()

class(d1)

class(d2)

format(d2, "dia de semana: %A, Numero: %d, del mes numero: %m (%B) del año %Y")

dat <- c("1/ene./1960", "31/mar./1960", "30/jun./1960")

fechas = as.Date(dat, "%d/%b/%Y") #Creacion de fechas

fechas

fechas[1] - fechas[2]

as.numeric(fechas[1] - fechas[2])


julian(d2)


library(lubridate)

ymd("20140108")

mdy("08042013")

dmy("03042010")

ymd_hms("2020/08/03 11:52:30")

ymd_hms("2020/08/03 11:52:30", tz = 'Pacific/Auckland')


## DATA RESOURCES


## QUIZ

#1
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "Data/Q4P1.csv")

p1 <- read.csv("Data/Q4P1.csv")

strsplit(names(p1), "wgtp")[[123]]


#2
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "Data/Q4P2.csv")

p2 <- read.csv("Data/Q4P2.csv", skip = 3,nrows = 191)

p2 = p2[-1,]

head(p2)

p2$US.dollars.

misDat <- gsub(",","",p2$US.dollars.,)

misDat <- as.numeric(misDat)

mean(misDat)

#3
grep("^United", p2$Economy)
grep("^United", p2$Economy, value = T)


#4 
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "Data/Q4P4_GDP.csv")
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "Data/Q4P4_EDU.csv")

GDP <- read.csv("Data/Q4P4_GDP.csv", skip = 3, nrows = 191)
GDP = GDP[-1, ]

EDU <- read.csv("Data/Q4P4_EDU.csv")

grep("[Ff]iscal.*[Jj]une", EDU$Special.Notes, value = T)


#5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

length(sampleTimes[year(sampleTimes) == 2012])

length(sampleTimes[wday(sampleTimes) == 2 & year(sampleTimes) == 2012])
