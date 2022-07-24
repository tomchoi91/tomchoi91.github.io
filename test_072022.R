install.packages("MatchIt")
install.packages("optmatch")
library(MatchIt)
data("lalonde", package = "MatchIt")

?matchit

# 1:1 nearest neighbor matching with replacement on 
# the Mahalanobis distance
m.out <- matchit(treat ~ age + educ + race + married + 
                     nodegree + re74 + re75, 
                 data = lalonde, estimand="ATT", distance = "mahalanobis",
                 replace = TRUE)
m.out

#Checking balance before and after matching:
summary(m.out)

<<<<<<< Updated upstream
install.packages("gtsummary")
install.packages("rlang")
library(gtsummary)

trial2 <- trial %>% select(trt, age, grade)
trial2 %>% tbl_summary()
sum(is.na(trial2$age))
trial2 %>% tbl_summary(by = trt) %>% add_p()
=======


>>>>>>> Stashed changes
