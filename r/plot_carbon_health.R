library(tidyverse)
library(readxl)
# library(here)
WDI <- read_excel("C:/Users/leona/OneDrive - King's College London/methods-education/r/data/WDIH.xlsx")

new <- WDI %>% 
  pivot_wider(names_from = variable, values_from = value) %>% 
  filter(carbon > 0) %>% 
  mutate(log_health = log(health),
         log_carbon = log(carbon*907.185))

new %>% ggplot(aes(x = log(health), y = log(carbon*907.185))) +
  geom_point(size = 2) + 
  geom_smooth(method = "lm", color = "red", se = F) +
  theme_minimal() +
  theme(text = element_text(size = 16), 
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) +
  labs(x = element_blank(), y = element_blank())

m1 <- lm(log_carbon ~ log_health, data = new)
summary(m1)

new %>% ggplot(aes(x = log(health), y = log(carbon*907.185), label = code)) +
  geom_text(check_overlap = TRUE) +
  theme_minimal() +
  # theme(text = element_text(size = 16), 
  #       panel.grid.major.x = element_blank(),
  #       panel.grid.minor.x = element_blank()) +
  labs(x = element_blank(), y = element_blank())
  
