# Punto 1
pollutantmean <- function(directory, pollutant, id = 1:332){ 
  directory = paste(directory,'/',sep='')
  
  lista = list()
  
  for(i in id){
    ID = sprintf('%03d.csv',i)
    camino = paste(directory, ID, sep='')
    df = read.csv(camino)
    if(pollutant == 'nitrate'){info = df$nitrate}
    else if(pollutant == 'sulfate'){info = df$sulfate}
    lista = append(lista, info)
  }
  
  lista = as.numeric(lista)
  
  mean(lista, na.rm = T)
  
}


pollutantmean('specdata', 'nitrate')
