* ----------------------------------------------------------------------
* Lecture 5: Describing Correlations — Bivariate Analysis
* British Election Study (BES) and Brexit Regional Dataset
* ----------------------------------------------------------------------

* Set your working directory
* Replace the path below with the folder where you saved the project.
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* ----------------------------------------------------------------------
* CASE 1: NOMINAL + NOMINAL
* Tools: Cross-tabulation and bivariate bar chart
* ----------------------------------------------------------------------

* Load the BES dataset
use "data-raw/British_Election_Study_2024.dta", clear

* Clean variables
replace b02 = . if b02 < 0   /* vote choice */
replace y09 = . if y09 < 0   /* gender */

* --- EXAMPLE: Gender and vote choice ---

* Cross-tabulation with column percentages - with frequencies
tabulate b02 y09, column

* Cross-tabulation with column percentages - percentages only
tabulate b02 y09, column nofreq

* Bivariate bar chart

* Note: the video uses catplot for this chart. We use graph hbar here
* because catplot has changed since the video was recorded. The output
* is equivalent.

* gender and vote choice - bivariate frequency chart (raw)
graph hbar (count), over(y09) over(b02) asyvars

* gender and vote choice - bivariate frequency chart (polished)
graph hbar (count), over(y09) over(b02) asyvars title("Gender and Vote Choice") subtitle("British Election Study, 2024") name(bes_gender_vote, replace)
* save
graph export "output/bes_gender_vote.jpg", as(jpg) name(bes_gender_vote) quality(100) replace

* --- YOUR TURN: Gender and interest in politics (a03) ---
* Clean "interest in politics" variable first
replace a03 = . if a03 < 0

* [Write your commands here]
* Do cross tabulation with column percentages to check: 
* what % of men/women are interested in politics?
* Then, visualise with bivariate bar charts
* Try starting with the chart in a "raw" format and then polishing it

* ----------------------------------------------------------------------
* CASE 2: NOMINAL + NUMERIC
* Tools: Compare means and bar chart of means
* ----------------------------------------------------------------------

* Reload the BES dataset
use "data-raw/British_Election_Study_2024.dta", clear

* Clean variables
replace k03 = . if k03 < 0   /* newspaper readership */
replace e01 = . if e01 < 0   /* left-right self-placement (ideology) */

* --- EXAMPLE: Newspaper readership and ideology ---

* Compare means by group
sort k03
by k03: summarize e01

* Bar chart with means
graph hbar e01, over(k03) title("Favourite Newspaper and Ideology") subtitle("British Election Study, 2024") ytitle("Mean self-placed ideology (0 = Left; 10 = Right)") name(bes_news_ideol, replace)

* Save
graph export "output/bes_news_ideol.jpg", as(jpg) name(bes_news_ideol) quality(100) replace

* --- YOUR TURN: Socio-economic class (sc) and ideology ---

* [Write your commands here]

* ----------------------------------------------------------------------
* CASE 3: NUMERIC + NUMERIC
* Tools: Scatterplot and regression line
* ----------------------------------------------------------------------

* Load the Brexit Regional dataset
use "data-raw/Brexit_Regional.dta", clear

* --- EXAMPLE: Import shock and Leave vote share ---

* Scatterplot with regression line

twoway (scatter leave_share import_shock) (lfit leave_share import_shock), leg(off)

twoway (scatter leave_share import_shock) (lfit leave_share import_shock), leg(off) ytitle("Share of Leave Votes") title("Import Shock and Brexit") subtitle("By UK Region") name(brexit_shock_scatter_line, replace)

* Save
graph export "output/brexit_shock_scatter_line.jpg", as(jpg) name(brexit_shock_scatter_line) quality(100) replace

* --- YOUR TURN: Share of population with higher ed (share_high_skill) and Leave vote share ---

* [Write your commands here]