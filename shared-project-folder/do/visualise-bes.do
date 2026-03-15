* ----------------------------------------------------------------------
* Visualising distributions (British Election Study)
* ----------------------------------------------------------------------

* Set your working directory
* Replace the path below with the folder where you saved the project.
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load the dataset
use "data-raw/British_Election_Study_2024.dta", clear

* ----------------------------------------------------------------------
* PART A. Histograms
* ----------------------------------------------------------------------

* Ratio variable example: Age
* ----------------------------------------------------------------------

* The simplest approach gives us a strange histogram: can people's age be negative?
hist Age

* Many survey datasets use negative values for "Refused / Don't know".
* The condition "if Age >= 0" keeps only valid ages so the mean/SD make sense.
hist Age if Age >= 0 

* We start to move towards a cleaner histogram by setting an appropriate bin width
hist Age if Age >= 0, width(5)

* It's getting better, but we're not quite there. Let's change where the histogram starts
hist Age if Age >= 0, width(5) start(15)

* A little more information on the horizonal axis would be nice
hist Age if Age >= 0, width(5) start(15) xlabel(20(10)100)

* "frequency" changes the vertical axis from proportions to counts
hist Age if Age >= 0, width(5) start(15) xlabel(20(10)100) frequency

* Let's add a title and a subtitle
hist Age if Age >= 0, width(5) start(15) xlabel(20(10)100) frequency title("Distribution of respondents' ages") subtitle("2024 British Election Study")

* "name()" prepares the terrain for saving the histogram as a file in our project folder
hist Age if Age >= 0, width(5) start(15) xlabel(20(10)100) frequency title("Distribution of respondents' ages") subtitle("2024 British Election Study") name(age_hist, replace)

* Save
graph export "output/age_hist.jpg", as(jpg) name(age_hist) quality(100) replace

* ----------------------------------------------------------------------
* PART B. Bar Chart: visualising the vote choice distribution
* ----------------------------------------------------------------------

* Visualizing the frequency table: bar chart of vote choice
* This graph displays counts by category (same information as the table, visually).
graph hbar (count), over(b02) title("2024 General Election Vote") subtitle("British Election Study") name(bes_vote_bar, replace) 

* Save
graph export "output/bes_vote_bar.jpg", as(jpg) name(bes_vote_bar) quality(100) replace

* ----------------------------------------------------------------------
* PART C. Your turn: Find additional variables to visualise
* ----------------------------------------------------------------------

* "hist" gives us histograms.
* "graph hbar (count), over()" gives us frequency bar charts.
* Explore the BES data and codebook to look for additional variables to visualise.