clear all

use "C:/.../speech_data.dta", clear

gen log_gdp = ln(GDP_per_capita)

encode framing_final_detailed, gen(framing_num)
encode country_name, gen(country_id)

gen denialist = (framing_final_detailed == "denialist")
gen fatalistic = (framing_final_detailed == "fatalistic")
gen s_o_passive = (framing_final_detailed == "Solution-oriented_passive")
gen s_o_proactive = (framing_final_detailed == "Solution-oriented_proactive")

correlate spectrum_num gal_tan

* MULTINOMIAL REGRESSION

mlogit framing_num gal_tan gender_num newcomer_num Tenure log_gdp v4_d nordic_d pigs_d i.Term, base(5) rrr vce(robust)
margins, dydx(*) predict(outcome(1))
margins, dydx(*) predict(outcome(2))
margins, dydx(*) predict(outcome(3))
margins, dydx(*) predict(outcome(4))
margins, dydx(*) predict(outcome(5))


* LOGISTIC REGRESSION

logistic vote_against newcomer_num Tenure gender_num gal_tan v4_d nordic_d pigs_d log_gdp i.Year, vce(robust)
margins, dydx(*)

logistic vote_against newcomer_num Tenure gender_num gal_tan v4_d nordic_d pigs_d log_gdp i.Year i.country_id, vce(robust)
margins, dydx(*)

logistic vote_against denialist fatalistic s_o_passive s_o_proactive i.Year i.country_id, vce(robust)
margins, dydx(*)

logistic vote_against newcomer_num Tenure gender_num gal_tan v4_d nordic_d pigs_d log_gdp denialist fatalistic s_o_passive s_o_proactive i.Year, vce(robust)
margins, dydx(*)

logistic vote_against newcomer_num Tenure gender_num gal_tan v4_d nordic_d pigs_d log_gdp denialist fatalistic s_o_passive s_o_proactive i.Year i.country_id, vce(robust)
margins, dydx(*)

*********************
*********************
* VOTINGS ONLY
clear all

use "C:/.../vote_data.dta", clear

gen log_gdp = ln(GDP_pc)
encode country_name, gen(country_id)

logistic vote_against gal_tan v4_d nordic_d pigs_d log_gdp newcomer_d gender_num i.Year, vce(robust)
margins, dydx(*)

logistic vote_against gal_tan v4_d nordic_d pigs_d log_gdp newcomer_d gender_num i.Year i.country_id, vce(robust)
margins, dydx(*)
