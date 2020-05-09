# Loop over a list of objects and apply a function to each of this obejcts

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

# SAPPLY (Si puede hacerlo simplifica el resultado en un vector o en una matriz)

x <- list(a=1:4,b=2:6,c=rnorm(100))

sapply(x,mean)
