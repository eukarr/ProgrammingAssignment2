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


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
      inv <- x$getinverse()
      if(!is.null(inv)) {
            message("getting cached data")
            return(inv)
      }
      data <- x$get()
      inv <- solve(data, ...)
      x$setinverse(inv)
      inv
      
}
