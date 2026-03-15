* Set working directory (Replace with the path to folder on your computer)
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load dataset
use "data-raw/Quality_of_Government_2026.dta", clear

* Summarise GDP per capita
summarize mad_gdppc

* More detail on the GDP per capita distribution
summarize mad_gdppc, detail

* Histogram of GDP per capita
hist mad_gdppc, width(10000) start(0) xlabel(0(20000)150000) ylabel(0(5)70) frequency title("Real GDP Per Capita by Country") subtitle("In 2011 U.S. Dollars") name(gdp_hist, replace)

* Save
graph export "output/gdp_hist.jpg", as(jpg) name(gdp_hist) quality(100) replace