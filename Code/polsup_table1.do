*Estimate results for Table 1 - Demographic characteristics

* Load data
use "$Data/2_All Demog_AlcoholExp_wide.dta", replace

* Survey set the data
svyset [pweight=WEIGHT_norc]

* Transform religion variable (collapsing "Somewhat" and "Very Actively" categories)
recode religpractice (1 = 1 "Not actively") (2 = 2 "Actively") ///
			   (3 = 2 "Actively"), gen(religpractice_model)

* Add labels to "use" and "noticing" vars
label define use_lbl 0 "No" 1 "Yes" 2 "Haven't seen alc"
label values use use_lbl

label define noticing_lbl 0 "No" 1 "Yes" 2 "Not Sure"
label values noticing noticing_lbl

* Create frequency tables for all demographic variables 
foreach var in alcdaysdrankcat alctimesbingecat noticing use religpractice_model agecat gendercat sexualorientcat racecat educcat income4cat  partyidcat REGION4_norc {
    tab `var', missing
}
			   
* Calculate weighted proportions of all demographic variables
foreach var in alcdaysdrankcat alctimesbingecat noticing use religpractice_model agecat gendercat sexualorientcat racecat educcat fplcat  partyidcat REGION4_norc {
    svy: proportion `var'
}
