* ----------------------------------------------------------------------
* Seminar 7: Hypothesis Tests — From Description to Inference
* British Election Study (BES), 2024
* ----------------------------------------------------------------------

* Set your working directory
* Replace the path below with the folder where you saved the project.
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* ----------------------------------------------------------------------
* HOW THIS FILE IS ORGANISED
* ----------------------------------------------------------------------
* Each test has two stages:
*   STAGE 1 — Unweighted (prtest / ttest): focuses on the inferential logic.
*   STAGE 2 — Survey-design-corrected (svy:): incorporates BES weights.
* The logic is identical across stages. Only the technical implementation changes.
* ----------------------------------------------------------------------

* ----------------------------------------------------------------------
* TEST 1: DIFFERENCE IN PROPORTIONS
* Are men more likely than women to have voted for Reform UK?
* ----------------------------------------------------------------------

* H0: No difference between men and women in their likelihood of voting Reform.
* H1: Men are more likely to vote Reform than women.

* Load the BES dataset
use "data-raw/British_Election_Study_2024.dta", clear

* Clean variables
replace b02 = . if b02 < 0   /* vote choice */
replace y09 = . if y09 < 0   /* gender */

* Restrict to male (1) and female (2) respondents
keep if y09 == 1 | y09 == 2

* Generate a binary variable: voted Reform (1) or not (0)
gen voted_reform = (b02 == 8) if b02 != .

* Labeling the values of the Reform variable: 
* We define "reform_lbl" as containing the information on the labels for each value
label define reform_lbl 1 "Reform" 0 "Another Party"
* Now we attach the labels set in "reform_lbl" to the "voted_reform" variable
label values voted_reform reform_lbl

* --- DESCRIPTIVE REMINDER ---
* Row percentages show the share of Reform voters by gender group.
tabulate y09 voted_reform, row nofreq

* Bivariate frequency chart
graph hbar (count), over(y09) over(voted_reform) asyvars ///
    title("Gender and Support for Reform UK") ///
    subtitle("British Election Study, 2024")

* ======================================================================
* STAGE 1: Unweighted test
* ======================================================================

* prtest compares the proportion of a binary variable across two groups.
prtest voted_reform, by(y09)

* --- READING THE OUTPUT ---
* Group 1 = Male (y09 == 1), Group 2 = Female (y09 == 2)
*
* diff               — estimated gap in proportions (Group 1 − Group 2)
* 95% Conf. Interval — if this excludes 0, reject H0
* Pr(|Z| > |z|)      — p-value; reject H0 if p < 0.05

* ======================================================================
* STAGE 2: Survey-design-corrected test
* ======================================================================

* Declare the BES survey design. wt_demog adjusts for age, sex, and region.
* Note: svyset stores the design but does not apply it automatically.
*       Always use the svy: prefix to invoke it.
svyset [pweight=wt_demog]

* Group-specific weighted proportions and CIs (descriptive):
svy: proportion voted_reform, over(y09)

* Weighted difference and CI (inferential):
svy: regress voted_reform i.y09

* --- VISUAL HEURISTIC ---
* The plot below shows the weighted point estimate for each group with its 95% CI.
* Rule of thumb: if one group's point estimate lies outside the other group's CI,
* the difference is likely significant. This is approximate — the formal test above
* is the definitive check.

* Generate the plot first
margins y09
marginsplot

* Add title subtitle, etc
marginsplot, ///
    title("Reform Vote Share by Gender") ///
    subtitle("British Election Study, 2024 — Survey-weighted estimates") ///
	caption("95% Confidence Intervals") ///
    ytitle("Proportion voted Reform")

* --- READING THE OUTPUT ---
* Focus on the svy: regress table.
* Reference group = Male (y09 = 1); coefficient = Female − Male proportion.
*
* coefficient        — difference in proportions (Female − Male)
* 95% Conf. Interval — if this excludes 0, reject H0

* ----------------------------------------------------------------------
* TEST 2: DIFFERENCE IN MEANS
* Are Telegraph readers more right-wing than Daily Mail readers?
* ----------------------------------------------------------------------

* H0: No difference in mean ideology between Mail and Telegraph readers.
* H1: Telegraph readers are more right-leaning than Mail readers.

* Reload the BES dataset
use "data-raw/British_Election_Study_2024.dta", clear

* Clean variables
replace k03 = . if k03 < 0   /* newspaper readership */
replace e01 = . if e01 < 0   /* left-right self-placement */

* Restrict to Daily Mail (7) and Telegraph (13) readers only
keep if k03 == 7 | k03 == 13

* --- DESCRIPTIVE REMINDER ---
* Group means show average ideology score by readership group.
by k03, sort: summarize e01

* ======================================================================
* STAGE 1: Unweighted test
* ======================================================================

* ttest compares the mean of a continuous variable across two groups.
ttest e01, by(k03)

* --- READING THE OUTPUT ---
* Group 1 = Daily Mail (k03 == 7), Group 2 = Telegraph (k03 == 13)
*
* diff                 — estimated gap in means (Group 1 − Group 2)
* 95% Conf. Interval   — if this excludes 0, reject H0
* Pr(|T| > |t|)        — p-value; reject H0 if p < 0.05

* ======================================================================
* STAGE 2: Survey-design-corrected test
* ======================================================================

* Declare the BES survey design.
svyset [pweight=wt_demog]

* Group-specific weighted means and CIs (descriptive):
svy: mean e01, over(k03)

* Weighted difference and CI (inferential):
svy: regress e01 i.k03

* --- VISUAL HEURISTIC ---
* The plot below shows the weighted point estimate for each group with its 95% CI.
* Rule of thumb: if one group's point estimate lies outside the other group's CI,
* the difference is likely significant. This is approximate — the formal test above
* is the definitive check.
margins k03
marginsplot, ///
    title("Mean Ideology by Newspaper Readership") ///
    subtitle("British Election Study, 2024 — Survey-weighted estimates") ///
    ytitle("Mean left-right self-placement (0=Left, 10=Right)") ///
    xlabel(7 "Daily Mail" 13 "Telegraph")

* --- READING THE OUTPUT ---
* Focus on the svy: regress table.
* Reference group = Daily Mail (k03 = 7); coefficient = Telegraph − Mail mean.
*
* coefficient       — difference in means (Telegraph − Mail)
* 95% Conf. Interval — if this excludes 0, reject H0

* ----------------------------------------------------------------------
* END OF DO-FILE
* ----------------------------------------------------------------------
