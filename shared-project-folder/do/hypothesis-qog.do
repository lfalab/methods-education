* ----------------------------------------------------------------------
* Week 7: Hypothesis Tests — From Description to Inference
* Quality of Government (QoG) Dataset
* ----------------------------------------------------------------------

* Set your working directory
* Replace the path below with the folder where you saved the project.
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* ----------------------------------------------------------------------
* TEST 1: DIFFERENCE IN PROPORTIONS
* ----------------------------------------------------------------------

* Research question: Are countries with a British colonial history more likely to be democracies today than countries with a French colonial history?

* Null Hypothesis (H0): There is no systematic difference between British- and French-colonised countries in their likelihood of being democracies.

* Alternative Hypothesis (H1): Countries with a British colonial history are more likely to be democratic than countries with a French colonial history.

* Load the QoG dataset
use "data-raw/Quality_of_Government_2026.dta", clear

* Restrict to British-colonised (5) and French-colonised (6) countries
keep if ht_colonial == 5 | ht_colonial == 6

* --- STEP 1: Reproduce the descriptive ---
* Row percentages show the share of democracies in each colonial-origin group.
tabulate ht_colonial bmr_dem, row nofreq

* --- STEP 2: Run the test ---
* prtest compares the proportion of a binary variable (bmr_dem) across two groups.
prtest bmr_dem, by(ht_colonial)

* --- READING THE OUTPUT ---
* Group 1 = British-colonised (ht_colonial == 5)
* Group 2 = French-colonised  (ht_colonial == 6)
*
* diff              — estimated gap in proportions (Group 1 − Group 2)
* 95% Conf. Interval — if this excludes 0, reject H0
* Pr(|Z| > |z|)    — p-value; reject H0 if p < 0.05

* ----------------------------------------------------------------------
* TEST 2: DIFFERENCE IN MEANS
* ----------------------------------------------------------------------

* Research question: Is turnout higher in countries with proportional systems than in countries with majoritarian systems?

* Null Hypothesis (H0): Mean voter turnout is the same in majoritarian and proportional electoral systems.

* Alternative Hypothesis (H1): Proportional systems have higher turnout than majoritarian systems.

* Reload the QoG dataset
use "data-raw/Quality_of_Government_2026.dta", clear

* Restrict to majoritarian (1) and proportional (2) systems
* Mixed systems (3) are excluded — we compare the two pure types.
keep if gol_est == 1 | gol_est == 2

* --- STEP 1: Reproduce the descriptive ---
* Group means show average turnout by electoral system type.
by gol_est, sort: summarize ideavt_legvt

* --- STEP 2: Run the test ---
* ttest compares the mean of a continuous variable (ideavt_legvt) across two groups.
ttest ideavt_legvt, by(gol_est)

* --- READING THE OUTPUT ---
* Group 1 = Majoritarian (gol_est == 1)
* Group 2 = Proportional  (gol_est == 2)
*
* diff              — estimated gap in means (Group 1 − Group 2)
* 95% Conf. Interval — if this excludes 0, reject H0
* Pr(|T| > |t|)    — p-value; reject H0 if p < 0.05

* ----------------------------------------------------------------------
* END OF DO-FILE
* ----------------------------------------------------------------------
