# Assignment 3 - R Programming

## Ranking hospitals of a state

rankhospital <- function(state, outcome, num = "best"){
  
  data <- read.csv('Assignment3Data/outcome-of-care-measures.csv', colClasses = "character")
  
  StateData <- data[data$State == state,]
  
  if (outcome == "heart attack"){
    D <- StateData[order(as.numeric(StateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), StateData$Hospital.Name), c(2, 11)]
  }
  else if (outcome == "heart failure"){
    D <- StateData[order(as.numeric(StateData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure), StateData$Hospital.Name), c(2, 17)]
  }
  else if (outcome == "pneumonia"){
    D <- StateData[order(as.numeric(StateData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), StateData$Hospital.Name), c(2, 23)]
  }
  else{
    return("invalid state or outcome")
  }
  
  D <- as.data.frame(D)
  
  if (num == "best"){num = 1}
  if (num == "worst"){num = sum(complete.cases(as.numeric(D[,2])))}
  
  D[num, 1]
}

rankhospital("MD", "heart attack", "worst")
