# install.packages("MatchIt")
# install.packages("optmatch")
library(MatchIt)
library(dplyr, warn.conflicts = FALSE)
library(stringr)
library(broom)
# install.packages("gt")
library(gt)
# install.packages("gtsummary")
# install.packages("rlang")
library(gtsummary)

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



trial2 <- trial %>% select(trt, age, grade)
trial2 %>% tbl_summary()
sum(is.na(trial2$age))
trial2 %>% tbl_summary(by = trt) %>% add_p() %>% separate_p_footnotes()
# %>% add_n()
# %>% add_difference()
# %>% add_p()
# %>% add_q()
# %>% add_overall()
?add_q()


# Example 1 ----------------------------------
# fn returns t-test pvalue
my_ttest <- function(data, variable, by, ...) {
    t.test(data[[variable]] ~ as.factor(data[[by]]))$p.value
}
?t.test
add_stat_ex1 <-
    trial %>%
    select(trt, age, marker) %>%
    tbl_summary(by = trt, missing = "no") %>%
    add_stat(fns = everything() ~ my_ttest) %>%
    modify_header(
        list(
            add_stat_1 ~ "**p-value**",
            all_stat_cols() ~ "**{level}**"
        )
    )
add_stat_ex1

# Example 2 ----------------------------------
# fn returns t-test test statistic and pvalue
my_ttest2 <- function(data, variable, by, ...) {
    t.test(data[[variable]] ~ as.factor(data[[by]])) %>%
        broom::tidy() %>%
        mutate(
            stat = str_glue("t={style_sigfig(statistic)}, {style_pvalue(p.value, prepend_p = TRUE)}")
        ) %>%
        pull(stat)
}

?style_sigfig
?style_pvalue

?t.test
# c(7:20)
# 1:10
mean(1:10)
mean(7:20)
aaa <- t.test(1:10, y = c(7:20)) 
# %>%
    # tidy()
str(aaa)
class(aaa)
# ?pull
# ?str_glue
?tidy

add_stat_ex2 <-
    trial %>%
    select(trt, age, marker) %>%
    tbl_summary(by = trt, missing = "no"
                # , statistic = all_continuous() ~ "{mean} ({sd})"
                ) %>%
    add_overall() %>%
    add_stat(fns = all_continuous() ~ my_ttest2) %>%
    modify_header(add_stat_1 ~ "**Treatment Comparison**") 
add_stat_ex2



# fit models
a <- lm(mpg ~ wt + qsec + disp, mtcars)
b <- lm(mpg ~ wt + qsec, mtcars)

mod <- anova(a, b)
?anova
# summarize model fit with tidiers
mod
tidy(mod)
glance(mod)


trial2 %>%
    tbl_summary(
        by = trt,
        statistic = list(all_continuous() ~ "{mean} ({sd})",
                         all_categorical() ~ "{n} / {N} ({p}%)"),
        digits = list(all_continuous() ~ 2),
        label = list(grade ~ "Tumor Grade", age ~ "Age"),
        # missing = "no",
        missing_text = "(Missing)"
    )

?tbl_summary

trial2 %>%
    tbl_summary(by = trt) %>%
    add_p(pvalue_fun = ~style_pvalue(.x, digits = 2)) %>%
    add_overall() %>%
    add_n() %>%
    modify_header(label ~ "**Variable**") %>%
    modify_spanning_header(c("stat_1", "stat_2") ~ "**Treatment Received**") %>%
    modify_footnote(
        all_stat_cols() ~ "Median (IQR) or Frequency (%)"
    ) %>%
    modify_caption("**Table 1. Patient Characteristics**") %>%
    bold_labels()


# Example adding tbl_summary()-family functions

trial2 %>%
    tbl_summary(by = trt) %>%
    add_p(pvalue_fun = ~style_pvalue(.x, digits = 2)) %>%
    add_overall() %>%
    add_n() %>%
    modify_header(label ~ "**Variable**") %>%
    modify_spanning_header(c("stat_1", "stat_2") ~ "**Treatment Received**") %>%
    modify_footnote(
        all_stat_cols() ~ "Median (IQR) or Frequency (%)"
    ) %>%
    modify_caption("**Table 1. Patient Characteristics**") %>%
    bold_labels() 
# %>%
    # bold_levels()


# Multi-line Continuous Summaries

trial2 %>%
    select(age, trt) %>%
    tbl_summary(
        by = trt,
        type = all_continuous() ~ "continuous2",
        statistic = all_continuous() ~ c("{N_nonmiss}",
                                         "{median} ({p25}, {p75})", 
                                         "{min}, {max}"),
        missing = "no"
    ) %>%
    add_p(pvalue_fun = ~style_pvalue(.x, digits = 2))


aaa <- tbl_summary(trial2) 
# %>% as_gt(return_calls = TRUE) 
# %>% head(n = 4)
?as_gt
aaa
tbl_summary(trial2)
tbl_summary(trial2) %>% as_gt()
