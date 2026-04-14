* PS2 MODEL DO-FILE

* Do not include the path to your working directory in your do-file;
* Your do-file should start with the command that reads the dataset.
use "data-raw/Quality_of_Government_2026.dta", clear

* Research question: Is turnout higher in countries with proportional systems than in countries with majoritarian systems?

* Null Hypothesis (H0): Mean voter turnout is the same in majoritarian and proportional electoral systems.

* Alternative Hypothesis (H1): Proportional systems have higher turnout than majoritarian systems.

* Restrict to majoritarian (1) and proportional (2) systems
* Mixed systems (3) are excluded — we compare the two pure types.
keep if gol_est == 1 | gol_est == 2

* Restrict to countries with information about turnout
drop if missing(ideavt_legvt)

* Univariate description: Turnout
summarize ideavt_legvt
summarize ideavt_legvt, detail

* Univariate description: Electoral system type.
tabulate gol_est

* Bar chart of means
graph hbar ideavt_legvt, over(gol_est) ///
	title("Mean Turnout by Electoral System Type") ///
	ytitle("Mean Voter Turnout")

* Hypothesis test
ttest ideavt_legvt, by(gol_est)