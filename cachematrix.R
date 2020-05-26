## Assignment 2// these functions computes the unverse of a matrix.
## If the inverse has already been calculated cacheSolve returns the inverse from the Cache

## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  
  inv <- NULL
  
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  
  get <- function() x 
  
  setInv <- function(solve) i <<- solve
  
  getInv <- function() i 
  
  list(set = set, get = get, setInv = setInv, getInv = getInv)
  
  
}


## This function computes the inverse of the special "matrix" returned by makeCacheMatrix
## above. If the inverse has already been calculated (and the matrix has not changed), 
## then cacheSolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  s <- x$getInv()
  
  if (!is.null(s) && (typeof(s) != "integer")){
    message('Getting cached data')
    return(s)
  }
  
  data <- x$get()
  s <- solve(data)
  x$setInv(s)
  s
}
