* Estimate results for Supplemental eTable 6: Support for alcohol control policies by gender 

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


* Calculate weighted support for men 

foreach var in `polvars' {
    svy: proportion `var', subpop(if gendercat_model == 2)
}

* Calculate weighted support for women

foreach var in `polvars' {
    svy: proportion `var', subpop(if gendercat_model == 1)  
}

* Note - other gender identities are excluded from analysis due to small cell size
