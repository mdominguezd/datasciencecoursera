# Assignment 3 - R Programming

## Ranking hospitals of all states

rankall <- function(outcome, num = 'best'){
  
  data <- read.csv('Assignment3Data/outcome-of-care-measures.csv', colClasses = "character")
  
  ans <- mapply(rankhospital,unique(data$State) ,outcome , num)
  
  print(as.data.frame(ans))
  
}