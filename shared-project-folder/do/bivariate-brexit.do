* ----------------------------------------------------------------------
* Describing correlations (bivariate description) - Brexit dataset
* ----------------------------------------------------------------------

* Set your working directory
* Replace the path below with the folder where you saved the project.
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load dataset
use "data-raw/Brexit_Regional.dta", clear

* ----------------------------------------------------------------------
* Let's start by describing distributions (univariate description)
* ----------------------------------------------------------------------

* Histogram of share of leave votes
* ----------------------------------------------------------------------
hist leave_share, width(5) start(20) xlabel(20(5)80) frequency title("Share of Leave Votes in the Brexit Referendum") subtitle("By UK Region") name(brexit_leave_hist, replace)
* save
graph export "output/brexit_leave_hist.jpg", as(jpg) name(brexit_leave_hist) quality(100) replace

* Histogram of import shock
* ----------------------------------------------------------------------
hist import_shock, width(.1) start(0) xlabel(0(.1)1) frequency title("Distribution of Import Shock from China") subtitle("By UK Region") name(brexit_shock_hist, replace)
* save
graph export "output/brexit_shock_hist.jpg", as(jpg) name(brexit_shock_hist) quality(100) replace

* Histogram of share of foreign born residents
* ----------------------------------------------------------------------
hist immigrant_share, width(5) start(0) xlabel(0(5)60) frequency title("Distribution of Share of Foreign Born Residents") subtitle("By UK Region, 2015") name(brexit_immig_hist, replace)
* save
graph export "output/brexit_immig_hist.jpg", as(jpg) name(brexit_immig_hist) quality(100) replace

* Histogram of share of unemployment rates
* ----------------------------------------------------------------------
hist unemployment, width(1) start(0) xlabel(0(1)14) frequency title("Unemployment Rates by UK Region") name(brexit_unemp_hist, replace)
* save
graph export "output/brexit_unemp_hist.jpg", as(jpg) name(brexit_unemp_hist) quality(100) replace

* ----------------------------------------------------------------------
* Now let's look at correlations (bivariate description)
* ----------------------------------------------------------------------

* Share of Leave votes and import shock
* ----------------------------------------------------------------------

* Just the scatter plot
twoway (scatter leave_share import_shock)

* Add regression line
twoway (scatter leave_share import_shock) (lfit leave_share import_shock)

* Polishing the scatter plot (without the regression line)
twoway (scatter leave_share import_shock), leg(off) ytitle("Share of Leave Votes") title("Import Shock and Brexit") subtitle("By UK Region") name(brexit_shock_scatter_noline, replace)
* save
graph export "output/brexit_shock_scatter_noline.jpg", as(jpg) name(brexit_shock_scatter_noline) quality(100) replace

* Polishing the scatter plot (with the regression line)
twoway (scatter leave_share import_shock) (lfit leave_share import_shock), leg(off) ytitle("Share of Leave Votes") title("Import Shock and Brexit") subtitle("By UK Region") name(brexit_shock_scatter_line, replace)
* save
graph export "output/brexit_shock_scatter_line.jpg", as(jpg) name(brexit_shock_scatter_line) quality(100) replace

* Share of Leave votes and unemployment
* ----------------------------------------------------------------------

twoway (scatter leave_share unemployment) (lfit leave_share unemployment), leg(off) ytitle("Share of Leave Votes") title("Unemployment and Brexit") subtitle("By UK Region") name(brexit_unemp_scatter_line, replace)
* save
graph export "output/brexit_unemp_scatter_line.jpg", as(jpg) name(brexit_unemp_scatter_line) quality(100) replace

* Share of Leave votes and share of migrants
* ----------------------------------------------------------------------

twoway (scatter leave_share immigrant_share) (lfit leave_share immigrant_share), leg(off) ytitle("Share of Leave Votes") title("Immigration Presence and Brexit") subtitle("By UK Region") name(brexit_immig_scatter_line, replace)
* save
graph export "output/brexit_immig_scatter_line.jpg", as(jpg) name(brexit_immig_scatter_line) quality(100) replace