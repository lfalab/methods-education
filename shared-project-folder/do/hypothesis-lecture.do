* ----------------------------------------------------------------------
* Week 7: Hypothesis Tests — From Description to Inference
* Quality of Government (QoG) Dataset
* ----------------------------------------------------------------------

* Set your working directory
* Replace the path below with the folder where you saved the project.
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* ----------------------------------------------------------------------
* DIFFERENCE IN PROPORTIONS: Example
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
* DIFFERENCE IN PROPORTIONS: Your Turn
* ----------------------------------------------------------------------

* First, let's load the dataset again (otherwise we'll only have British and French former colonies)
use "data-raw/Quality_of_Government_2026.dta", clear

* Research question: Are elections in dictatorships more likely to be followed by riots and protests than elections in democracies?

* YOUR TURN - State the null hypothesis:

* YOUR TURN - State your alternative hypothesis:

* The variable "nelda_rpae" protests and riots after elections is coded 0 if there are no protests and riots after elections, 1 if there are, and 99 if it's unclear. Let's drop the cases where it's unclear whether elections are followed by protests and riots:
drop if nelda_rpae == 99

* Let's look at how many countries have protests and riots after elections:
tab nelda_rpae

* bmr_dem is coded 0 if the country is a dictatorship, one if the country is a democracy. Let's add labels to the variable to make our jobs easier:
label define bmr_dem_lbl 1 "Democracy" 0 "Dictatorship"
label values bmr_dem bmr_dem_lbl

* Descriptive statistics:
tabulate bmr_dem nelda_rpae, row nofreq

* What percentage of dictatorships have protests and riots after elections?
* What percentage of democracies have protests and riots after elections?

* YOUR TURN: Run the difference in proportions test.

* What is the 95% confidence interval around the difference? Does it include zero?
* Do we reject or fail to reject the null hypothesis?

* ----------------------------------------------------------------------
* DIFFERENCE IN MEANS: Example
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
* DIFFERENCE IN MEANS: Your Turn
* ----------------------------------------------------------------------

* Reload the QoG dataset
use "data-raw/Quality_of_Government_2026.dta", clear

* Research question: Is income inequality higher in dictatorships than in democracies?

* YOUR TURN - State the null hypothesis:

* YOUR TURN - State your alternative hypothesis:

* Because we reloaded the dataset, we lost the labels we added earlier to the democracy variable. Adding them again:
label define bmr_dem_lbl 1 "Democracy" 0 "Dictatorship"
label values bmr_dem bmr_dem_lbl

* We'll measure income inequality using the Gini index. A Gini index of 0 represents perfect equality, while an index of 100 implies perfect inequality. Let's look at the mean, median, and standard deviation for the Gini index:
summarize wdi_gini

* Descriptive: this shows us the mean Gini index by regime type:
by bmr_dem, sort: summarize wdi_gini

* What is the mean Gini for dictatorships? And democracies?

* YOUR TURN: Run the difference in means test.

* What is the 95% confidence interval around the difference? Does it include zero?
* Do we reject or fail to reject the null hypothesis?

* ----------------------------------------------------------------------
* END OF DO-FILE
* ----------------------------------------------------------------------
