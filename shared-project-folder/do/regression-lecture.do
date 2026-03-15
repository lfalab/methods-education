* ----------------------------------------------------------------------
* Lecture 8: Bivariate Regression
* Brexit Regional Dataset
* ----------------------------------------------------------------------

* Set your working directory
* Replace the path below with the folder where you saved the project.
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* ----------------------------------------------------------------------
* EXAMPLE: Higher education share and the Leave vote
* (This is the example from the Stata video — run it first)
* ----------------------------------------------------------------------

use "data-raw/Brexit_Regional.dta", clear

* Scatterplot with regression line
twoway (scatter leave_share share_high_skill) ///
       (lfit leave_share share_high_skill), leg(off) ///
       ytitle("Share of Leave Votes") ///
       xtitle("Share with Higher Education (%)") ///
       title("Education and Brexit") subtitle("By UK Region")

* Bivariate regression
regress leave_share share_high_skill

* --- READING THE OUTPUT ---
* Coefficient (share_high_skill) — slope (β̂₁)
* _cons                          — intercept (β̂₀)
* [95% conf. interval]           — if this excludes 0, reject H0
* P>|t|                          — p-value; reject H0 if p < 0.05
* R-squared                      — share of variance in y explained by x

* ----------------------------------------------------------------------
* YOUR TURN 1: Import shock and the Leave vote
* Research question: Do regions more exposed to Chinese import competition
* vote Leave more?
* import_shock: import shock from China (source: ONS and Eurostat)
* ----------------------------------------------------------------------

use "data-raw/Brexit_Regional.dta", clear

* YOUR TURN — State H0:
* YOUR TURN — State H1:

* Scatterplot
twoway (scatter leave_share import_shock) ///
       (lfit leave_share import_shock), leg(off) ///
       ytitle("Share of Leave Votes") ///
       xtitle("Import Shock from China") ///
       title("Import Shock and Brexit") subtitle("By UK Region")

* YOUR TURN — Run the regression:
regress leave_share import_shock

* What is the sign of the slope? What does it mean substantively?
* Write the regression equation: Leave_hat = ___ + ___ * import_shock
* Does the 95% CI exclude zero? Do we reject or fail to reject H0?
* What is R-squared? How does it compare to the education model?

* ----------------------------------------------------------------------
* YOUR TURN 2: Immigrant share and the Leave vote
* Research question: Do regions with larger foreign-born populations
* vote Leave more or less?
* immigrant_share: share of foreign-born residents in 2015 (source: ONS)
* ----------------------------------------------------------------------

use "data-raw/Brexit_Regional.dta", clear

* YOUR TURN — State H0:
* YOUR TURN — State H1:

* Scatterplot
twoway (scatter leave_share immigrant_share) ///
       (lfit leave_share immigrant_share), leg(off) ///
       ytitle("Share of Leave Votes") ///
       xtitle("Share of Foreign-Born Residents (%)") ///
       title("Immigrant Share and Brexit") subtitle("By UK Region")

* YOUR TURN — Run the regression:
* regress leave_share immigrant_share

* What is the sign of the slope? Is it what you expected?
* Write the regression equation: Leave_hat = ___ + ___ * immigrant_share
* Does the 95% CI exclude zero? Do we reject or fail to reject H0?
* What is R-squared? How does it compare to the other two models?

* ----------------------------------------------------------------------
* END OF DO-FILE
* ----------------------------------------------------------------------
