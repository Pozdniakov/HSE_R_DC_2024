seq(2, 20, by = 2)
seq(1, 10) * 2
1:10 * 2
a <- 1:20
a[c(FALSE, TRUE)]
a <- rep(2, each = 10)
a * 1:10
2 * 1:10
c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20)


# logic vectors -----------------------------------------------------------


eyes <- c("green", "blue", "blue", "brown", "green", "blue")

sum(eyes == "blue")
#sum(eyes == "blue")/length(eyes == "blue")
mean(eyes == "blue")
mean(eyes == "blue") * 100

all(eyes == "blue")
any(eyes == "blue")
any(!eyes == "blue")

which(eyes == "blue")
#seq_along(eyes)[eyes == "blue"]

eyes[eyes == "blue" | eyes == "green"]
eyes[eyes == c("blue", "green")]
eyes[eyes == c("green", "blue")]

eyes %in% c("green", "blue")

respondents <- c("Moscow", "Moscow", "Saint-Petersburg",
                 "Odintzovo", "Kazan", "Balashikha", "Moscow")

millionnairs <- c("Moscow", "Saint-PEtersburg", "Novosibirsk", "Kazan")

respondents[respondents %in% millionnairs]

# NA -- missing values ----------------------------------------------------


missed <- NA
missed == "NA"
missed == ""
missed == 0
missed == NA
Joe_age <- NA
Mary_age <- NA
Joe_age == Mary_age

n <- c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
n[5] <- NA
n
mean(n)
n == NA
n[!is.na(n)]
mean(n[!is.na(n)])
mean(n[-5])
?mean
mean(n, na.rm = TRUE)

typeof(NA)
n
as.character(n)
as.logical(n)
NA_character_
NA_integer_
NA_real_
NA_complex_

NA ^ 0
NA & FALSE
1 / 0 
-1 / 0
0 / 0
is.na(NaN)
is.nan(NA)
mean(n == NA, na.rm = TRUE)


# Matrix ------------------------------------------------------------------

matrix(1:20, nrow = 5, ncol = 4)
A <- matrix(1:20, nrow = 5)
A[2, 3]
A[2:3, 3:4]

A[1:2, 1:4]
A[1:2, ]
A[, c(1, 3)]
A[1:2, 1:2] <- 100
A
attributes(A)
attr(A, "dim") <- NULL
A
attr(A, "dim") <- c(2, 10)
A
as.character(A)
A > 10
A[3:8]
attr(A, "dim") <- c(2, 2, 5)
A
matrix(rep(1:9, 9), nrow = 9)
rep(1:9, each = 9)
matrix(rep(1:9, 9) * rep(1:9, each = 9), nrow = 9)

# List --------------------------------------------------------------------

simple_list <- list(23, "Alex", TRUE)
simple_list
complex_list <- list(letters, 1:10, simple_list, A, mean, `+`)
complex_list

named_list <- list(name = "Veronika", age = 45, student = FALSE)
named_list
class(named_list$name)
class(named_list[1])
named_list[[1]]
named_list[1]
named_list[[1]]
named_list["name"]
named_list[["name"]]
