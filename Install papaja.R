install.packages("tidyverse")
install.packages("papaja")
require(papaja)
install.packages("purrr")
require(purrr)
install.packages("psych")
require(psych)
#not sure what does "1+ other package of your choice" mean, therefore I installed and required another package
#assign numeric variable
x = 1
x
class(x)
#assign string variable
y = "hello"
y
class(y)
#assign numeric variable in another way
a <- 2
a
class(a)
#assign character variable in another way
b <- "yes"
b
class(b)

#not sure if you want me to create a seperate file for the second part of the assignment or not

# test push

#there are eggs at store
eggs <- TRUE 
n.milk <- ifelse(eggs == TRUE,yes = 6,no = 1)
paste0("I bought ",n.milk,".")

n.milk = 0
shop2 <-function(milk) {
    n.milk <<- 1
    paste0(n.milk)
}


shop2(TRUE)

n.milk


for (i in 1 : 5) {print(i)}

i <- 1
while (i < 10) {
  print(i) 
  i<- i + 1
}

#install.packages("dplyr")
#install.packages("psych")
#select(dataset, variable 1, variable2)
#filter(dataset, V1 condition)
#describe()
#new dataset name <- mutatue(_)

#function for Hello "name"!
name <- function(name) {paste0("Hello ",name, "!")}
name("happy")

##trying conditionals
hi<- T
hey <- ifelse (hi == TRUE, yes = name, no = "Hello!")
paste0("Hey there", name(" happy"))
name("happy")

#hello_world function which aims to produce Good morning/Good afternoon
#/Good evening, your name, for some number of times
#ideally in English or French
hello_world <- function(your_name, current_time, n.greetings, En_or_Fr)
  {
  #object assignment
  greeting <- "Hello, "
  #conditional statement
  if (current_time <= 12)#if it is before 12 p.m.
  {greeting <- "Good morning, "}
  else if (12< current_time && current_time < 18)#if it is after 12 p.m.
  {greeting <- "Good afternoon, "}
  else if (current_time >= 18) #if it is after 6 p.m.
  {greeting <- "Good evening, "}
  paste0(greeting,your_name,"!")
  #while loop
  i <- 1
  while (i < 4) {
    if (En_or_Fr == TRUE)
    {print(paste0(greeting,your_name,"!"))}
    else {print(paste0("Bonjour, ", your_name, "!"))}
    i <- i + 1
  }
}
hello_world("happy", 10)
hello_world("happy",12)
hello_world("happy", 16)
hello_world("happy", 20)
hello_world("happy",18)
hello_world("happy",0)
hello_world("Happy",18,4,T)
hello_world("Happy",7,2,F)
hello_world("Happy",1,7,T)
