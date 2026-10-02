clear all

use "speech_data.dta", clear

gen log_gdp = ln(GDP_pc)

encode framing_final_detailed, gen(framing_num)
encode country_name, gen(country_id)
encode epg_name, gen(epg_id)

gen denialist = (framing_final_detailed == "denialist")
gen fatalistic = (framing_final_detailed == "fatalistic")
gen s_o_passive = (framing_final_detailed == "Solution-oriented_passive")
gen s_o_proactive = (framing_final_detailed == "Solution-oriented_proactive")
gen against_only = (vote_outcome == 2)

gen czechia = (country_name == "Czechia")
gen poland = (country_name == "Poland")
gen slovakia = (country_name == "Slovakia")
gen hungary = (country_name == "Hungary")

correlate spectrum_num gal_tan

* MULTINOMIAL REGRESSION

mlogit framing_num gender_num newcomer_num Tenure i.country_id i.Term i.epg_id, base(5) rrr vce(robust)
margins, dydx(*) predict(outcome(1))
margins, dydx(*) predict(outcome(2))
margins, dydx(*) predict(outcome(3))
margins, dydx(*) predict(outcome(4))
margins, dydx(*) predict(outcome(5))

mlogit framing_num gal_tan gender_num newcomer_num Tenure i.Term i.country_id, base(5) rrr vce(robust)
margins, dydx(*) predict(outcome(1))
margins, dydx(*) predict(outcome(2))
margins, dydx(*) predict(outcome(3))
margins, dydx(*) predict(outcome(4))
margins, dydx(*) predict(outcome(5))

regress denialist c.gal_tan##i.Term gender_num newcomer_num Tenure i.country_id, vce(robust)
regress fatalistic c.gal_tan##i.Term gender_num newcomer_num Tenure i.country_id, vce(robust)
regress s_o_passive c.gal_tan##i.Term gender_num newcomer_num Tenure i.country_id, vce(robust)
regress s_o_proactive c.gal_tan##i.Term gender_num newcomer_num Tenure i.country_id, vce(robust)

mlogit framing_num gender_num newcomer_num Tenure log_GDP_pc_std log_emissions_pc_std renewable_share_std eurobar_climate_problem_std v4_d nordic_d pigs_d i.epg_id i.Term, base(5) rrr vce(robust)
margins, dydx(*) predict(outcome(1))
margins, dydx(*) predict(outcome(2))
margins, dydx(*) predict(outcome(3))
margins, dydx(*) predict(outcome(4))
margins, dydx(*) predict(outcome(5))

regress denialist log_GDP_pc_std log_emissions_pc_std renewable_share_std eurobar_climate_problem_std c.gal_tan##v4_d c.gal_tan##nordic_d c.gal_tan##pigs_d gender_num newcomer_num Tenure i.epg_id i.Term, vce(robust)
regress fatalistic log_GDP_pc_std log_emissions_pc_std renewable_share_std eurobar_climate_problem_std c.gal_tan##v4_d c.gal_tan##nordic_d c.gal_tan##pigs_d gender_num newcomer_num Tenure i.epg_id i.Term, vce(robust)
regress s_o_passive log_GDP_pc_std log_emissions_pc_std renewable_share_std eurobar_climate_problem_std c.gal_tan##v4_d c.gal_tan##nordic_d c.gal_tan##pigs_d gender_num newcomer_num Tenure i.epg_id i.Term, vce(robust)
regress s_o_proactive log_GDP_pc_std log_emissions_pc_std renewable_share_std eurobar_climate_problem_std c.gal_tan##v4_d c.gal_tan##nordic_d c.gal_tan##pigs_d gender_num newcomer_num Tenure i.epg_id i.Term, vce(robust)

* COUNTRY DETAILS

mlogit framing_num gender_num newcomer_num Tenure log_GDP_pc_std log_emissions_pc_std renewable_share_std eurobar_climate_problem_std czechia poland slovakia hungary i.epg_id i.Term, base(5) rrr vce(robust)
margins, dydx(*) predict(outcome(1))
margins, dydx(*) predict(outcome(2))
margins, dydx(*) predict(outcome(3))
margins, dydx(*) predict(outcome(4))
margins, dydx(*) predict(outcome(5))

* LOGISTIC REGRESSION

logistic vote_against gender_num newcomer_num Tenure i.Term i.country_id i epg_id, vce(robust)
margins, dydx(*)

**
logistic vote_against gal_tan gender_num newcomer_num Tenure i.Term i.country_id, vce(robust)
margins, dydx(*)

regress vote_against c.gal_tan##i.Term gender_num newcomer_num Tenure i.country_id, vce(robust)

**

logistic vote_against gender_num newcomer_num Tenure eurobar_climate_problem_std log_GDP_pc_std log_emissions_pc_std renewable_share_std v4_d nordic_d pigs_d i.Term i.epg_id, vce(robust)
margins, dydx(*)

logistic vote_against gender_num newcomer_num Tenure denialist fatalistic s_o_passive s_o_proactive i.country_id i.Term i.epg_id, vce(robust)
margins, dydx(*)

logistic vote_against denialist fatalistic s_o_passive s_o_proactive i.country_id i.Term, vce(robust)
margins, dydx(*)

*********************
*********************

* VOTINGS ONLY
clear all

use "vote_data.dta", clear

encode country_name, gen(country_id)
encode epg_name, gen(epg_id)

gen czechia = (country_name == "Czechia")
gen poland = (country_name == "Poland")
gen slovakia = (country_name == "Slovakia")
gen hungary = (country_name == "Hungary")

