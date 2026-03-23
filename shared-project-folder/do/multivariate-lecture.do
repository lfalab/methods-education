* ----------------------------------------------------------------------
* Lecture 10: Multivariate Regression
* Brexit Regional Dataset
* ----------------------------------------------------------------------

* Set working directory (Replace with the path to folder on your computer)
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load the Brexit Regional dataset
use "data-raw/Brexit_Regional.dta", clear

* ----------------------------------------------------------------------
* MODEL 1: Bivariate — Import shock
* ----------------------------------------------------------------------

regress leave_share import_shock

* ----------------------------------------------------------------------
* MODEL 2: Multivariate — Import shock and immigrant share
* ----------------------------------------------------------------------

regress leave_share import_shock immigrant_share

* ----------------------------------------------------------------------
* MODEL 3: Multivariate — Import shock and education
* ----------------------------------------------------------------------

regress leave_share import_shock share_high_skill 

* ----------------------------------------------------------------------
* MODEL 4: Multivariate — Import shock, education, and immigrant share
* ----------------------------------------------------------------------

regress leave_share import_shock immigrant_share share_high_skill 