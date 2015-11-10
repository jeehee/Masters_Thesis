clear all
cd "D:\Documents\Data and Dofiles\tax_data"
set more off


** merge data on political affiliation and total population
import excel "D:\Documents\Data and Dofiles\tax_data\political_data\political_data.xlsx", sheet("Sheet1") firstrow
save "political_data", replace 
clear
import excel "D:\Documents\Data and Dofiles\tax_data\population_data\population_data.xlsx", sheet("???") firstrow

drop A
rename B pop2005
rename C pop2006
rename D pop2007
rename E pop2008
rename F pop2009
rename G pop2010
rename H pop2011
rename I pop2012
rename J pop2013
rename K pop2014
replace pop2014="." if pop2014 == "-"
destring pop2014, replace

gen district=.
gen dum=1
gen num=sum(dum)

forval i=1/230 {

local dist: word `i' of 1101 1102 1103 1104 1105 1106 1107 1108 1109 1110 ///
1111 1112 1113 1114 1115 1116 1117 1118 1119 1120 1121 1122 1123 1124 1125 ///
2101 2102 2103 2104 2105 2106 2107 2108 2109 2110 2111 2112 2113 2114 2115 2131 ///
2201 2202 2203 2204 2205 2206 2207 2231 2301 2302 2303 2304 2305 2306 2307 2308 2331 2332 ///
2401 2402 2403 2404 2405 2501 2502 2503 2504 2505 2601 2602 2603 2604 2631 ///
3101 3102 3103 3104 3105 3106 3107 3108 3109 3110 3111 3112 3113 3114 3115 ///
3116 3117 3118 3119 3120 3121 3122 3123 3124 3125 3126 3127 3132 3135 3137 3138 ///
3201 3202 3203 3204 3205 3206 3207 3231 3232 3233 3234 3235 3236 3237 3238 3239 3240 3241 ///
3301 3302 3303 3331 3332 3333 3334 3339 3335 3336 3337 3338 ///
3401 3402 3403 3404 3405 3406 3407 3431 3432 3433 3434 3435 3436 3437 3438 3439 ///
3501 3502 3503 3504 3505 3506 3531 3532 3533 3534 3535 3536 3537 3538 ///
3601 3602 3603 3604 3606 3631 3632 3633 3635 3636 3637 ///
3638 3639 3640 3641 3642 3643 3644 3645 3646 3647 3648 ///
3701 3702 3703 3704 3705 3706 3707 3708 3709 3710 3731 3732 ///
3733 3734 3735 3736 3737 3738 3739 3740 3741 3742 3743 ///
3811 3803 3805 3806 3807 3808 3809 3810 3831 3832 3833 3834 3835 3836 3837 3838 3839 3840 ///
3901 3902

replace district=`dist' if num == `i'

}

drop *um

reshape long pop, i(district) j(year)

gen province=int(district/100)
order province district year

merge m:m province using "political_data"
drop _merge A population 
gen logratio_liberal=log(election_libpct/election_conpct)

save "D:\Documents\Data and Dofiles\pop_pol", replace



* clean tax data for 228 districts out of 230
clear
forval i=1/228 {

local dist: word `i' of ///
1101 1102 1103 1104 1105 1106 1107 1108 1109 1110 1111 1112 1113 1114 1115 1116 1117 1118 1119 1120 1121 1122 1123 1124 1125 ///
2101 2102 2103 2104 2105 2106 2107 2108 2109 2110 2111 2112 2113 2114 2115 2131 ///
2201 2202 2203 2204 2205 2206 2207 2231 2301 ///
2302 2303 2304 2305 2306 2307 2308 2331 2332 ///
2401 2402 2403 2404 2405 ///
2501 2502 2503 2504 2505 ///
2601 2602 2603 2604 2631 ///
3101 3102 3103 3104 3105 3106 3107 3108 3109 3110 3111 3112 3113 3114 3115 3116 3117 3118 3119 3120 3121 3122 3123 3124 3125 3126 3127 3132 3135 3137 3138 ///
3201 3202 3203 3204 3205 3206 3207 3231 3232 3233 3234 3235 3236 3237 3238 3239 3240 3241 ///
3301 3302 3303 3331 3332 3333 3334 3335 3336 3337 3338 3339 ///
3401 3402 3403 3404 3405 3406 3407 3431 3433 3434 3435 3436 3437 3438 3439 ///
3501 3502 3503 3504 3505 3506 3531 3532 3533 3534 3535 3536 3537 3538 ///
3601 3602 3603 3604 3606 3631 3632 3633 3635 3636 3637 3638 3639 3640 3641 3642 3643 3644 3645 3646 3647 3648 ///
3701 3702 3703 3704 3705 3706 3707 3708 3709 3710 3731 3732 3733 3734 3735 3736 3737 3738 3739 3740 3741 3742 3743 ///
3803 3805 3806 3807 3808 3809 3810 3831 3832 3833 3834 3835 3836 3837 3838 3839 3840 ///
3901 3902

import excel "`dist'0.xlsx", sheet("???") firstrow

* rename variables
rename A id
rename B tax2005
rename C tax2006
rename D tax2007
rename E tax2008
rename F tax2009
rename G tax2010
rename H tax2011
rename I tax2012
rename J tax2013

drop if id == "???"
replace id="1" if id == "??"
replace id="2" if id == "?????"
destring id, replace

reshape long tax, i(id) j(year)

* clean variables 
replace tax=subinstr(tax, ",",  "", .)
replace tax=subinstr(tax, " (??)", "", .)
replace tax="." if tax == "-"
destring tax, replace
format tax %10.0f

* reshape to merge-able format
reshape wide tax, i(year) j(id)

rename tax1 gross_tax
rename tax2 educ_tax

* assign district code 
gen district=`dist'

save "tax_`dist'", replace

clear
}



