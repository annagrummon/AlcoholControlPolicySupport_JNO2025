*Estimate results for Supplemental eTable 2 - Associations between pre-registered demographic and behavioral characteristics and overall support for alcohol control policies

* Load data
use "$Data/2_All Demog_AlcoholExp_wide.dta", clear

* Create variable for overall support, averaging across support for the 8 policies
egen overall_polsup = rowmean(polsup*)

replace overall_polsup = . if missing(polsup_ads, polsup_taxes, polsup_licenses, polsup_night, polsup_bac, polsup_cancer, polsup_standard, polsup_calories)


* Transform the right-hand side variables for analysis as needed (e.g., collapsing variables with small cell sizes)

* Create new age variable (regrouping for more balanced cell sizes)
gen agecat_model = .
replace agecat_model = 1 if age >= 21  & age < 35   
replace agecat_model = 2 if age >= 35 & age < 50   
replace agecat_model = 3 if age >= 50 & age < 65   
replace agecat_model = 4 if age >= 65 

label define agecat_model_lbl 1 "21-34" 2 "35-49" 3 "50-64" 4 "65+"
label values agecat_model agecat_model_lbl

* Create new gender variable (excluding non-binary)
recode gendercat (1 = 1 "Woman") (2 = 2 "Man") (3 = .), gen(gendercat_model)

* Create new race variable (collapsing Am Indian/AK Native, Middle Eastern, Nat. HI/Pac. Islander into Other)
recode racecat (1 = 5 "Other") (2 = 2 "Asian") (3 = 3 "Black") (4 = 4 "Hispanic") ///
			   (5 = 5 "Other") (6 = 5 "Other") (7 = 1 "White") (8 = 5 "Other"), gen(racecat_model)

* Create new education variable (collapsing into 2 categories)
recode educcat (1 = 1 "Some college or less") (2 = 1 "Some college or less") ///
			   (3 = 2 "College grad or Associate's") (4 = 2 "College grad or Associate's"), gen(educcat_model)


* Create new religion variable (collapsing into 2 categories)
recode religpractice (1 = 1 "Not actively") (2 = 2 "Actively") ///
			   (3 = 2 "Actively"), gen(religpractice_model)

* Survey set the data
svyset [pweight=WEIGHT_norc]

* Set the list of predictor variables, including only those we pre-registered 
global sens_correlates  i.alcdaysdrankcat i.religpractice_model i.agecat_model ib2.gendercat_model i.sexualorientcat i.racecat_model i.educcat_model i.fplcat  ib2.partyidcat  i.REGION4_norc 

* Run the model
svy: regress overall_polsup  $sens_correlates



