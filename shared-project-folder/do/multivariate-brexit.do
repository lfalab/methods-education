* ----------------------------------------------------------------------
* Multivariate Regression — Brexit Regional Dataset
* Statistics for Political Science
* ----------------------------------------------------------------------

* Set working directory (Replace with the path to folder on your computer)
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load the Brexit Regional dataset
use "data-raw/Brexit_Regional.dta", clear

* ----------------------------------------------------------------------
* MODEL 1: Bivariate — Education and the Leave vote
* ----------------------------------------------------------------------

regress leave_share share_high_skill

* ----------------------------------------------------------------------
* MODEL 2: Bivariate — Immigration and the Leave vote
* ----------------------------------------------------------------------

regress leave_share immigrant_share

* ----------------------------------------------------------------------
* MODEL 3: Multivariate — Education and immigration together
* ----------------------------------------------------------------------

regress leave_share share_high_skill immigrant_share
