********************************************************************************
* BIVARIATE REGRESSION — QUALITY OF GOVERNMENT DATASET
* Statistics for Political Science
* Builds on bivariate-qog.do — Case 3 pairs only, now with regression
********************************************************************************

* Set working directory (Replace with the path to YOUR folder)
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load the Quality of Government dataset
use "data-raw/Quality_of_Government_2026.dta", clear

********************************************************************************
* PAIR 1: Inequality (wdi_gini) and Women in Parliament (wdi_wip)
* Research question: Do more unequal countries have lower women's representation?
********************************************************************************

* Scatterplot with regression line
twoway (scatter wdi_wip wdi_gini) (lfit wdi_wip wdi_gini), leg(off) ///
	title("Inequality and Women in Parliament") ///
	subtitle("By Country") ///
 	ytitle("Women in Parliament (%)") ///
	xtitle("Gini Index")
	
* Bivariate regression
reg wdi_wip wdi_gini

* --- READING THE OUTPUT ---
* Coefficient (wdi_gini)   — slope: change in wdi_wip per 1-unit increase in wdi_gini
* [95% conf. interval]     — if this excludes 0, reject H0
* P>|t|                    — p-value; reject H0 if p < 0.05
* R-squared                — share of variance in wdi_wip explained by wdi_gini

********************************************************************************
* PAIR 2: Inequality (wdi_gini) and Corruption Perceptions (ti_cpi)
* Research question: Do more unequal countries have higher perceived corruption?
* Note: higher ti_cpi = cleaner (less corrupt)
********************************************************************************

use "data-raw/Quality_of_Government_2026.dta", clear

* Scatterplot with regression line
twoway (scatter ti_cpi wdi_gini) (lfit ti_cpi wdi_gini), leg(off) ///
	title("Inequality and Corruption Perceptions") ///
	ytitle("Corruption Perceptions Index (higher = cleaner)") ///
	xtitle("Gini Index")

* Bivariate regression
regress ti_cpi wdi_gini

* --- READING THE OUTPUT ---
* Coefficient (wdi_gini)   — slope: change in ti_cpi per 1-unit increase in wdi_gini
* [95% conf. interval]     — if this excludes 0, reject H0
* P>|t|                    — p-value; reject H0 if p < 0.05
* R-squared                — share of variance in ti_cpi explained by wdi_gini

********************************************************************************
* PAIR 3: Internet Usage (wdi_internet) and Press Freedom (rsf_pfi)
* Research question: Do countries with more internet access have more press freedom?
* Note: higher rsf_pfi = more press freedom
********************************************************************************

use "data-raw/Quality_of_Government_2026.dta", clear

* Scatterplot with regression line
twoway (scatter rsf_pfi wdi_internet) (lfit rsf_pfi wdi_internet), leg(off) ///
	title("Internet Usage and Press Freedom") ///
	ytitle("Press Freedom Index (higher = more free)") ///
	xtitle("Internet Users (%)")

* Bivariate regression
regress rsf_pfi wdi_internet

* --- READING THE OUTPUT ---
* Coefficient (wdi_internet) — slope: change in rsf_pfi per 1pp increase in internet use
* [95% conf. interval]       — if this excludes 0, reject H0
* P>|t|                      — p-value; reject H0 if p < 0.05
* R-squared                  — share of variance in rsf_pfi explained by wdi_internet

********************************************************************************
* END OF DO-FILE
********************************************************************************
