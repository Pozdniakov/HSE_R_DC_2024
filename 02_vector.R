c(4, 8, 15, 16, 23, 42)
c("Hey", 'ho', "let's", 'go')
c(TRUE, FALSE)

с(3, 4)
c(3, 4)
1:10
`:`(1, 10)
5:-3

`:`(1, 10)
seq(1, 10)
seq(10, 100, by = 10)

a <- 1:10
c(1, 8)
c(a, 4, c(5, 8))
seq(from = 0, to = 200, by = 5)
1.6:10
seq(1.6, 10, by = 2)
seq(1, 13, length.out = 4)

rep(1, 12)
rep(1:3, 12)
rep(1:3, c(10, 2, 5))
rep(1:3, each = 5)

sum(1:100)
mean(1:100)

c(FALSE, 2)
2 + TRUE
c(TRUE, 3, "hi")
c(0, 0, 0, 0, 0, FALSE)
as.logical(c(0, 1))
as.logical(-5:5)
as.character(-5:5)
as.numeric(c("1", "2", "три"))

a <- 1 
a <- 1:10

n <- 1:4
m <- 4:1
n
m
n + m

n - m

n * m
n ^ m

n * m - n ^ m / n

1:10
sqrt(1:10)
log(1:10)
log(1:10, base = 10:1)

n
k <- c(10, 100)
n + k
n * k
n * 10

n * c(10, 100, 1000)

(1:10) ^ 2
2 ^ (1:20)

1:20 * rep(0:1, 10)

1:20 * 0:1
1:20 * 1:0

6 > 5
sum(seq(1, 28, by = 3) / 3 ^ (0:9) > .5)

n <- c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
n[1]
n[length(n)]
n[3] <- 20
n
n[4:7]
m <- n[length(n):1]
rev(n)
head(n, 2)
tail(n, 4)
n[4:6] <- 0
n
n[-1]
n[-5]
n[-4:-7]

n[c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)]
n[c(TRUE, FALSE)]

my_named_vector <- c(first = 1, second = 2, third = 3)
my_named_vector
attributes(my_named_vector)
names(my_named_vector)
names(my_named_vector) <- letters[1:3]
my_named_vector
my_named_vector[c("b", "a")]
#my_named_vector["b", "a"]
n[c(3, 4, 5)]
