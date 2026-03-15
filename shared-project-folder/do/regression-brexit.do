* Set WD
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load dataset
use "data-raw/Brexit_Regional.dta", clear

*--------------------------------------------------------------------
* Regression 1: Leave vote and share of population with higher ed
*--------------------------------------------------------------------

* Scatterplot and regression line
twoway (scatter leave_share share_high_skill) (lfit leave_share share_high_skill), leg(off) ytitle("Share of Leave Votes") title("Education and Brexit") subtitle("By UK Region") name(brexit_educ_scatter_line, replace)
* save
graph export "output/brexit_educ_scatter_line.jpg", as(jpg) name(brexit_educ_scatter_line) quality(100) replace

* Regression
regress leave_share share_high_skill

*--------------------------------------------------------------------
* Regression 2: Leave vote and unemployment
*--------------------------------------------------------------------

* Scatterplot and regression line
twoway (scatter leave_share unemployment) (lfit leave_share unemployment), leg(off) ytitle("Share of Leave Votes") title("Unemployment and Brexit") subtitle("By UK Region") name(brexit_unemp_scatter_line, replace)
* save
graph export "output/brexit_unemp_scatter_line.jpg", as(jpg) name(brexit_unemp_scatter_line) quality(100) replace

* Regression
reg leave_share unemployment