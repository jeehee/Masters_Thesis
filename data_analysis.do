** trend graph

forval i=1/4 {

replace treat_`i'=0 if control_district == 1 
by year, sort: egen group_`i'=mean(dropout_rate) if treat_`i' == 1

}

by year, sort: egen treatment_group=mean(dropout_rate) if treat_district == 1
by year, sort: egen control_group=mean(dropout_rate) if control_district == 1

graph twoway line treatment_group year || line control_group year
graph save graph1

graph twoway line group_1 year || line group_2 year || line group_3 year || line group_4 year || line control_group year
graph save graph2

graph combine graph1.gph graph2.gph, ysize(20) xsize(10) ycommon col(1)
graph save graph1&2

forval i=1/4 {
graph twoway line group_`i' year || line control_group year
graph save graph_g`i', replace 
}


** did estimation (by each group)

bysort treat_1: ttest dropout_rate, by(year_dum5) 
bysort treat_2: ttest dropout_rate, by(year_dum7) 
bysort treat_3: ttest dropout_rate, by(year_dum8) 
bysort treat_4: ttest dropout_rate, by(year_dum9)

xi: reg dropout_rate i.treat_1*i.year_dum5
xi: reg dropout_rate i.treat_2*i.year_dum7
xi: reg dropout_rate i.treat_3*i.year_dum8
xi: reg dropout_rate i.treat_4*i.year_dum9



** did regression (aggregate)

xtset id
xtreg dropout_rate treat_dd 
xtreg dropout_rate treat_dd year_dum* dist_dum* teach_per_stu stu_per_class school_type, vce(cluster district)








/*
**Regressions 

forval i=1/4 {

xi: reg repeat_rate i.treat_district`i'*i.after_policy`i' teach_per_stu stu_per_class school_type year
estimate store repeat_cov_`i'
xi: reg repeat_rate i.treat_district`i'*i.after_policy`i'

xi: reg dropout_rate i.treat_district`i'*i.after_policy`i' teach_per_stu stu_per_class school_type year
estimate store drop_cov_`i'
xi: reg dropout_rate i.treat_district`i'*i.after_policy`i'

}

esttab repeat_cov_1 repeat_cov_2 repeat_cov_3 repeat_cov_4, ///
cells(b(star fmt(3)) se(par fmt(2))) starlevels(+ 0.1 * 0.05 ** 0.01 *** 0.001)

esttab drop_cov_1 drop_cov_2 drop_cov_3 drop_cov_4, ///
cells(b(star fmt(3)) se(par fmt(2))) starlevels(+ 0.1 * 0.05 ** 0.01 *** 0.001)



**time bandwidth adjusted

xi: reg dropout_rate i.treat_district1*i.after_policy1 teach_per_stu stu_per_class school_type year if year <= 2012
estimate store group1_yrs

xi: reg dropout_rate i.treat_district2*i.after_policy2 teach_per_stu stu_per_class school_type year if year >= 2007
estimate store group2_yrs

xi: reg dropout_rate i.treat_district3*i.after_policy3 teach_per_stu stu_per_class school_type year if year >= 2009
estimate store group3_yrs

xi: reg dropout_rate i.treat_district4*i.after_policy4 teach_per_stu stu_per_class school_type year if year >= 2011
estimate store group4_yrs

esttab group1_yrs group2_yrs group3_yrs group4_yrs, ///
cells(b(star fmt(3)) se(par fmt(2))) starlevels(+ 0.1 * 0.05 ** 0.01 *** 0.001)



**region limited

*Gyeongnam (38) and Gyeongbuk (37)

bysort treat_district1: ttest dropout_rate if province == 38, by(after_policy1) 
bysort after_policy1: ttest dropout_rate if province == 38, by(treat_district1)
bysort treat_district2: ttest dropout_rate if province == 38, by(after_policy2)
bysort after_policy2: ttest dropout_rate if province == 38, by(treat_district2)
bysort treat_district3: ttest dropout_rate if province == 38, by(after_policy3)
bysort after_policy3: ttest dropout_rate if province == 38, by(treat_district3) 
bysort treat_district4: ttest dropout_rate if province == 37, by(after_policy4)  
bysort after_policy4: ttest dropout_rate if province == 37, by(treat_district4) 

xi: reg dropout_rate i.treat_district1*i.after_policy1 teach_per_stu stu_per_class school_type year if province == 38
estimate store group1_1

xi: reg dropout_rate i.treat_district2*i.after_policy2 teach_per_stu stu_per_class school_type year if province == 38
estimate store group2_2

xi: reg dropout_rate i.treat_district3*i.after_policy3 teach_per_stu stu_per_class school_type year if province == 38
estimate store group3_2

xi: reg dropout_rate i.treat_district4*i.after_policy4 teach_per_stu stu_per_class school_type year if province == 37
estimate store group4_2

esttab group1_1 group2_2 group3_2 group4_2, ///
cells(b(star fmt(3)) se(par fmt(2))) starlevels(+ 0.1 * 0.05 ** 0.01 *** 0.001)


*Jeonbuk (35) and Jeonnam (36)

bysort treat_district1: ttest dropout_rate if province == 35, by(after_policy1)
bysort after_policy1: ttest dropout_rate if province == 35, by(treat_district1)

xi: reg dropout_rate i.treat_district1*i.after_policy1 teach_per_stu stu_per_class school_type year if province == 35
estimate store group1_2

xi: reg dropout_rate i.treat_district3*i.after_policy3 teach_per_stu stu_per_class school_type year if province == 36
estimate store group3_3

xi: reg dropout_rate i.treat_district1*i.after_policy1 teach_per_stu stu_per_class school_type year if province == 36
estimate store group4_4

esttab group1_2 group3_3 group4_4, ///
cells(b(star fmt(3)) se(par fmt(2))) starlevels(+ 0.1 * 0.05 ** 0.01 *** 0.001)


*Gangwon (32)

bysort treat_district2: ttest dropout_rate if province == 32, by(after_policy2)
bysort after_policy2: ttest dropout_rate if province == 32, by(treat_district2)
bysort treat_district3: ttest dropout_rate if province == 32, by(after_policy3)
bysort after_policy3: ttest dropout_rate if province == 32, by(treat_district3) 
bysort treat_district4: ttest dropout_rate if province == 32, by(after_policy4)  
bysort after_policy4: ttest dropout_rate if province == 32, by(treat_district4) 

xi: reg dropout_rate i.treat_district2*i.after_policy2 teach_per_stu stu_per_class school_type year if province == 32
estimate store group2_1

xi: reg dropout_rate i.treat_district3*i.after_policy3 teach_per_stu stu_per_class school_type year if province == 32
estimate store group3_1

xi: reg dropout_rate i.treat_district4*i.after_policy4 teach_per_stu stu_per_class school_type year if province == 32
estimate store group4_1

esttab group2_1 group3_1 group4_1, ///
cells(b(star fmt(3)) se(par fmt(2))) starlevels(+ 0.1 * 0.05 ** 0.01 *** 0.001)


*Incheon (23)

xi: reg dropout_rate i.treat_district2*i.after_policy2 teach_per_stu stu_per_class school_type year if province == 23
estimate store group2_3

*Gyeonggi (31)

xi: reg dropout_rate i.treat_district4*i.after_policy4 teach_per_stu stu_per_class school_type year if province == 31
estimate store group4_3

esttab group2_3 group4_3, ///
cells(b(star fmt(3)) se(par fmt(2))) starlevels(+ 0.1 * 0.05 ** 0.01 *** 0.001)


