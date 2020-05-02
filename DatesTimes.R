año = as.Date("2020-01-01")

x = Sys.time()
x

p = as.POSIXlt(x)

names(unclass(p))

p$sec

