library(tidyverse)

d <- read_csv("C:/Users/leona/OneDrive - King's College London/methods-education/r/data/WDIH_gdp.csv",
              show_col_types = FALSE)

# Prepare variables (log scale, filter zero-carbon countries)
d <- d %>%
  filter(carbon > 0, !is.na(gdp_pc)) %>%
  mutate(log_health = log(health),
         log_carbon = log(carbon * 907.185),
         log_gdp_pc = log(gdp_pc))

# Bivariate: log(carbon) ~ log(health)
m1 <- lm(log_carbon ~ log_health, data = d)
cat("=== Bivariate: log(carbon) ~ log(health) ===\n\n")
print(summary(m1))

# Multivariate: log(carbon) ~ log(health) + log(gdp_pc)
m2 <- lm(log_carbon ~ log_health + log_gdp_pc, data = d)
cat("\n=== Multivariate: log(carbon) ~ log(health) + log(gdp_pc) ===\n\n")
print(summary(m2))