* clean data for the two districts that undergone integration

import excel "34320_1.xlsx", sheet("???") firstrow

rename A id
rename B tax2005
rename C tax2006
rename D tax2007
rename E tax2008
rename F tax2009
rename G tax2010
rename H tax2011
rename I tax2012
reshape long tax, i(id) j(year)
gen type=1

save "tax_yeongi", replace
clear

import excel "34320_2.xlsx", sheet("???") firstrow

rename A id
rename B tax2012
rename C tax2013
reshape long tax, i(id) j(year)
gen type=2

merge 1:m id year type using "tax_yeongi"
drop _merge

drop if id == "???"
replace id="1" if id == "??"
replace id="2" if id == "?????"
replace tax=subinstr(tax, ",",  "", .)
replace tax=subinstr(tax, " (??)", "", .)
destring id tax, replace
format tax %10.0f
sort id year type
by id, sort: replace tax=tax+tax[_n+1] if type != type[_n+1] & year == 2012
drop if type != type[_n-1] & year == 2012
drop type 

reshape wide tax, i(year) j(id)
rename tax1 gross_tax
rename tax2 educ_tax
gen district=3432

save "tax_3432", replace

clear 



forval i=2/3 {

import excel "38110_`i'.xlsx", sheet("???") firstrow

* rename variables
rename A id
rename B tax2005
rename C tax2006
rename D tax2007
rename E tax2008
rename F tax2009
reshape long tax, i(id) j(year)
gen type=`i'

save "tax_38110_`i'", replace
clear
}

import excel "38110_1.xlsx", sheet("???") firstrow

rename A id
rename B tax2005
rename C tax2006
rename D tax2007
rename E tax2008
rename F tax2009
rename G tax2010
rename H tax2011
rename I tax2012
rename J tax2013
reshape long tax, i(id) j(year)
gen type=1

merge 1:m id year type using "tax_38110_2"
drop _merge
merge 1:m id year type using "tax_38110_3"
drop _merge

drop if id == "???"
replace id="1" if id == "??"
replace id="2" if id == "?????"
replace tax=subinstr(tax, ",",  "", .)
replace tax=subinstr(tax, " (??)", "", .)
destring id tax, replace

egen idyear=concat(id year)
sort idyear type
by idyear, sort: egen tax2=sum(tax)
format tax2 %10.0f
drop if type != 1
drop type idyear tax
reshape wide tax2, i(year) j(id)
rename tax21 gross_tax
rename tax22 educ_tax

gen district=3811

save "tax_3811", replace



use "tax_1101", clear

forval i=1/229 {

local dist: word `i' of 1102 1103 1104 1105 1106 1107 1108 1109 1110 ///
1111 1112 1113 1114 1115 1116 1117 1118 1119 1120 1121 1122 1123 1124 1125 ///
2101 2102 2103 2104 2105 2106 2107 2108 2109 2110 2111 2112 2113 2114 2115 2131 ///
2201 2202 2203 2204 2205 2206 2207 2231 2301 2302 2303 2304 2305 2306 2307 2308 2331 2332 ///
2401 2402 2403 2404 2405 2501 2502 2503 2504 2505 2601 2602 2603 2604 2631 ///
3101 3102 3103 3104 3105 3106 3107 3108 3109 3110 3111 3112 3113 3114 3115 ///
3116 3117 3118 3119 3120 3121 3122 3123 3124 3125 3126 3127 3132 3135 3137 3138 ///
3201 3202 3203 3204 3205 3206 3207 3231 3232 3233 3234 3235 3236 3237 3238 3239 3240 3241 ///
3301 3302 3303 3331 3332 3333 3334 3335 3336 3337 3338 3339 ///
3401 3402 3403 3404 3405 3406 3407 3431 3432 3433 3434 3435 3436 3437 3438 3439 ///
3501 3502 3503 3504 3505 3506 3531 3532 3533 3534 3535 3536 3537 3538 ///
3601 3602 3603 3604 3606 3631 3632 3633 3635 3636 3637 ///
3638 3639 3640 3641 3642 3643 3644 3645 3646 3647 3648 ///
3701 3702 3703 3704 3705 3706 3707 3708 3709 3710 3731 3732 ///
3733 3734 3735 3736 3737 3738 3739 3740 3741 3742 3743 ///
3803 3805 3806 3807 3808 3809 3810 3811 3831 3832 3833 3834 3835 3836 3837 3838 3839 3840 ///
3901 3902

append using "tax_`dist'.dta"
erase "tax_`dist'.dta"
}

gen province=int(district/100)
order province district year 

save "2005-2013_all_tax", replace



** merge with two other files on political affiliation and population
cd "D:\Documents\Data and Dofiles\"
merge 1:m province district year using "pop_pol"

save "2005-2014_second_data", replace

* duplicate data for different school types
gen school_type=1
append using "2005-2014_second_data"
replace school_type=2 if school_type== .
append using "2005-2014_second_data"
replace school_type=3 if school_type== .
append using "2005-2014_second_data"
replace school_type=4 if school_type== .

drop if year < 2011 & school_type > 2

gen id=10*district+school_type
order id province district school_type year
sort id province district school_type year

save "2005-2014_second_data", replace