****

logistic vote_against gender_num i.Year i.country_id i epg_id, vce(robust)
margins, dydx(*)

***

logistic vote_against gal_tan gender_num i.Year i.country_id, vce(robust)
margins, dydx(*)

regress vote_against c.gal_tan##i.Year gender_num i.country_id, vce(robust)
margins Year, dydx(gal_tan)

***

logistic vote_against gender_num log_GDP_pc_std eurobar_climate_problem_std log_emissions_pc_std renewable_share_std v4_d nordic_d pigs_d i.Year i.epg_id, vce(robust)
margins, dydx(*)

logistic vote_against gender_num log_GDP_pc_std eurobar_climate_problem_std log_emissions_pc_std renewable_share_std czechia poland slovakia hungary i.Year i.epg_id, vce(robust)
margins, dydx(*)

regress vote_against log_GDP_pc_std eurobar_climate_problem_std log_emissions_pc_std renewable_share_std c.gal_tan##v4_d c.gal_tan##nordic_d c.gal_tan##pigs_d i.Year##v4_d i.Year##nordic_d i.Year##pigs_d gender_num i.epg_id, vce(robust)

regress vote_against log_GDP_pc_std log_emissions_pc_std renewable_share_std c.gal_tan##v4_d c.gal_tan##nordic_d c.gal_tan##pigs_d i.Year##v4_d i.Year##nordic_d i.Year##pigs_d gender_num i.epg_id, vce(robust)
margins Year, dydx(v4_d)
margins Year, dydx(nordic_d)
margins Year, dydx(pigs_d)


* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
* * * * * * * * * * * * * *  VOTING AGAINST AS DEPENDENT VARIABLE * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 

clear all

use "speech_data.dta", clear

gen log_gdp = ln(GDP_pc)

encode framing_final_detailed, gen(framing_num)
encode country_name, gen(country_id)
encode epg_name, gen(epg_id)

gen denialist = (framing_final_detailed == "denialist")
gen fatalistic = (framing_final_detailed == "fatalistic")
gen s_o_passive = (framing_final_detailed == "Solution-oriented_passive")
gen s_o_proactive = (framing_final_detailed == "Solution-oriented_proactive")
gen against_only = (vote_outcome == 2)

gen czechia = (country_name == "Czechia")
gen poland = (country_name == "Poland")
gen slovakia = (country_name == "Slovakia")
gen hungary = (country_name == "Hungary")

correlate spectrum_num gal_tan

* LOGISTIC REGRESSION

logistic against_only gender_num newcomer_num Tenure i.Term i.country_id i epg_id, vce(robust)
margins, dydx(*)

**
logistic against_only gal_tan gender_num newcomer_num Tenure i.Term i.country_id, vce(robust)
margins, dydx(*)

regress against_only c.gal_tan##i.Term gender_num newcomer_num Tenure i.country_id, vce(robust)

**

logistic against_only gender_num newcomer_num Tenure eurobar_climate_problem_std log_GDP_pc_std log_emissions_pc_std renewable_share_std v4_d nordic_d pigs_d i.Term i.epg_id, vce(robust)
margins, dydx(*)

logistic against_only gender_num newcomer_num Tenure denialist fatalistic s_o_passive s_o_proactive i.country_id i.Term i.epg_id, vce(robust)
margins, dydx(*)

logistic against_only denialist fatalistic s_o_passive s_o_proactive i.country_id i.Term, vce(robust)
margins, dydx(*)

*********************
*********************

* VOTINGS ONLY
clear all

use "vote_data.dta", clear

encode country_name, gen(country_id)
encode epg_name, gen(epg_id)

gen czechia = (country_name == "Czechia")
gen poland = (country_name == "Poland")
gen slovakia = (country_name == "Slovakia")
gen hungary = (country_name == "Hungary")

gen against_only = (vote_outcome == 2)

****

logistic against_only gender_num i.Year i.country_id i epg_id, vce(robust)
margins, dydx(*)

***

logistic against_only gal_tan gender_num i.Year i.country_id, vce(robust)
margins, dydx(*)

regress against_only c.gal_tan##i.Year gender_num i.country_id, vce(robust)
margins Year, dydx(gal_tan)

logistic against_only gender_num log_GDP_pc_std eurobar_climate_problem_std log_emissions_pc_std renewable_share_std czechia poland slovakia hungary i.Year i.epg_id, vce(robust)
margins, dydx(*)

***

logistic against_only gender_num log_GDP_pc_std eurobar_climate_problem_std log_emissions_pc_std renewable_share_std v4_d nordic_d pigs_d i.Year i.epg_id, vce(robust)
margins, dydx(*)

regress against_only log_GDP_pc_std eurobar_climate_problem_std log_emissions_pc_std renewable_share_std c.gal_tan##v4_d c.gal_tan##nordic_d c.gal_tan##pigs_d i.Year##v4_d i.Year##nordic_d i.Year##pigs_d gender_num i.epg_id, vce(robust)

regress against_only log_GDP_pc_std log_emissions_pc_std renewable_share_std c.gal_tan##v4_d c.gal_tan##nordic_d c.gal_tan##pigs_d i.Year##v4_d i.Year##nordic_d i.Year##pigs_d gender_num i.epg_id, vce(robust)
margins Year, dydx(v4_d)
margins Year, dydx(nordic_d)
margins Year, dydx(pigs_d)


* * * * * * * 

















































