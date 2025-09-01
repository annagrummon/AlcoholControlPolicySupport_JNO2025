* Estimate results for Supplemental eTable 7: Support for alcohol control policies by race/ethnicity


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


* Create new race variable (collapsing Am Indian/AK Native, Middle Eastern, Nat. HI/Pac. Islander into Other to account for small cell sizes)
recode racecat (1 = 5 "Other") (2 = 2 "Asian") (3 = 3 "Black") (4 = 4 "Hispanic") ///
			   (5 = 5 "Other") (6 = 5 "Other") (7 = 1 "White") (8 = 5 "Other"), gen(racecat_model)
			 

* Calculate weighted support for Asian
foreach var in `polvars' {
    svy: proportion `var', subpop(if racecat_model == 2)
}

* Calculate weighted support for Black 
foreach var in `polvars' {
    svy: proportion `var', subpop(if racecat_model == 3)
}

* Calculate weighted support for Hispanic
foreach var in `polvars' {
    svy: proportion `var', subpop(if racecat_model == 4)
}

* Calculate weighted support for Other
foreach var in `polvars' {
    svy: proportion `var', subpop(if racecat_model == 5)
}

* Calculate weighted support for White 
foreach var in `polvars' {
    svy: proportion `var', subpop(if racecat_model == 1)
}



