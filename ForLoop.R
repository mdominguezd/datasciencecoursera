x <- c('a', 'b')

for(i in seq_along(x))
  print(x[i])

for(letra in x)
  print(letra)

for(i in 1:2) print(x[i])

# En Matriz
X <- matrix(1:6,2,3)

for(i in seq_len(nrow(X)))
  for(j in seq_len(ncol(X)))
    print(X[i,j])