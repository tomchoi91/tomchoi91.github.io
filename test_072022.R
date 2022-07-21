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
