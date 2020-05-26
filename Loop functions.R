
#LAPPLY
# Loop over a list of objects and apply a function to each of this obejcts
# Returns a list

x <- list(a=1:5,b=rnorm(10))

l = lapply(x, mean)

l$a

x<-1:4

L <- lapply(x, runif)
L

L <- lapply(x, runif, min=1, max=5)
L


x <- list(a = matrix(1:4,2,2), b = matrix(1:6,3,2))

x

lapply(x, function(elt) elt[,1]) # Anonymous function (Just like lambda in Python)

# SAPPLY (Si puede hacerlo simplifica el resultado en un vector o en una matriz, de lo contrario devuleve lista)

x <- list(a=1:4,b=2:6,c=rnorm(100))

sapply(x,mean)

# APPLY x is an array, margin eje columnas o filas, funcion

x <- matrix(rnorm(200),20,10)

apply(x,1, mean) # En columnas

apply(x,2,sum) # En filas


apply(x,1,quantile,probs = c(0.25, 0.5,0.75))

# MAPPLY se le aplica la funcion a mas de un objeto mas de una lista o mas de un vector

mapply(rep, 1:4, 4:1) # 2 argumentos de una funcion

noise <- function(n, mean, sd){
  rnorm(n,mean,sd)
}

mapply(noise, 1:5, 1:5,2)

# TAPPLY apply function over subset of vector.
x <- c(rnorm(10),runif(10), rnorm(10,1))
f <- gl(3,10)
f

tapply(x,f,range) #Min and max of every set of observations


# SPLIT takes a vector or other objects and splits it into groups determined by a factor or list of factors
x <- c(rnorm(10),runif(10), rnorm(10,1))
f <- gl(3,10)

split(x,f)


lapply(split(x,f), mean)


