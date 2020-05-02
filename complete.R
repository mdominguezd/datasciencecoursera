# Punto 2
complete = function(directory, id = 1:332){
  directory = paste(directory,'/',sep='')

  N = data.frame(id)
  nobs = c()
  
  for(i in id){
    ID = sprintf('%03d.csv',i)
    camino = paste(directory, ID, sep='')
    df = read.csv(camino)
    nob = sum(complete.cases(df))
    
    nobs = c(nobs, nob)
    
  }
  
  N = cbind(N,nobs)
  N
  
}


set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])
