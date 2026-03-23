library(tidyverse)
library(readxl)
library(WDI)

# Read the existing health/carbon data
WDI_raw <- read_excel("C:/Users/leona/OneDrive - King's College London/methods-education/r/data/WDIH.xlsx")

# Pivot to wide format
wdih <- WDI_raw %>%
  pivot_wider(names_from = variable, values_from = value)

# Download GDP per capita (current US$) from World Bank
gdp <- WDI(indicator = "NY.GDP.PCAP.CD", country = "all", start = 2022, end = 2023, extra = TRUE)

# Keep the most recent year per country and select relevant columns
gdp_clean <- gdp %>%
  filter(!is.na(NY.GDP.PCAP.CD)) %>%
  group_by(iso3c) %>%
  slice_max(year, n = 1) %>%
  ungroup() %>%
  select(iso3c, gdp_pc = NY.GDP.PCAP.CD, gdp_year = year)

# Merge by ISO3 country code
merged <- wdih %>%
  left_join(gdp_clean, by = c("code" = "iso3c"))

# Report merge diagnostics
cat("Total countries in WDIH:", nrow(wdih), "\n")
cat("Matched with GDP:", sum(!is.na(merged$gdp_pc)), "\n")
cat("Missing GDP:", sum(is.na(merged$gdp_pc)), "\n")
cat("GDP year used:", unique(na.omit(merged$gdp_year)), "\n")

# Save
write_csv(merged, "C:/Users/leona/OneDrive - King's College London/methods-education/r/data/WDIH_gdp.csv")
cat("Saved to r/data/WDIH_gdp.csv\n")
