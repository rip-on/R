setwd("C:/Users/liver/Downloads/R")

d <- read.csv("claude.csv")
d
tail(d)
head(d)
summary(d)
str(d)
var(d$score)
var(d$age)
sd(d$score)
hist(d$score, main = "My Data", col = "skyblue")
shapiro.test(d$score)

setwd("C:/Users/liver/Downloads/")
myData <- read.csv("group_4.txt")
myData
str(myData)

setwd("C:/Users/liver/Downloads/")
myDatum <- read.csv("group_4.txt")
myDatum
summary(myDatum)
str(myDatum)
install.packages(c("usethis", "gitcreds"))
usethis::use_git_config(user.name = "rip-on", user.email = "livripon@gmail.com")
install.packages("usethis", dependencies = TRUE)
