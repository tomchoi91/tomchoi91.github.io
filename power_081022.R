# setup

# install.packages("EnvStats")
library(EnvStats)
?EnvStats

?propTestN
?p.adjust


samplesize <- propTestN(0.22, 0.18, alpha =0.01, power = 0.85,
                       sample.type = "one.sample",
                       approx = F)
samplesize

# one sample prop test
propTestN(0.22, 0.18, alpha =0.01, power = 0.85,
          sample.type = "one.sample", approx = F)

# two sample prop test
# choose max(n) for each group
power.prop.test(p1=0.22,p2=0.44, sig.level = 0.05, power=0.8)
power.prop.test(p1=0.44,p2=0.66, sig.level = 0.05, power=0.8)
power.prop.test(p1=0.22,p2=0.66, sig.level = 0.05, power=0.8)

?power.prop.test
?power.t.test

install.packages("pwr")
library(pwr)
# for non-balanced design (different sample size)
# add more conditions
pwr.2p.test()
pwr.t.test()

# dropoff rate (dropover rate)
0.2

# accrual time (varying time of measurement)


# survival analysis
# risk ratio
# median survival raito
# if two group survival trajectories (KMC) do not overlap (CI) -> significant
300 / 500?