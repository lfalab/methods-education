********************************************************************************
* BIVARIATE ANALYSIS — QUALITY OF GOVERNMENT DATASET
* Statistics for Political Science
* This do-file demonstrates how to analyze relationships between two variables
********************************************************************************

* Set working directory (Replace with the path to YOUR folder)
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load the Quality of Government dataset
use "data-raw/Quality_of_Government_2026.dta", clear

********************************************************************************
* CASE 1: BOTH VARIABLES ARE NOMINAL
* Tool: Cross-tabulation and bivariate frequency chart
********************************************************************************

* EXAMPLE 1: Democracy status (bmr_dem) vs colonial origin (ht_colonial)
*-------------------------------------------------------------------------------
* Research question: Do countries with different colonial histories differ 
* in their likelihood of being democratic today?

* Cross-tabulation with column percentages
tabulate ht_colonial bmr_dem, column

* Bivariate frequency chart
graph hbar (count), over(bmr_dem) over(ht_colonial) asyvars

* EXAMPLE 2: Electoral system (gol_est) vs world region (ht_region)
*-------------------------------------------------------------------------------
* Research question: Do countries in different regions of the world have 
* different electoral systems?

* Cross-tabulation with row percentages
tabulate ht_region gol_est, row

* Bivariate frequency chart
graph hbar (count), over(gol_est) over(ht_region) asyvars

********************************************************************************
* CASE 2: ONE NOMINAL, ONE NUMERIC
* Tool: Compare means (table) and bar chart of means
********************************************************************************

* EXAMPLE 1: Colonial origin (ht_colonial) vs corruption perceptions (ti_cpi)
*-------------------------------------------------------------------------------
* Research question: Do countries with different colonial histories differ 
* in their corruption perception levels?

* Compare means using sort and by
sort ht_colonial
by ht_colonial: summarize ti_cpi

* Bar chart of means
graph hbar ti_cpi, over(ht_colonial) ///
	title("Corruption and Colonial History") ///
	ytitle("Mean Corruption Level")

* EXAMPLE 2: Electoral system (gol_est) vs voter turnout (ideavt_legvt)
*-------------------------------------------------------------------------------
* Research question: Do countries with different electoral systems differ 
* in their levels of turnout?

* Compare means using sort and by
sort gol_est
by gol_est: summarize ideavt_legvt

* Bar chart of means
graph hbar ideavt_legvt, over(gol_est) ///
	title("Mean Turnout by Electoral System Type") ///
	ytitle("Mean Voter Turnout")

********************************************************************************
* CASE 3: BOTH VARIABLES ARE NUMERIC
* Tool: Scatterplot and regression line
********************************************************************************

* EXAMPLE 1: Inequality (wdi_gini) vs women in parliament (wdi_wip)
*-------------------------------------------------------------------------------
* Research question: Do countries with different inequality levels have 
* different rates of women representation in parliament?

* Scatterplot with regression line
twoway (scatter wdi_wip wdi_gini) (lfit wdi_wip wdi_gini), leg(off) ///
	title("Inequality and Percentage of Women in Parliament") ///
	ytitle("Percentage of Women in Parliament")

* EXAMPLE 2: Inequality (wdi_gini) vs corruption perceptions (ti_cpi)
*-------------------------------------------------------------------------------
* Research question: Do countries with different inequality levels have 
* different corruption perception levels?

* Scatterplot with regression line
twoway (scatter ti_cpi wdi_gini) (lfit ti_cpi wdi_gini), leg(off) ///
	title("Inequality and Corruption Perceptions") ///
	ytitle("Corruption Perceptions Index") ///
	caption("Higher CPI scores = cleaner; Lower scores = more corrupt")

* EXAMPLE 3: Internet usage (wdi_internet) vs press freedom (rsf_pfi)
*-------------------------------------------------------------------------------
* Research question: Do countries with different levels of internet usage 
* have different levels of press freedom?

* Scatterplot with regression line
twoway (scatter rsf_pfi wdi_internet) (lfit rsf_pfi wdi_internet), leg(off) ///
	title("Internet Usage and Press Freedom") ///
	ytitle("Press Freedom Index")
