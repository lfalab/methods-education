* ----------------------------------------------------------------------
* Standard Error — British Election Study 2024
* Statistics for Political Science
* ----------------------------------------------------------------------

* Set working directory (Replace with the path to folder on your computer)
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load the BES dataset
use "data-raw/British_Election_Study_2024.dta", clear

* ----------------------------------------------------------------------
* Clean variables: recode negative values (refusals, don't know) to missing
* ----------------------------------------------------------------------

* Ideology: left-right self-placement (0 = Left, 10 = Right)
replace e01 = . if e01 < 0

* Age of respondent
replace Age = . if Age < 0

* ----------------------------------------------------------------------
* Regression: Ideology on Age
* ----------------------------------------------------------------------

regress e01 Age
