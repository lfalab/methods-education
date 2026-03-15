* Set working directory (Replace with the path to folder on your computer)
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"

* Load dataset
use "data-raw/National_Student_Survey_2025.dta", clear

* Histogram of student satisfaction rates
hist Q28, width(5) start(0) xlabel(0(10)100) frequency title("Student Satisfaction Distribution by Course") subtitle("2025 National Student Survey") name(nss_hist, replace) 

* Save
graph export "output/nss_hist.jpg", as(jpg) name(nss_hist) quality(100) replace
