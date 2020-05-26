# DEBUGGING TOOLS

log(-1) # Warning

printMessage <- function(x) {
  
  if (is.na(x))
    print("Missing value")
  else if(x > 0)
    print("X greater")
  else
    print("less or equal to zero")
  invisible(x)
}

printMessage(NA) #Error

lm(y~x)

traceback()

debug(lm)

lm(y~x)
