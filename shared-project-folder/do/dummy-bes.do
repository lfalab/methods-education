* ----------------------------------------------------------------------
* Lecture 11: Dummy Variables — Gender and Ideology
* British Election Study (BES), 2024
* ----------------------------------------------------------------------

* Set your working directory
* Replace the path below with the folder where you saved the project.
cd "C:\Users\k2588471\OneDrive - King's College London\methods-education\shared-project-folder"

* ----------------------------------------------------------------------
* HOW THIS FILE IS ORGANISED
* ----------------------------------------------------------------------
* 1. Load and clean BES data
* 2. Create a dummy variable for gender
* 3. Descriptive comparison of ideology by gender
* 4. Survey-weighted regression: ideology on gender dummy
* ----------------------------------------------------------------------

* Load the BES dataset
use "data-raw/British_Election_Study_2024.dta", clear

* Clean variables: recode negative values (survey codes for missing) to Stata missing
replace y09 = . if y09 < 0   /* gender */
replace e01 = . if e01 < 0   /* left-right self-placement (0=Left, 10=Right) */

* Restrict to male (1) and female (2) respondents
keep if y09 == 1 | y09 == 2

* ----------------------------------------------------------------------
* CREATE THE DUMMY VARIABLE
* ----------------------------------------------------------------------

* Generate dummy: woman = 1 if female, 0 if male
generate woman = (y09 == 2) if y09 != .
label define woman_lbl 0 "Man" 1 "Woman"
label values woman woman_lbl

* Check: tabulate the dummy to verify coding
tabulate woman

* ----------------------------------------------------------------------
* DESCRIPTIVE: MEAN IDEOLOGY BY GENDER
* ----------------------------------------------------------------------

* Compare mean ideology for men and women
bysort woman: summarize e01

* ----------------------------------------------------------------------
* SURVEY-WEIGHTED REGRESSION
* ----------------------------------------------------------------------

* Declare the BES survey design. wt_demog adjusts for age, sex, and region.
svyset [pweight=wt_demog]

* Run the weighted regression: ideology = B0 + B1(woman) + error
svy: regress e01 woman

* --- READING THE OUTPUT ---
* The intercept (B0) is the predicted ideology for the reference group (men).
* The coefficient on woman (B1) is the predicted difference for women.
* A negative B1 means women are more left-leaning on average.

* ----------------------------------------------------------------------
* END OF DO-FILE
* ----------------------------------------------------------------------
