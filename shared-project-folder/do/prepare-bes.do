********************************************************************************
* DATA PREPARATION — BRITISH ELECTION STUDY 2024
* Demonstrating four core cleaning and transformation operations
********************************************************************************

* Set working directory (replace with the path to YOUR folder)
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load the raw BES dataset
use "data-raw/British_Election_Study_2024.dta", clear

********************************************************************************
* OPERATION 1: Recode invalid values to missing
* BES uses negative numbers to encode missing/refused/don't know responses
* Stata uses . to represent missing — we must recode before analysing
********************************************************************************

replace Age   = . if Age   < 0    /* age of respondent */
replace e01   = . if e01   < 0    /* left-right self-placement */

********************************************************************************
* OPERATION 2: Drop observations based on a condition
* Example: restrict analysis to Daily Mail and Telegraph readers only
* k03: newspaper readership (7 = Daily Mail, 13 = Daily Telegraph)
********************************************************************************

drop if k03 != 7 & k03 != 13

* Equivalent using keep if — same result, different logical framing:
* keep if k03 == 7 | k03 == 13

********************************************************************************
* OPERATION 3: Generate a binary variable from a logical statement
* Example: create a binary variable for whether the respondent voted Reform
* The expression (b02 == 8) returns 1 if true, 0 if false
* Condition: only assign values where b02 is not missing
********************************************************************************

generate voted_reform = (b02 == 8) if b02 != .

* Attach value labels so output is readable
label define reform_lbl 1 "Reform" 0 "Another Party"
label values voted_reform reform_lbl

* Check the result
tabulate voted_reform

********************************************************************************
* OPERATION 4: Save the cleaned dataset to the data-clean folder
* Always keep raw data unchanged — save cleaned data separately
********************************************************************************

save "data-clean/bes_clean.dta", replace

********************************************************************************
* END OF DO-FILE
********************************************************************************
