* Set working directory (Replace with the path to folder on your computer)
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load dataset
use "data-raw/British_Election_Study_2024.dta", clear

* Summarise age
summarize Age if Age >= 0

* Summarise ideology
summarize e01 if e01 >= 0

* Frequency table for education level
table edlevel

* Frequency table for General Election vote
table b02

* Frequency bar chart for General Election vote
graph hbar (count), over(b02) title("2024 General Election Vote") subtitle("British Election Study") name(bes_vote_bar, replace) 

* Save
graph export "output/bes_vote_bar.jpg", as(jpg) name(bes_vote_bar) quality(100) replace
