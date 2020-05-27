# STR function

str(ls)

x <- rnorm(100,2,4)
str(x)

f <- gl(40,10)
str(f)

library(datasets)
str(airquality)

summary(airquality)


m <- matrix(rnorm(100),10,10)

str(m)

s<- split(airquality, airquality$Month)

str(s)
