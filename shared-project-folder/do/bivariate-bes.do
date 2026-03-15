* ----------------------------------------------------------------------
* Describing correlations (bivariate description) - BES 2024
* ----------------------------------------------------------------------

* Set your working directory
* Replace the path below with the folder where you saved the project.
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load the dataset
use "Data-raw/British_Election_Study_2024.dta", clear

* ----------------------------------------------------------------------
* Let's start by describing distributions (univariate description)
* ----------------------------------------------------------------------

* Vote choice distribution
* ----------------------------------------------------------------------

* vote choice - keep valid responses only
replace b02 = . if b02 < 0

* vote choice - table
tabulate b02

* vote choice - bar chart (raw)
graph hbar (count), over(b02)

* vote choice - bar chart (add title, subtitle)
graph hbar (count), over(b02) title("2024 General Election Vote") subtitle("British Election Study") name(bes_vote_bar, replace)
* save
graph export "output/bes_vote_bar.jpg", as(jpg) name(bes_vote_bar) quality(100) replace

* Gender distribution
* ----------------------------------------------------------------------

* gender - table
tabulate y09

* gender - bar chart
graph hbar (count), over(y09) title("Gender Distribution") subtitle("British Election Study, 2024") name(bes_gender_bar, replace)
* save
graph export "output/bes_gender_bar.jpg", as(jpg) name(bes_gender_bar) quality(100) replace

* Ideology (left-right self-placement) distribution
* ----------------------------------------------------------------------

* ideology - keep valid responses only
replace e01 = . if e01 < 0

* ideology - histogram (raw)
hist e01

* ideology - histogram (adjust bin width, position, and axis marks)
hist e01, width(1) start(-0.5) xlabel(0(1)10)

* ideology - summary table (simple)
summarize e01

* ideology - summary table (detail)
* (you don't need to know all these concepts)
summarize e01, detail

* ideology - histogram (add title and subtitle, change axis title)
hist e01, width(1) start(-0.5) xlabel(0(1)10) frequency title("Distribution of Self-placed Ideology") subtitle("British Election Study, 2024") xtitle("Left-right self-placement (0 = Left; 10 = Right)") name(bes_ideol_hist, replace)
* save
graph export "output/bes_ideol_hist.jpg", as(jpg) name(bes_ideol_hist) quality(100) replace

* Favourite newspaper distribution
* ----------------------------------------------------------------------

* favourite newspaper - keep valid responses only
replace k03 = . if k03 < 0

* favourite newspaper - table
tabulate k03

* favourite newspaper - bar chart (raw)
graph hbar (count), over(k03)

* favourite newspaper - add title, subtitle
graph hbar (count), over(k03) title("Distribution of Newspaper Readership") subtitle("British Election Study, 2024") name(bes_news_bar, replace)
* save
graph export "output/bes_news_bar.jpg", as(jpg) name(bes_news_bar) quality(100) replace

* ----------------------------------------------------------------------
* Now let's look at correlations (bivariate description)
* ----------------------------------------------------------------------

* Correlations between nominal variables: gender and vote choice
* ----------------------------------------------------------------------

* gender and vote choice - table
tabulate b02 y09, column

* gender and vote choice - table (percentage only)
tabulate b02 y09, column nofreq

* Note: the video uses catplot for this chart. We use graph hbar here
* because catplot has changed since the video was recorded. The output
* is equivalent.

* gender and vote choice - bivariate frequency chart (raw)
graph hbar (count), over(y09) over(b02) asyvars

* gender and vote choice - bivariate frequency chart (polished)
graph hbar (count), over(y09) over(b02) asyvars title("Gender and Vote Choice") subtitle("British Election Study, 2024") name(bes_gender_vote, replace)
* save
graph export "output/bes_gender_vote.jpg", as(jpg) name(bes_gender_vote) quality(100) replace

* Comparing means (one nominal, one numeric): newspaper and ideology
* ----------------------------------------------------------------------

* mean ideology by newspaper
sort k03
by k03: summarize e01

* newspaper and ideology - bar chart with means (raw)
graph hbar e01, over(k03)

* newspaper and ideology - bar chart with means (polished)
graph hbar e01, over(k03) title("Favourite Newspaper and Ideology") subtitle("British Election Study, 2024") ytitle("Mean self-placed ideology (0 = Left; 10 = Right)") name(bes_news_ideol, replace)
* save
graph export "output/bes_news_ideol.jpg", as(jpg) name(bes_news_ideol) quality(100) replace