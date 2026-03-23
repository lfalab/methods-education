library(tidyverse)
library(readxl)
WDI <- read_excel("C:/Users/leona/OneDrive - King's College London/methods-education/r/data/WDIH.xlsx")

new <- WDI %>% pivot_wider(names_from = variable,
                    values_from = value)

new %>% ggplot(aes(x = log(health), y = log(carbon + 1))) +
  geom_point(size = 2, color = "royalblue") + theme_minimal() +
  theme(text = element_text(size = 16), 
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) +
  labs(x = element_blank(), y = element_blank())
  
