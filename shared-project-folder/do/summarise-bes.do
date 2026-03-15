* ----------------------------------------------------------------------
* Summarising distributions (British Election Study)
* ----------------------------------------------------------------------

* Set your working directory
* Replace the path below with the folder where you saved the project.
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load the dataset
use "data-raw/British_Election_Study_2024.dta", clear

* ----------------------------------------------------------------------
* PART A. Summary statistics (interval/ratio variables)
* ----------------------------------------------------------------------

* Ratio variable example: Age
* ----------------------------------------------------------------------

* Let's start by doing things the wrong way:
summarize Age

* The minimum value is -2, suggesting that some people answered the survey before being born.
* Many survey datasets use negative values for "Refused / Don't know".
* The condition "if Age >= 0" keeps only valid ages so the mean/SD make sense.
summarize Age if Age >= 0

* Interval variable example: Ideology (e01)
* ----------------------------------------------------------------------
* Same idea: drop non-substantive codes so we summarise real responses.
summarize e01 if e01 >= 0

* ----------------------------------------------------------------------
* PART B. Frequency tables (nominal/ordinal variables)
* ----------------------------------------------------------------------

* Ordinal variable example: Education level (edlevel)
* ----------------------------------------------------------------------
* A frequency table shows how many respondents fall in each category.
* After running this, identify: the most common category (the mode).
tabulate edlevel

* Nominal variable example: 2024 General Election vote (b02)
* ----------------------------------------------------------------------
* Again, find the mode and check whether there are missing / nonresponse categories.
tabulate b02

* ----------------------------------------------------------------------
* PART C. Your turn: Find additional variables to summarise
* ----------------------------------------------------------------------

* "summarize" gives us the mean and standard deviation (summary statistics).
* "tabulate" gives us frequency tables.
* Explore the BES data and codebook to look for additional variables to summarise.