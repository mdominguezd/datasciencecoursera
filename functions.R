add = function(x, y){
  x+y
}

add(3,5)


mayor = function(X,n=10){
  X[X>n]
}

mayor(c(1,2,11,5,20))

meanCol = function(mat, removeNA= TRUE){
  nc = ncol(mat)
  
  means = numeric(nc)
  
  for(i in 1:nc){
    means[i] = mean(mat[,i], na.rm = removeNA)
  }
  
  means
  
}

X = matrix(1:20,4,5)
meanCol(airquality)
