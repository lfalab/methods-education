library(haven)
library(modelsummary)

# Load QoG dataset
d <- read_dta("C:/Users/leona/OneDrive - King's College London/methods-education/shared-project-folder/data-raw/Quality_of_Government_2026.dta")

# Complete cases across all three models
cc <- na.omit(d[, c("rsf_pfi", "wdi_internet", "wdi_gini")])
cat("N complete cases:", nrow(cc), "\n\n")

# Three models
m1 <- lm(rsf_pfi ~ wdi_internet, data = cc)
m2 <- lm(rsf_pfi ~ wdi_gini, data = cc)
m3 <- lm(rsf_pfi ~ wdi_internet + wdi_gini, data = cc)

models <- list("(1)" = m1, "(2)" = m2, "(3)" = m3)

# Print publication-style table to console
modelsummary(models,
             stars = c("*" = 0.1, "**" = 0.05, "***" = 0.01),
             coef_map = c("wdi_internet" = "Internet Users (%)",
                          "wdi_gini" = "Gini Index",
                          "(Intercept)" = "Constant"),
             gof_map = c("nobs", "r.squared"),
             output = "markdown",
             title = "Dependent variable: Press Freedom Index")
