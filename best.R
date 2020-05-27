# Assignment 3 - R Programming

## Best function
best <- function(state='', characteristic){
  
  data <- read.csv('Assignment3Data/outcome-of-care-measures.csv', colClasses = "character")
  
  if (characteristic == "heart attack"){
    D <- as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
  }
  else if (characteristic == "heart failure"){
    D <- as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
  }
  else if (characteristic == "pneumonia"){
    D <- as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
  }
  else {
    return("invalid state or outcome")
  }
  
  m <- as.data.frame(split(data, data$State)[state])
  
  splitDat <- split(D, data$State)
  
  StateData <- as.data.frame(splitDat[state])
  
  
  ind <- which( StateData == min(StateData, na.rm = TRUE) )
  
  m[ind, 2]
}

best("TX", "heart attack")
