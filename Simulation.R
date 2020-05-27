# SIMULATION

## Generating random numbers

### Normal distribution

dnorm(100)

# pnorm y qnorm son inversas
pnorm(-0.25)
qnorm(0.4)

# Generator of numbers
rnorm(10)

set.seed(1)
rnorm(5)

rnorm(5)

set.seed(1)
rnorm(5)

### Poisson distributions

rpois(10,1)

rpois(10,3)

rpois(10,20)


ppois(2,2) ##Cumulative distribution #P(x <= 2)

qpois(0.6766,2) # x??


# SIMULATING A LINEAR MODEL
## x is normal
set.seed(20)
x<-rnorm(100)
e<-rnorm(100,0,2)
y <- 0.5+2*x + e

summary(y)

plot(x,y)

## X is binary
set.seed(10)
x <- rbinom(100,1,0.5)
e <- rnorm(100, 0, 2)

y <- 0.5+2*x+e 

summary(y)
plot(x,y)

# Poisson model
set.seed(1)
x <- rnorm(100)

log.mu = 0.5+0.3*x

y <- rpois(100,exp(log.mu))

summary(y)

plot(x,y)

# SAMPLE FUNCTION
set.seed(1)
sample(1:10,4)
sample(1:10,4)
sample(letters,5)

sample(1:10) #permutation

sample(1:10, replace = TRUE) # Sample with replacement


