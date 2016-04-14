## Example workflow of the functions usage are given in readme.md 

## 'makeCacheMatrix' gets a matrix as an argument and
## creates a list of functions to operate
## a special object caching the matrix inverse

makeCacheMatrix <- function(x = matrix()) {
## start with NULL as the cached inverse
      inv <- NULL
      
## 'set' is used to change the matrix value;
## the cached inverse (if any) should be discarded
      set <- function(y) {
            x <<- y
            inv <<- NULL
      }
      
## 'get' merely extracts the matrix currently operating with
      get <- function() x
      
## 'setinverse' assigns the inverse value after computation
      setinverse <- function(inverse) inv <<- inverse
      
## 'getinverse' extracts the current inverse value, if any
      getinverse <- function() inv
      
## declaration of the functions list
      list(set = set, get = get,
           setinverse = setinverse,
           getinverse = getinverse)      
      
}


## 'cacheSolve' determines whether the computation of inverse is needed.
## If yes, it runs the computation.
## Otherwise, it returns the cached result.

cacheSolve <- function(x, ...) {
      ## attempting to retrieve the inverse of x.
      inv <- x$getinverse()
      
      ## verifying is the inverse has been stored already.
      if(!is.null(inv)) {
            message("getting cached data")
            ## the cached value is used for output
            return(inv)
      }
      ## otherwise, since no cached value has been found...
      
      ## getting the matrix
      data <- x$get()
      
      ## computing the inverse
      inv <- solve(data, ...)
      
      ## caching the result
      x$setinverse(inv)
      inv
      
}
