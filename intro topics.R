
dhis2_data <- read.csv("data/dhis2data.csv")


3 - 4

class(3)

## Characters

Three
"Three"

class("Three")

class("3")

"This is number 3" 


"3" + "6"

## binary operator 
"+, -, /, %%"

8/2

9 %% 2

## Logical operators
#  "|" = OR

3 < 4 | 2 > 4


# "&" = AND

3 < 4 & 2 > 4

# "<" = less than

3 < 2
3 < 5

# ">" = greater than
4 > 4

# "<=" = less or equal

4 <= 4
# ">=" = greater or equal
5 >=  6
## logical data types


FALSE
TRUE

FALSE + FALSE

TRUE + TRUE + TRUE 



## functions and thier arguments
sum(2, 4)

sum(TRUE, FALSE)

sum(2, 4, NA, na.rm = T)

sum(2, TRUE, FALSE)

## Vectors 

KM <- c("Kampala", "Wakiso", "Mukono")

KM_cases <-  c(56, 40, 60)


KM_interested <- c(1,3)

KM[KM_interested]

##
class(KM)

class(KM_cases)

### combined 2 data types in a vector


KM_names <- c(56, "Kampala", "Wakiso")

c(TRUE, "Kampala", "Wakiso")

c(TRUE, 1, 2)


class(KM_names[1])


## data frames
districts <- c("Kampala", "Wakiso", "Mukono")
cases <-  c(56, 40, 60)

data.frame(districts,cases)

### more logical operators

## eqaul

2 == 2

## not equal 

3 != 2


