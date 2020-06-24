## MY SQL
install.packages("RMySQL")

ucscDb <- dbConnect(MySQL(), user = 'genome', host = 'genome-mysql.cse.ucsc.edu')

result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)

hg19 <- dbConnect(MySQL(), user = 'genome', db = 'hg19', host = 'genome-mysql.cse.ucsc.edu')

allTables <- dbListTables(hg19)

length(allTables)

allTables[1:5]

dbListFields(hg19, "affyU133Plus2")

dbGetQuery(hg19, "select count(*) from affyU133Plus2")


affyData <- dbReadTable(hg19, 'affyU133Plus2')

head(affyData)

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")

affyMis <- fetch(query)

quantile(affyMis$misMatches)

affyMisSmall <- fetch(query, n=10)
dbClearResult(query)

dim(affyMisSmall)

dbDisconnect(hg19)

## HDF5
install.packages('BiocManager')
library(BiocManager)
install("rhdf5")
library(rhdf5)

# Create the file
created <- h5createFile("example.h5")
created

# Create groups in the file
created <- h5createGroup("example.h5", "Grupo1")
created <- h5createGroup("example.h5", "Grupo2")
created <- h5createGroup("example.h5", "Grupo2/Grupo4") #Subgrupo en Grupo 2


h5ls("example.h5")

# Wrtite inside groups
A = matrix(1:10, nr=5,nc=2)
h5write(A,"example.h5", "Grupo1/A")
B = array(seq(0.1,2.0,by=0.1), dim= c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "Grupo2/Grupo4/B")
h5ls("example.h5")


# Write a dataset
df = data.frame(1L:5L, seq(0,1,length.out = 5),c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = F)
df

h5write(df, "example.h5", "df")
h5ls("example.h5")

readA = h5read("example.h5", "Grupo1/A")
readA

# Overwriting data in a group
h5write(c(12,13,14), "example.h5", "Grupo1/A", index=list(1:3,1))
h5read("example.h5", "Grupo1/A")

# Just read some part of the data
h5read("example.h5", "Grupo1/A", index = list(1:3,1:2))


## READING DATA FROM THE WEB (WEBSCRAPPING)
con <- url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode <- readLines(con)
close(con)

htmlCode

library(RCurl)
library(XML)


url <- getURL("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")

html <- htmlTreeParse(url, useInternalNodes = T)

rootNode <- xmlRoot(html)
xmlName(rootNode)

names(rootNode)

xpathSApply(html, "//title", xmlValue)

xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

library(httr)

url <- GET("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")

content2 <- content(url, as ="text")

parsedHtml = htmlParse(content2, asText = T)

xpathSApply(parsedHtml, "//td[@id='col-citedby']", xmlValue)

rootNode <- xmlRoot(parsedHtml)

## READING DATA FROM API

library(httr)

# Todo es ejemplo

myapp <- oauth_app("twitter", 
                   key = "ConsumerKeyHer",
                   secret = "Your ConsumerSecretHere")


sig = sign_oauth1.0(myapp,
                    token = "YourTokenHere",
                    token_secret = "yourTokenSecretHere")

homeTL = GET("https://api.twitter.com/1.1/statuses...")

json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSon(json1))

json2[1,1:4]




### QUIZ

#1

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "56b637a5baffac62cad9",
                   secret = "8e107541ae1791259e9987d544ca568633da2ebf"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)

#2
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv', destfile = "Data/Quiz2.csv")

datos <- read.csv('Data/Quiz2.csv')

acs <- data.frame(datos)

install.packages("sqldf")

library(sqldf)

sqldf("select pwgtp1 from acs where AGEP < 50")

#3 

unique(acs$AGEP)

sqldf("select distinct AGEP from acs")

#4 

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)

print(nchar(htmlCode[10]))
print(nchar(htmlCode[20]))
print(nchar(htmlCode[30]))
print(nchar(htmlCode[100]))

#5 
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for', destfile = "Data/Quiz2.for")

data <- read.fwf("Data/Quiz2.for",skip=4,widths = c(12,7,4,9,4,9,4,9,4))
sum(data[,4])












