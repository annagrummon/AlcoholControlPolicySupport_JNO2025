* Estimate results for Supplemental eTable 4: Support for alcohol control policies by binge drinking during the past 4 weeks

* Load data
use "$Data/2_All Demog_AlcoholExp_wide.dta", replace

* Survey set the data
svyset [pweight=WEIGHT_norc]

*  Recode policy support variable to use 3 categories instead of 5 (oppose, neutral, support)
foreach var of varlist polsup* {
	recode `var' (1=1 "Oppose") (2=1 "Oppose") (3=2 "Neutral") (4=3 "Support") (5=3 "Support"), gen(`var'_3)
}

* Define list of policy support variables
local polvars polsup_calories_3 polsup_ads_3 polsup_standard_3 polsup_cancer_3 ///
             polsup_bac_3 polsup_night_3 polsup_taxes_3 polsup_licenses_3


* Calculate weighted support for light drinkers 
local row_no_binge = 1

foreach var in `polvars' {
    svy: proportion `var',  subpop(if alctimesbingecat == 0)
}

* Calculate weighted support for heavy drinkers 

foreach var in `polvars' {
    svy: proportion `var' , subpop(if alctimesbingecat == 1)
}
