# Generate stargazer regression table for the mock exam
# Brexit Regional data: Leave Vote Share ~ Higher Education + Immigrant Share
# Output: documents/mock_exam_reg_table.html

library(haven)
library(stargazer)

# Load data
brexit <- read_dta("shared-project-folder/data-raw/Brexit_Regional.dta")

# Run three models
m1 <- lm(leave_share ~ share_high_skill, data = brexit)
m2 <- lm(leave_share ~ immigrant_share, data = brexit)
m3 <- lm(leave_share ~ share_high_skill + immigrant_share, data = brexit)

# Generate stargazer HTML table
stargazer(m1, m2, m3,
          type = "html",
          covariate.labels = c("Higher Education (%)",
                               "Immigrant Share (%)"),
          dep.var.labels = "Leave Vote Share (%)",
          omit.stat = c("adj.rsq", "ser", "f"),
          out = "documents/mock_exam_reg_table.html")
