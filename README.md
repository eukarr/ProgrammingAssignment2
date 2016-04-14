### Task (programming part)

Your assignment is to write a pair of functions that
cache the inverse of a matrix.

Write the following functions:

1.  `makeCacheMatrix`: This function creates a special "matrix" object
    that can cache its inverse.
2.  `cacheSolve`: This function computes the inverse of the special
    "matrix" returned by `makeCacheMatrix` above. If the inverse has
    already been calculated (and the matrix has not changed), then
    `cacheSolve` should retrieve the inverse from the cache.

Computing the inverse of a square matrix can be done with the `solve`
function in R. For example, if `X` is a square invertible matrix, then
`solve(X)` returns its inverse.

For this assignment, assume that the matrix supplied is always
invertible.


### Example of the functions workflow

We start with creation of a pair of 3 by 3 matrixes and calculating their sum.

```
> temp1 <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 10), nrow = 3, ncol = 3)
> temp2 <- matrix(1:9, nrow = 3, ncol = 3)
> sum_temp <- temp1 + temp2
```

Next, we create  special 'matrix' object using the 'temp1' matrix.

```
> specialmatrix_temp <- makeCacheMatrix(temp1)
```

Below is a check of the 'matrix' contents calling the 'get' method.

```
> specialmatrix_temp$get()
     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6   10
```

The inverse of the matrix has not yet been calculated, as indicated by the call of the 'getinverse' method.

```
> specialmatrix_temp$getinverse()
NULL
```

Let us now calculate the inverse by calling the 'CacheSolve' function over the earlier created object...

```
> cacheSolve(specialmatrix_temp)
           [,1]       [,2] [,3]
[1,] -0.6666667 -0.6666667    1
[2,] -1.3333333  3.6666667   -2
[3,]  1.0000000 -2.0000000    1
```

... and verify that the inverse value has been stored in the object by calling the 'getinverse' method again.

```
> specialmatrix_temp$getinverse()
           [,1]       [,2] [,3]
[1,] -0.6666667 -0.6666667    1
[2,] -1.3333333  3.6666667   -2
[3,]  1.0000000 -2.0000000    1
```

Attempting to calsulate the inverse again...

```
> cacheSolve(specialmatrix_temp)
getting cached data
           [,1]       [,2] [,3]
[1,] -0.6666667 -0.6666667    1
[2,] -1.3333333  3.6666667   -2
[3,]  1.0000000 -2.0000000    1
```

... results in the message confirming that the inverse has been already calculated; the cached value is returned.

Let us create another 'special matrix' object using the available sum of the matrixes and calculate the corresponding inverse value again.

```
> specialmatrix_sum <- makeCacheMatrix(sum_temp)
> cacheSolve(specialmatrix_sum)
           [,1]      [,2] [,3]
[1,]  0.1666667 -1.333333    1
[2,] -1.6666667  3.833333   -2
[3,]  1.0000000 -2.000000    1
```

The 'getinverse' call below verifies that the inverse has been calculated and stored.

```
> specialmatrix_sum$getinverse()
           [,1]      [,2] [,3]
[1,]  0.1666667 -1.333333    1
[2,] -1.6666667  3.833333   -2
[3,]  1.0000000 -2.000000    1
```

The inverse of the earlier treated 'temp1' matrix is still available, since it belongs to another instance of the 'special matrix' type.

```
> specialmatrix_temp$getinverse()
           [,1]       [,2] [,3]
[1,] -0.6666667 -0.6666667    1
[2,] -1.3333333  3.6666667   -2
[3,]  1.0000000 -2.0000000    1
```

Let us now backup the existing object...

```
> specialmatrix_temp_old <- specialmatrix_temp
```

...and modify the earlier treated object by calling the 'makeCashMatrix' on the 'temp2' matrix. 

```
> specialmatrix_temp <- makeCacheMatrix(temp2)
```

Note that the inverse field has been emptied during the object modification and is not available any more.

```
> specialmatrix_temp$getinverse()
NULL
```

The matrix is as follows.

```
> specialmatrix_temp$get()
     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9
```

It is impossible, however, to calculate its inverse:

```
> cacheSolve(specialmatrix_temp)
 Error in solve.default(data, ...) : 
  Lapack routine dgesv: system is exactly singular: U[3,3] = 0 
```

Let us add some noise to the data using the 'set' method of the 'special matrix' object: 

```
> specialmatrix_temp$get()
     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9
> specialmatrix_temp$set(specialmatrix_temp$get() + matrix(rnorm(9), nrow = 3, ncol = 3))
> specialmatrix_temp$get()
         [,1]     [,2]     [,3]
[1,] 2.677229 2.051566 6.505770
[2,] 3.066065 4.363392 8.009595
[3,] 1.445053 4.728742 6.611745
```

And now the inverse can be computed:

```
> specialmatrix_temp$getinverse()
NULL
> cacheSolve(specialmatrix_temp)
           [,1]       [,2]       [,3]
[1,] -0.7990217  1.5226468 -1.0583489
[2,] -0.7699912  0.7347768 -0.1324731
[3,]  0.7253333 -0.8583022  0.4773024
```
