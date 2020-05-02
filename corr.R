# Punto 3
corr <- function(directory, threshold = 0){
  
  directory = paste(directory,'/',sep='')
  id = 1:332
  
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
  ID = N[N$nobs>threshold,]$id
  
  correla = c()
  
  for(i in ID){
    Id = sprintf('%03d.csv',i)
    camino = paste(directory, Id, sep='')
    df = read.csv(camino)
    
    correla = c(correla, cor(df$sulfate, df$nitrate, use = 'complete.obs'))
  }
  correla
  
}

cr = corr('specdata')
summary(cr)

cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))
