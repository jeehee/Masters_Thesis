clear all
cd "D:\Documents\Data and Dofiles"

do "data_tax_cleaning"

clear all
cd "D:\Documents\Data and Dofiles\school_data"
set more off

** remove unecessary rows, columns
** integrate data from districts that merged over time
** rename variable

foreach year in 2005 2006 2007 2008 2009 2010 {
foreach stype in general vocational {

*number of schools
import excel "`year'_`stype'_schools.xlsx", sheet("Sheet0")	//import original file
drop if A  ==  "Total" | A  ==  "Classification"	//drop unnecessary rows
destring C, replace	//destring; and collapse data for districts that later got integrated (thus do not exist anymore)
by A, sort: egen C_c_dup=sum(C) if (strpos(B, "Changwon") > 0 | strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0)
by A, sort: egen C_j_dup=sum(C) if A == "Jeju" & (strpos(B, "Jeju-") > 0 | strpos(B, "Buk") > 0)
by A, sort: egen C_s_dup=sum(C) if A == "Jeju" & (strpos(B, "Seogwip") > 0 | strpos(B, "Nam") > 0)
replace C=C_c_dup if C_c_dup != .
replace C=C_j_dup if C_j_dup != .
replace C=C_s_dup if C_s_dup != .
drop *_dup	//drop districts that do not exist anymore (their data are added to those of existing districts they integrated into)
drop if strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0 | (A == "Jeju" & (strpos(B, "Buk") > 0 | strpos(B, "Nam") > 0))
rename C schools	//rename variables 
keep A B schools	//keep only meaningful variables	
gen year=`year'
save "`year'_`stype'_schools", replace	//save as dta file	
clear

*number of students
import excel "`year'_`stype'_student.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification"
destring E, replace
by A, sort: egen E_c_dup=sum(E) if (strpos(B, "Changwon") > 0 | strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0)
by A, sort: egen E_j_dup=sum(E) if A == "Jeju" & (strpos(B, "Jeju-") > 0 | strpos(B, "Buk") > 0)
by A, sort: egen E_s_dup=sum(E) if A == "Jeju" & (strpos(B, "Seogwip") > 0 | strpos(B, "Nam") > 0)
replace E=E_c_dup if E_c_dup != .
replace E=E_j_dup if E_j_dup != .
replace E=E_s_dup if E_s_dup != .
drop *_dup
drop if strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0 | (A == "Jeju" & (strpos(B, "Buk") > 0 | strpos(B, "Nam") > 0))
rename E student
keep A B student	
gen year=`year'
save "`year'_`stype'_student", replace
clear

*number of entrants
import excel "`year'_`stype'_entrants.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification"
destring E, replace
by A, sort: egen E_c_dup=sum(E) if (strpos(B, "Changwon") > 0 | strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0)
by A, sort: egen E_j_dup=sum(E) if A == "Jeju" & (strpos(B, "Jeju-") > 0 | strpos(B, "Buk") > 0)
by A, sort: egen E_s_dup=sum(E) if A == "Jeju" & (strpos(B, "Seogwip") > 0 | strpos(B, "Nam") > 0)
replace E=E_c_dup if E_c_dup != .
replace E=E_j_dup if E_j_dup != .
replace E=E_s_dup if E_s_dup != .
drop *_dup
drop if strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0 | (A == "Jeju" & (strpos(B, "Buk") > 0 | strpos(B, "Nam") > 0))
rename E entrants
keep A B entrants
gen year=`year'
save "`year'_`stype'_entrants", replace
clear

*number of graudation, higher schooling (rate), employed, unemployed
import excel "`year'_`stype'_graduation.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification" | B == ""
destring C, replace
by A, sort: egen C_c_dup=sum(C) if (strpos(B, "Changwon") > 0 | strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0)
by A, sort: egen C_j_dup=sum(C) if A == "Jeju" & (strpos(B, "Jeju-") > 0 | strpos(B, "Buk") > 0)
by A, sort: egen C_s_dup=sum(C) if A == "Jeju" & (strpos(B, "Seogwip") > 0 | strpos(B, "Nam") > 0)
replace C=C_c_dup if C_c_dup != .
replace C=C_j_dup if C_j_dup != .
replace C=C_s_dup if C_s_dup != .
drop *_dup
drop if strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0 | (A == "Jeju" & (strpos(B, "Buk") > 0 | strpos(B, "Nam") > 0))
rename C graduation
keep A B graduation
gen year=`year'
save "`year'_`stype'_graduation", replace
clear

*number of faculty
import excel "`year'_`stype'_faculty.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification"
destring E, replace
by A, sort: egen E_c_dup=sum(E) if (strpos(B, "Changwon") > 0 | strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0)
by A, sort: egen E_j_dup=sum(E) if A == "Jeju" & (strpos(B, "Jeju-") > 0 | strpos(B, "Buk") > 0)
by A, sort: egen E_s_dup=sum(E) if A == "Jeju" & (strpos(B, "Seogwip") > 0 | strpos(B, "Nam") > 0)
replace E=E_c_dup if E_c_dup != .
replace E=E_j_dup if E_j_dup != .
replace E=E_s_dup if E_s_dup != .
drop *_dup
drop if strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0 | (A == "Jeju" & (strpos(B, "Buk") > 0 | strpos(B, "Nam") > 0))
rename E faculty
keep A B faculty
gen year=`year'
save "`year'_`stype'_faculty", replace
clear

*number of classes
import excel "`year'_`stype'_classes.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification"
destring G, replace
by A, sort: egen G_c_dup=sum(G) if (strpos(B, "Changwon") > 0 | strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0)
by A, sort: egen G_j_dup=sum(G) if A == "Jeju" & (strpos(B, "Jeju-") > 0 | strpos(B, "Buk") > 0)
by A, sort: egen G_s_dup=sum(G) if A == "Jeju" & (strpos(B, "Seogwip") > 0 | strpos(B, "Nam") > 0)
replace G=G_c_dup if G_c_dup != .
replace G=G_j_dup if G_j_dup != .
replace G=G_s_dup if G_s_dup != .
drop *_dup
drop if strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0 | (A == "Jeju" & (strpos(B, "Buk") > 0 | strpos(B, "Nam") > 0))
rename G classes
keep A B classes
gen year=`year'
save "`year'_`stype'_classes", replace
clear

*number of turnover
import excel "`year'_`stype'_changes.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification" | B == ""
foreach data in C D E F G H K {
destring `data', replace
by A, sort: egen `data'_c_dup=sum(`data') if (strpos(B, "Changwon") > 0 | strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0)
by A, sort: egen `data'_j_dup=sum(`data') if A == "Jeju" & (strpos(B, "Jeju-") > 0 | strpos(B, "Buk") > 0)
by A, sort: egen `data'_s_dup=sum(`data') if A == "Jeju" & (strpos(B, "Seogwip") > 0 | strpos(B, "Nam") > 0)
replace `data'=`data'_c_dup if `data'_c_dup != .
replace `data'=`data'_j_dup if `data'_j_dup != .
replace `data'=`data'_s_dup if `data'_s_dup != .
}
drop *_dup
drop if strpos(B, "Masan") > 0 | strpos(B, "Jinhae") > 0 | (A == "Jeju" & (strpos(B, "Buk") > 0 | strpos(B, "Nam") > 0))
rename C turnover_dis	//disease
rename D turnover_fam	//housework or family issue
rename E turnover_cod	//code of conduct
rename F turnover_mal	//maladaptive
rename G turnover_other	//other 
rename H turnover_dead	//death
rename K repeat
keep A B turnover_* repeat
gen year=`year'
save "`year'_`stype'_changes", replace
clear

}
}



foreach year in 2011 2012 2013 2014 {
foreach stype in general specialized spepurp auto {

*number of schools
import excel "`year'_`stype'_schools.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification" | B == ""		
destring F, replace											
rename F schools							
keep A B schools
replace A="Gyeongnam" if A == "`"
gen year=`year'
save "`year'_`stype'_schools", replace						
clear

*number of students
import excel "`year'_`stype'_student.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification" | B == ""
destring I, replace
rename I student
keep A B student
gen year=`year'
save "`year'_`stype'_student", replace
clear

*number of entrants
import excel "`year'_`stype'_entrants.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification" | B == ""
destring I, replace
rename I entrants
keep A B entrants
gen year=`year'
save "`year'_`stype'_entrants", replace
clear

*number of graudation, higher schooling (rate), employed, unemployed
import excel "`year'_`stype'_graduation.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification" | B == ""
destring I, replace
rename I graduation
keep A B graduation
gen year=`year'
save "`year'_`stype'_graduation", replace
clear

*number of faculty
import excel "`year'_`stype'_faculty.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification" | B == ""
destring I, replace
rename I faculty
keep A B faculty	
gen year=`year'
save "`year'_`stype'_faculty", replace
clear

*number of classes
import excel "`year'_`stype'_classes.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification" | B == ""
destring F, replace
rename F classes
keep A B classes	
gen year=`year'
save "`year'_`stype'_classes", replace
clear

*number of turnover
import excel "`year'_`stype'_changes.xlsx", sheet("Sheet0")
drop if A  ==  "Total" | A  ==  "Classification" | B == ""
destring C D E F G H K, replace
rename C turnover_dis	
rename D turnover_fam	
rename E turnover_cod	
rename F turnover_mal
rename G turnover_other
rename H turnover_dead	
rename K repeat
keep A B turnover_* repeat
gen year=`year'
save "`year'_`stype'_changes", replace
clear

}
}



** assign district code + school type

foreach var in schools student entrants graduation faculty classes changes {

foreach year in 2005 2006 2007 2008 2009 2010 {
forval i=1/2 {

local stype: word `i' of general vocational

use "`year'_`stype'_`var'.dta", clear

gen id=. //generate id code and assign as coded below

replace id=11010+`i' if A == "Seoul" & strpos(B, "Jongno") > 0
replace id=11020+`i' if A == "Seoul" & strpos(B, "Jung-") > 0
replace id=11030+`i' if A == "Seoul" & strpos(B, "Yongsan") > 0
replace id=11040+`i' if A == "Seoul" & strpos(B, "Seongdong") > 0
replace id=11050+`i' if A == "Seoul" & strpos(B, "Gwangjin") > 0
replace id=11060+`i' if A == "Seoul" & strpos(B, "Dongdae") > 0
replace id=11070+`i' if A == "Seoul" & strpos(B, "Jungnang") > 0
replace id=11080+`i' if A == "Seoul" & strpos(B, "Seongbuk") > 0
replace id=11090+`i' if A == "Seoul" & strpos(B, "Gangbuk") > 0
replace id=11100+`i' if A == "Seoul" & strpos(B, "Dobong") > 0
replace id=11110+`i' if A == "Seoul" & strpos(B, "Nowon") > 0
replace id=11120+`i' if A == "Seoul" & strpos(B, "Eunpy") > 0
replace id=11130+`i' if A == "Seoul" & strpos(B, "Seodae") > 0
replace id=11140+`i' if A == "Seoul" & strpos(B, "Mapo") > 0
replace id=11150+`i' if A == "Seoul" & strpos(B, "Yangch") > 0
replace id=11160+`i' if A == "Seoul" & strpos(B, "Gangseo") > 0
replace id=11170+`i' if A == "Seoul" & strpos(B, "Guro") > 0
replace id=11180+`i' if A == "Seoul" & strpos(B, "Geumch") > 0
replace id=11190+`i' if A == "Seoul" & strpos(B, "Yeongde") > 0
replace id=11200+`i' if A == "Seoul" & strpos(B, "Dongjak") > 0
replace id=11210+`i' if A == "Seoul" & strpos(B, "Gwana") > 0
replace id=11220+`i' if A == "Seoul" & strpos(B, "Seocho") > 0
replace id=11230+`i' if A == "Seoul" & strpos(B, "Gangnam") > 0
replace id=11240+`i' if A == "Seoul" & strpos(B, "Songpa") > 0
replace id=11250+`i' if A == "Seoul" & strpos(B, "Gangdong") > 0

replace id=21010+`i' if A == "Busan" & strpos(B, "Jung-") > 0
replace id=21020+`i' if A == "Busan" & strpos(B, "Seo-") > 0
replace id=21030+`i' if A == "Busan" & strpos(B, "Dong-") > 0
replace id=21040+`i' if A == "Busan" & strpos(B, "Yeong") > 0
replace id=21050+`i' if A == "Busan" & strpos(B, "Busan") > 0
replace id=21060+`i' if A == "Busan" & strpos(B, "Dongnae") > 0
replace id=21070+`i' if A == "Busan" & strpos(B, "Nam-") > 0
replace id=21080+`i' if A == "Busan" & strpos(B, "Buk-") > 0
replace id=21090+`i' if A == "Busan" & strpos(B, "Haeundae") > 0
replace id=21100+`i' if A == "Busan" & strpos(B, "Saha") > 0
replace id=21110+`i' if A == "Busan" & (strpos(B, "Geumj") > 0 | strpos(B, "Gumj") > 0)	//spelled "Geumjung" or "Gumjung"
replace id=21120+`i' if A == "Busan" & strpos(B, "Gangseo") > 0
replace id=21130+`i' if A == "Busan" & strpos(B, "Yeonje") > 0
replace id=21140+`i' if A == "Busan" & strpos(B, "Suyeong") > 0
replace id=21150+`i' if A == "Busan" & strpos(B, "Sasang") > 0
replace id=21310+`i' if A == "Busan" & strpos(B, "Gijang") > 0

replace id=22010+`i' if A == "Daegu" & strpos(B, "Jung-") > 0
replace id=22020+`i' if A == "Daegu" & strpos(B, "Dong-") > 0
replace id=22030+`i' if A == "Daegu" & strpos(B, "Seo-") > 0
replace id=22040+`i' if A == "Daegu" & strpos(B, "Nam-") > 0
replace id=22050+`i' if A == "Daegu" & strpos(B, "Buk-") > 0
replace id=22060+`i' if A == "Daegu" & strpos(B, "Suseong") > 0
replace id=22070+`i' if A == "Daegu" & strpos(B, "Dalseo-") > 0
replace id=22310+`i' if A == "Daegu" & strpos(B, "Dalseong") > 0

replace id=23010+`i' if A == "Incheon" & strpos(B, "Jung-") > 0
replace id=23020+`i' if A == "Incheon" & strpos(B, "Dong-") > 0
replace id=23030+`i' if A == "Incheon" & strpos(B, "Nam-") > 0
replace id=23040+`i' if A == "Incheon" & strpos(B, "Yeonsu") > 0
replace id=23050+`i' if A == "Incheon" & strpos(B, "Namdong") > 0
replace id=23060+`i' if A == "Incheon" & strpos(B, "Bupy") > 0
replace id=23070+`i' if A == "Incheon" & strpos(B, "Gye") > 0
replace id=23080+`i' if A == "Incheon" & strpos(B, "Seo-") > 0
replace id=23310+`i' if A == "Incheon" & strpos(B, "Gang") > 0
replace id=23320+`i' if A == "Incheon" & strpos(B, "Ongjin") > 0

replace id=24010+`i' if A == "Gwangju" & strpos(B, "Dong-") > 0
replace id=24020+`i' if A == "Gwangju" & strpos(B, "Seo-") > 0
replace id=24030+`i' if A == "Gwangju" & strpos(B, "Nam-") > 0
replace id=24040+`i' if A == "Gwangju" & strpos(B, "Buk-") > 0
replace id=24050+`i' if A == "Gwangju" & strpos(B, "Gwang") > 0

replace id=25010+`i' if A == "Daejeon" & strpos(B, "Dong-") > 0
replace id=25020+`i' if A == "Daejeon" & strpos(B, "Jung-") > 0
replace id=25030+`i' if A == "Daejeon" & strpos(B, "Seo-") > 0
replace id=25040+`i' if A == "Daejeon" & strpos(B, "Yuseong") > 0
replace id=25050+`i' if A == "Daejeon" & strpos(B, "Daed") > 0

replace id=26010+`i' if A == "Ulsan" & strpos(B, "Jung-") > 0
replace id=26020+`i' if A == "Ulsan" & strpos(B, "Nam-") > 0
replace id=26030+`i' if A == "Ulsan" & strpos(B, "Dong-") > 0
replace id=26040+`i' if A == "Ulsan" & strpos(B, "Buk-") > 0
replace id=26310+`i' if A == "Ulsan" & strpos(B, "Ulju") > 0

replace id=31010+`i' if A == "Gyeonggi" & strpos(B, "Suwon") > 0
replace id=31020+`i' if A == "Gyeonggi" & strpos(B, "Seongnam") > 0
replace id=31030+`i' if A == "Gyeonggi" & strpos(B, "Uijeongbu") > 0
replace id=31040+`i' if A == "Gyeonggi" & strpos(B, "Anyang") > 0
replace id=31050+`i' if A == "Gyeonggi" & strpos(B, "Bucheon") > 0
replace id=31060+`i' if A == "Gyeonggi" & strpos(B, "Gwangmy") > 0
replace id=31070+`i' if A == "Gyeonggi" & strpos(B, "Pyeongt") > 0
replace id=31080+`i' if A == "Gyeonggi" & strpos(B, "Dongduc") > 0
replace id=31090+`i' if A == "Gyeonggi" & strpos(B, "Ansan") > 0
replace id=31100+`i' if A == "Gyeonggi" & strpos(B, "Goyang") > 0
replace id=31110+`i' if A == "Gyeonggi" & strpos(B, "Gwach") > 0
replace id=31120+`i' if A == "Gyeonggi" & strpos(B, "Guri") > 0
replace id=31130+`i' if A == "Gyeonggi" & strpos(B, "Namyang") > 0
replace id=31140+`i' if A == "Gyeonggi" & strpos(B, "Osan") > 0
replace id=31150+`i' if A == "Gyeonggi" & strpos(B, "Sih") > 0
replace id=31160+`i' if A == "Gyeonggi" & strpos(B, "Gunpo") > 0
replace id=31170+`i' if A == "Gyeonggi" & strpos(B, "Uiwang") > 0
replace id=31180+`i' if A == "Gyeonggi" & strpos(B, "Hanam") > 0
replace id=31190+`i' if A == "Gyeonggi" & strpos(B, "Yongin") > 0
replace id=31200+`i' if A == "Gyeonggi" & strpos(B, "Paju") > 0
replace id=31210+`i' if A == "Gyeonggi" & strpos(B, "Icheon") > 0
replace id=31220+`i' if A == "Gyeonggi" & strpos(B, "Anseong") > 0
replace id=31230+`i' if A == "Gyeonggi" & strpos(B, "Gimpo") > 0
replace id=31240+`i' if A == "Gyeonggi" & (strpos(B, "Hwas") > 0 | strpos(B, "Whas") > 0)	//spelled "Hwasung" or "Whasung"
replace id=31250+`i' if A == "Gyeonggi" & strpos(B, "Gwangju") > 0
replace id=31260+`i' if A == "Gyeonggi" & strpos(B, "Yangju") > 0
replace id=31270+`i' if A == "Gyeonggi" & strpos(B, "Pocheon") > 0
replace id=31320+`i' if A == "Gyeonggi" & strpos(B, "Yeoju") > 0
replace id=31350+`i' if A == "Gyeonggi" & strpos(B, "Yeoncheon") > 0
replace id=31370+`i' if A == "Gyeonggi" & strpos(B, "Gapy") > 0
replace id=31380+`i' if A == "Gyeonggi" & strpos(B, "Yangpy") > 0

replace id=32010+`i' if A == "Gangwon" & strpos(B, "Chunch") > 0
replace id=32020+`i' if A == "Gangwon" & strpos(B, "Wonju") > 0
replace id=32030+`i' if A == "Gangwon" & strpos(B, "Gangn") > 0
replace id=32040+`i' if A == "Gangwon" & strpos(B, "Donghae") > 0
replace id=32050+`i' if A == "Gangwon" & strpos(B, "Taebaek") > 0
replace id=32060+`i' if A == "Gangwon" & strpos(B, "Sokcho") > 0
replace id=32070+`i' if A == "Gangwon" & strpos(B, "Samch") > 0
replace id=32310+`i' if A == "Gangwon" & strpos(B, "Hongch") > 0
replace id=32320+`i' if A == "Gangwon" & strpos(B, "Hoengseong") > 0
replace id=32330+`i' if A == "Gangwon" & strpos(B, "Yeongwol") > 0
replace id=32340+`i' if A == "Gangwon" & strpos(B, "Pyeongch") > 0
replace id=32350+`i' if A == "Gangwon" & strpos(B, "Jeongs") > 0
replace id=32360+`i' if A == "Gangwon" & strpos(B, "Cheorwon") > 0
replace id=32370+`i' if A == "Gangwon" & strpos(B, "Hwach") > 0
replace id=32380+`i' if A == "Gangwon" & strpos(B, "Yanggu") > 0
replace id=32390+`i' if A == "Gangwon" & strpos(B, "Inje") > 0
replace id=32400+`i' if A == "Gangwon" & strpos(B, "Goseong") > 0
replace id=32410+`i' if A == "Gangwon" & strpos(B, "Yangyang") > 0

replace id=33010+`i' if A == "Chungbuk" & strpos(B, "Cheongju") > 0
replace id=33020+`i' if A == "Chungbuk" & strpos(B, "Chungju") > 0
replace id=33030+`i' if A == "Chungbuk" & strpos(B, "Jecheon") > 0
replace id=33310+`i' if A == "Chungbuk" & strpos(B, "Cheongwon") > 0
replace id=33320+`i' if A == "Chungbuk" & strpos(B, "Boeun") > 0
replace id=33330+`i' if A == "Chungbuk" & strpos(B, "Okch") > 0
replace id=33340+`i' if A == "Chungbuk" & strpos(B, "Yeongdong") > 0
replace id=33390+`i' if A == "Chungbuk" & strpos(B, "Jeungpy") > 0
replace id=33350+`i' if A == "Chungbuk" & strpos(B, "Jinch") > 0
replace id=33360+`i' if A == "Chungbuk" & strpos(B, "Goesan") > 0
replace id=33370+`i' if A == "Chungbuk" & strpos(B, "Eums") > 0
replace id=33380+`i' if A == "Chungbuk" & strpos(B, "Danyang") > 0

replace id=34010+`i' if A == "Chungnam" & strpos(B, "Cheonan") > 0
replace id=34020+`i' if A == "Chungnam" & strpos(B, "Gongju") > 0
replace id=34030+`i' if A == "Chungnam" & strpos(B, "Bory") > 0
replace id=34040+`i' if A == "Chungnam" & strpos(B, "Asan") > 0
replace id=34050+`i' if A == "Chungnam" & strpos(B, "Seosan") > 0
replace id=34060+`i' if A == "Chungnam" & strpos(B, "Nonsan") > 0
replace id=34070+`i' if A == "Chungnam" & strpos(B, "Gye") > 0
replace id=34310+`i' if A == "Chungnam" & strpos(B, "Geumsa") > 0
replace id=34320+`i' if A == "Chungnam" & strpos(B, "Yeongi") > 0	// "Yeongi" later changed to "Sejong" metropolitan city
replace id=34320+`i' if A == "Sejong" & strpos(B, "Sejong") > 0		// "Yeongi" later changed to "Sejong" metropolitan city
replace id=34330+`i' if A == "Chungnam" & strpos(B, "Buyeo") > 0
replace id=34340+`i' if A == "Chungnam" & strpos(B, "Seoch") > 0
replace id=34350+`i' if A == "Chungnam" & strpos(B, "Cheongy") > 0
replace id=34360+`i' if A == "Chungnam" & strpos(B, "Hongseong") > 0
replace id=34370+`i' if A == "Chungnam" & strpos(B, "Yesan") > 0
replace id=34380+`i' if A == "Chungnam" & strpos(B, "Taean") > 0
replace id=34390+`i' if A == "Chungnam" & strpos(B, "Dangjin") > 0

replace id=35010+`i' if A == "Jeonbuk" & strpos(B, "Jeonju") > 0
replace id=35020+`i' if A == "Jeonbuk" & strpos(B, "Gunsan") > 0
replace id=35030+`i' if A == "Jeonbuk" & strpos(B, "Iksan") > 0
replace id=35040+`i' if A == "Jeonbuk" & strpos(B, "Jeongeup") > 0
replace id=35050+`i' if A == "Jeonbuk" & strpos(B, "Namwon") > 0
replace id=35060+`i' if A == "Jeonbuk" & strpos(B, "Gimje") > 0
replace id=35310+`i' if A == "Jeonbuk" & strpos(B, "Wanju") > 0
replace id=35320+`i' if A == "Jeonbuk" & strpos(B, "Jinan") > 0
replace id=35330+`i' if A == "Jeonbuk" & strpos(B, "Muju") > 0
replace id=35340+`i' if A == "Jeonbuk" & strpos(B, "Jangsu") > 0
replace id=35350+`i' if A == "Jeonbuk" & strpos(B, "Imsil") > 0
replace id=35360+`i' if A == "Jeonbuk" & strpos(B, "Sunchang") > 0
replace id=35370+`i' if A == "Jeonbuk" & strpos(B, "Gochang") > 0
replace id=35380+`i' if A == "Jeonbuk" & strpos(B, "Buan") > 0

replace id=36010+`i' if A == "Jeonnam" & strpos(B, "Mokpo") > 0
replace id=36020+`i' if A == "Jeonnam" & strpos(B, "Yeosu") > 0
replace id=36030+`i' if A == "Jeonnam" & strpos(B, "Sunch") > 0
replace id=36040+`i' if A == "Jeonnam" & strpos(B, "Naju") > 0
replace id=36060+`i' if A == "Jeonnam" & strpos(B, "Gwangy") > 0
replace id=36310+`i' if A == "Jeonnam" & strpos(B, "Damy") > 0
replace id=36320+`i' if A == "Jeonnam" & strpos(B, "Goks") > 0
replace id=36330+`i' if A == "Jeonnam" & strpos(B, "Gurye") > 0
replace id=36350+`i' if A == "Jeonnam" & strpos(B, "Gohe") > 0
replace id=36360+`i' if A == "Jeonnam" & strpos(B, "Bose") > 0
replace id=36370+`i' if A == "Jeonnam" & strpos(B, "Hwas") > 0
replace id=36380+`i' if A == "Jeonnam" & strpos(B, "Jangh") > 0
replace id=36390+`i' if A == "Jeonnam" & strpos(B, "Gangjin") > 0
replace id=36400+`i' if A == "Jeonnam" & strpos(B, "Haenam") > 0
replace id=36410+`i' if A == "Jeonnam" & strpos(B, "Yeongam") > 0
replace id=36420+`i' if A == "Jeonnam" & strpos(B, "Muan") > 0
replace id=36430+`i' if A == "Jeonnam" & strpos(B, "Hampy") > 0
replace id=36440+`i' if A == "Jeonnam" & strpos(B, "Yeonggwang") > 0
replace id=36450+`i' if A == "Jeonnam" & strpos(B, "Jangs") > 0
replace id=36460+`i' if A == "Jeonnam" & strpos(B, "Wando") > 0
replace id=36470+`i' if A == "Jeonnam" & strpos(B, "Jindo") > 0
replace id=36480+`i' if A == "Jeonnam" & strpos(B, "Sinan") > 0

replace id=37010+`i' if A == "Gyeongbuk" & strpos(B, "Pohang") > 0
replace id=37020+`i' if A == "Gyeongbuk" & strpos(B, "Gyeongju") > 0
replace id=37030+`i' if A == "Gyeongbuk" & strpos(B, "Gimch") > 0
replace id=37040+`i' if A == "Gyeongbuk" & strpos(B, "Andong") > 0
replace id=37050+`i' if A == "Gyeongbuk" & strpos(B, "Gumi") > 0
replace id=37060+`i' if A == "Gyeongbuk" & strpos(B, "Yeongju") > 0
replace id=37070+`i' if A == "Gyeongbuk" & strpos(B, "Yeongch") > 0
replace id=37080+`i' if A == "Gyeongbuk" & strpos(B, "Sangju") > 0
replace id=37090+`i' if A == "Gyeongbuk" & strpos(B, "Mungy") > 0
replace id=37100+`i' if A == "Gyeongbuk" & strpos(B, "Gyeongsan") > 0
replace id=37310+`i' if A == "Gyeongbuk" & strpos(B, "Gunwi") > 0
replace id=37320+`i' if A == "Gyeongbuk" & strpos(B, "Uiseong") > 0
replace id=37330+`i' if A == "Gyeongbuk" & strpos(B, "Cheongs") > 0
replace id=37340+`i' if A == "Gyeongbuk" & strpos(B, "Yeongy") > 0
replace id=37350+`i' if A == "Gyeongbuk" & strpos(B, "Yeongd") > 0
replace id=37360+`i' if A == "Gyeongbuk" & strpos(B, "Cheongd") > 0
replace id=37370+`i' if A == "Gyeongbuk" & strpos(B, "Gory") > 0
replace id=37380+`i' if A == "Gyeongbuk" & strpos(B, "Seongju") > 0
replace id=37390+`i' if A == "Gyeongbuk" & strpos(B, "Chilgok") > 0
replace id=37400+`i' if A == "Gyeongbuk" & strpos(B, "Yech") > 0
replace id=37410+`i' if A == "Gyeongbuk" & strpos(B, "Bong") > 0
replace id=37420+`i' if A == "Gyeongbuk" & strpos(B, "Uljin") > 0
replace id=37430+`i' if A == "Gyeongbuk" & strpos(B, "Ulleung") > 0

replace id=38110+`i' if A == "Gyeongnam" & strpos(B, "Changwon") > 0	// formerly separated three districts later integrated into one as "Changwon"
replace id=38030+`i' if A == "Gyeongnam" & strpos(B, "Jinju") > 0
replace id=38050+`i' if A == "Gyeongnam" & strpos(B, "Tongy") > 0
replace id=38060+`i' if A == "Gyeongnam" & strpos(B, "Sach") > 0
replace id=38070+`i' if A == "Gyeongnam" & strpos(B, "Gimhae") > 0
replace id=38080+`i' if A == "Gyeongnam" & strpos(B, "Miry") > 0
replace id=38090+`i' if A == "Gyeongnam" & strpos(B, "Geoje") > 0
replace id=38100+`i' if A == "Gyeongnam" & strpos(B, "Yangsan") > 0
replace id=38310+`i' if A == "Gyeongnam" & strpos(B, "Uiry") > 0
replace id=38320+`i' if A == "Gyeongnam" & strpos(B, "Haman") > 0
replace id=38330+`i' if A == "Gyeongnam" & strpos(B, "Changny") > 0
replace id=38340+`i' if A == "Gyeongnam" & strpos(B, "Goseong") > 0
replace id=38350+`i' if A == "Gyeongnam" & strpos(B, "Namhae") > 0
replace id=38360+`i' if A == "Gyeongnam" & strpos(B, "Hadong") > 0
replace id=38370+`i' if A == "Gyeongnam" & strpos(B, "Sanch") > 0
replace id=38380+`i' if A == "Gyeongnam" & strpos(B, "Hamyang") > 0
replace id=38390+`i' if A == "Gyeongnam" & strpos(B, "Geoch") > 0
replace id=38400+`i' if A == "Gyeongnam" & strpos(B, "Hapch") > 0

replace id=39010+`i' if A == "Jeju" & strpos(B, "Jeju") > 0 	// "Buk-Jeju" integrated into "Jeju"
replace id=39020+`i' if A == "Jeju" & strpos(B, "Seogwip") > 0	// "Nam-Jeju" integrated into "Seogwipo"

drop A B

save "`year'_`stype'_`var'", replace
clear

}
}

foreach year in 2011 2012 2013 2014 {
forval i=1/4 {

local stype: word `i' of general specialized spepurp auto

use "`year'_`stype'_`var'.dta", clear

gen id=. //generate id code and assign as coded below

replace id=11010+`i' if A == "Seoul" & strpos(B, "Jongno") > 0
replace id=11020+`i' if A == "Seoul" & strpos(B, "Jung-") > 0
replace id=11030+`i' if A == "Seoul" & strpos(B, "Yongsan") > 0
replace id=11040+`i' if A == "Seoul" & strpos(B, "Seongdong") > 0
replace id=11050+`i' if A == "Seoul" & strpos(B, "Gwangjin") > 0
replace id=11060+`i' if A == "Seoul" & strpos(B, "Dongdae") > 0
replace id=11070+`i' if A == "Seoul" & strpos(B, "Jungnang") > 0
replace id=11080+`i' if A == "Seoul" & strpos(B, "Seongbuk") > 0
replace id=11090+`i' if A == "Seoul" & strpos(B, "Gangbuk") > 0
replace id=11100+`i' if A == "Seoul" & strpos(B, "Dobong") > 0
replace id=11110+`i' if A == "Seoul" & strpos(B, "Nowon") > 0
replace id=11120+`i' if A == "Seoul" & strpos(B, "Eunpy") > 0
replace id=11130+`i' if A == "Seoul" & strpos(B, "Seodae") > 0
replace id=11140+`i' if A == "Seoul" & strpos(B, "Mapo") > 0
replace id=11150+`i' if A == "Seoul" & strpos(B, "Yangch") > 0
replace id=11160+`i' if A == "Seoul" & strpos(B, "Gangseo") > 0
replace id=11170+`i' if A == "Seoul" & strpos(B, "Guro") > 0
replace id=11180+`i' if A == "Seoul" & strpos(B, "Geumch") > 0
replace id=11190+`i' if A == "Seoul" & strpos(B, "Yeongde") > 0
replace id=11200+`i' if A == "Seoul" & strpos(B, "Dongjak") > 0
replace id=11210+`i' if A == "Seoul" & strpos(B, "Gwana") > 0
replace id=11220+`i' if A == "Seoul" & strpos(B, "Seocho") > 0
replace id=11230+`i' if A == "Seoul" & strpos(B, "Gangnam") > 0
replace id=11240+`i' if A == "Seoul" & strpos(B, "Songpa") > 0
replace id=11250+`i' if A == "Seoul" & strpos(B, "Gangdong") > 0

replace id=21010+`i' if A == "Busan" & strpos(B, "Jung-") > 0
replace id=21020+`i' if A == "Busan" & strpos(B, "Seo-") > 0
replace id=21030+`i' if A == "Busan" & strpos(B, "Dong-") > 0
replace id=21040+`i' if A == "Busan" & strpos(B, "Yeong") > 0
replace id=21050+`i' if A == "Busan" & strpos(B, "Busan") > 0
replace id=21060+`i' if A == "Busan" & strpos(B, "Dongnae") > 0
replace id=21070+`i' if A == "Busan" & strpos(B, "Nam-") > 0
replace id=21080+`i' if A == "Busan" & strpos(B, "Buk-") > 0
replace id=21090+`i' if A == "Busan" & strpos(B, "Haeundae") > 0
replace id=21100+`i' if A == "Busan" & strpos(B, "Saha") > 0
replace id=21110+`i' if A == "Busan" & (strpos(B, "Geumj") > 0 | strpos(B, "Gumj") > 0)	//spelled "Geumjung" or "Gumjung"
replace id=21120+`i' if A == "Busan" & strpos(B, "Gangseo") > 0
replace id=21130+`i' if A == "Busan" & strpos(B, "Yeonje") > 0
replace id=21140+`i' if A == "Busan" & strpos(B, "Suyeong") > 0
replace id=21150+`i' if A == "Busan" & strpos(B, "Sasang") > 0
replace id=21310+`i' if A == "Busan" & strpos(B, "Gijang") > 0

replace id=22010+`i' if A == "Daegu" & strpos(B, "Jung-") > 0
replace id=22020+`i' if A == "Daegu" & strpos(B, "Dong-") > 0
replace id=22030+`i' if A == "Daegu" & strpos(B, "Seo-") > 0
replace id=22040+`i' if A == "Daegu" & strpos(B, "Nam-") > 0
replace id=22050+`i' if A == "Daegu" & strpos(B, "Buk-") > 0
replace id=22060+`i' if A == "Daegu" & strpos(B, "Suseong") > 0
replace id=22070+`i' if A == "Daegu" & strpos(B, "Dalseo-") > 0
replace id=22310+`i' if A == "Daegu" & strpos(B, "Dalseong") > 0

replace id=23010+`i' if A == "Incheon" & strpos(B, "Jung-") > 0
replace id=23020+`i' if A == "Incheon" & strpos(B, "Dong-") > 0
replace id=23030+`i' if A == "Incheon" & strpos(B, "Nam-") > 0
replace id=23040+`i' if A == "Incheon" & strpos(B, "Yeonsu") > 0
replace id=23050+`i' if A == "Incheon" & strpos(B, "Namdong") > 0
replace id=23060+`i' if A == "Incheon" & strpos(B, "Bupy") > 0
replace id=23070+`i' if A == "Incheon" & strpos(B, "Gye") > 0
replace id=23080+`i' if A == "Incheon" & strpos(B, "Seo-") > 0
replace id=23310+`i' if A == "Incheon" & strpos(B, "Gang") > 0
replace id=23320+`i' if A == "Incheon" & strpos(B, "Ongjin") > 0

replace id=24010+`i' if A == "Gwangju" & strpos(B, "Dong-") > 0
replace id=24020+`i' if A == "Gwangju" & strpos(B, "Seo-") > 0
replace id=24030+`i' if A == "Gwangju" & strpos(B, "Nam-") > 0
replace id=24040+`i' if A == "Gwangju" & strpos(B, "Buk-") > 0
replace id=24050+`i' if A == "Gwangju" & strpos(B, "Gwang") > 0

replace id=25010+`i' if A == "Daejeon" & strpos(B, "Dong-") > 0
replace id=25020+`i' if A == "Daejeon" & strpos(B, "Jung-") > 0
replace id=25030+`i' if A == "Daejeon" & strpos(B, "Seo-") > 0
replace id=25040+`i' if A == "Daejeon" & strpos(B, "Yuseong") > 0
replace id=25050+`i' if A == "Daejeon" & strpos(B, "Daed") > 0

replace id=26010+`i' if A == "Ulsan" & strpos(B, "Jung-") > 0
replace id=26020+`i' if A == "Ulsan" & strpos(B, "Nam-") > 0
replace id=26030+`i' if A == "Ulsan" & strpos(B, "Dong-") > 0
replace id=26040+`i' if A == "Ulsan" & strpos(B, "Buk-") > 0
replace id=26310+`i' if A == "Ulsan" & strpos(B, "Ulju") > 0

replace id=31010+`i' if A == "Gyeonggi" & strpos(B, "Suwon") > 0
replace id=31020+`i' if A == "Gyeonggi" & strpos(B, "Seongnam") > 0
replace id=31030+`i' if A == "Gyeonggi" & strpos(B, "Uijeongbu") > 0
replace id=31040+`i' if A == "Gyeonggi" & strpos(B, "Anyang") > 0
replace id=31050+`i' if A == "Gyeonggi" & strpos(B, "Bucheon") > 0
replace id=31060+`i' if A == "Gyeonggi" & strpos(B, "Gwangmy") > 0
replace id=31070+`i' if A == "Gyeonggi" & strpos(B, "Pyeongt") > 0
replace id=31080+`i' if A == "Gyeonggi" & strpos(B, "Dongduc") > 0
replace id=31090+`i' if A == "Gyeonggi" & strpos(B, "Ansan") > 0
replace id=31100+`i' if A == "Gyeonggi" & strpos(B, "Goyang") > 0
replace id=31110+`i' if A == "Gyeonggi" & strpos(B, "Gwach") > 0
replace id=31120+`i' if A == "Gyeonggi" & strpos(B, "Guri") > 0
replace id=31130+`i' if A == "Gyeonggi" & strpos(B, "Namyang") > 0
replace id=31140+`i' if A == "Gyeonggi" & strpos(B, "Osan") > 0
replace id=31150+`i' if A == "Gyeonggi" & strpos(B, "Sih") > 0
replace id=31160+`i' if A == "Gyeonggi" & strpos(B, "Gunpo") > 0
replace id=31170+`i' if A == "Gyeonggi" & strpos(B, "Uiwang") > 0
replace id=31180+`i' if A == "Gyeonggi" & strpos(B, "Hanam") > 0
replace id=31190+`i' if A == "Gyeonggi" & strpos(B, "Yongin") > 0
replace id=31200+`i' if A == "Gyeonggi" & strpos(B, "Paju") > 0
replace id=31210+`i' if A == "Gyeonggi" & strpos(B, "Icheon") > 0
replace id=31220+`i' if A == "Gyeonggi" & strpos(B, "Anseong") > 0
replace id=31230+`i' if A == "Gyeonggi" & strpos(B, "Gimpo") > 0
replace id=31240+`i' if A == "Gyeonggi" & (strpos(B, "Hwas") > 0 | strpos(B, "Whas") > 0)	//spelled "Hwasung" or "Whasung"
replace id=31250+`i' if A == "Gyeonggi" & strpos(B, "Gwangju") > 0
replace id=31260+`i' if A == "Gyeonggi" & strpos(B, "Yangju") > 0
replace id=31270+`i' if A == "Gyeonggi" & strpos(B, "Pocheon") > 0
replace id=31320+`i' if A == "Gyeonggi" & strpos(B, "Yeoju") > 0
replace id=31350+`i' if A == "Gyeonggi" & strpos(B, "Yeoncheon") > 0
replace id=31370+`i' if A == "Gyeonggi" & strpos(B, "Gapy") > 0
replace id=31380+`i' if A == "Gyeonggi" & strpos(B, "Yangpy") > 0

replace id=32010+`i' if A == "Gangwon" & strpos(B, "Chunch") > 0
replace id=32020+`i' if A == "Gangwon" & strpos(B, "Wonju") > 0
replace id=32030+`i' if A == "Gangwon" & strpos(B, "Gangn") > 0
replace id=32040+`i' if A == "Gangwon" & strpos(B, "Donghae") > 0
replace id=32050+`i' if A == "Gangwon" & strpos(B, "Taebaek") > 0
replace id=32060+`i' if A == "Gangwon" & strpos(B, "Sokcho") > 0
replace id=32070+`i' if A == "Gangwon" & strpos(B, "Samch") > 0
replace id=32310+`i' if A == "Gangwon" & strpos(B, "Hongch") > 0
replace id=32320+`i' if A == "Gangwon" & strpos(B, "Hoengseong") > 0
replace id=32330+`i' if A == "Gangwon" & strpos(B, "Yeongwol") > 0
replace id=32340+`i' if A == "Gangwon" & strpos(B, "Pyeongch") > 0
replace id=32350+`i' if A == "Gangwon" & strpos(B, "Jeongs") > 0
replace id=32360+`i' if A == "Gangwon" & strpos(B, "Cheorwon") > 0
replace id=32370+`i' if A == "Gangwon" & strpos(B, "Hwach") > 0
replace id=32380+`i' if A == "Gangwon" & strpos(B, "Yanggu") > 0
replace id=32390+`i' if A == "Gangwon" & strpos(B, "Inje") > 0
replace id=32400+`i' if A == "Gangwon" & strpos(B, "Goseong") > 0
replace id=32410+`i' if A == "Gangwon" & strpos(B, "Yangyang") > 0

replace id=33010+`i' if A == "Chungbuk" & strpos(B, "Cheongju") > 0
replace id=33020+`i' if A == "Chungbuk" & strpos(B, "Chungju") > 0
replace id=33030+`i' if A == "Chungbuk" & strpos(B, "Jecheon") > 0
replace id=33310+`i' if A == "Chungbuk" & strpos(B, "Cheongwon") > 0
replace id=33320+`i' if A == "Chungbuk" & strpos(B, "Boeun") > 0
replace id=33330+`i' if A == "Chungbuk" & strpos(B, "Okch") > 0
replace id=33340+`i' if A == "Chungbuk" & strpos(B, "Yeongdong") > 0
replace id=33390+`i' if A == "Chungbuk" & strpos(B, "Jeungpy") > 0
replace id=33350+`i' if A == "Chungbuk" & strpos(B, "Jinch") > 0
replace id=33360+`i' if A == "Chungbuk" & strpos(B, "Goesan") > 0
replace id=33370+`i' if A == "Chungbuk" & strpos(B, "Eums") > 0
replace id=33380+`i' if A == "Chungbuk" & strpos(B, "Danyang") > 0

replace id=34010+`i' if A == "Chungnam" & strpos(B, "Cheonan") > 0
replace id=34020+`i' if A == "Chungnam" & strpos(B, "Gongju") > 0
replace id=34030+`i' if A == "Chungnam" & strpos(B, "Bory") > 0
replace id=34040+`i' if A == "Chungnam" & strpos(B, "Asan") > 0
replace id=34050+`i' if A == "Chungnam" & strpos(B, "Seosan") > 0
replace id=34060+`i' if A == "Chungnam" & strpos(B, "Nonsan") > 0
replace id=34070+`i' if A == "Chungnam" & strpos(B, "Gye") > 0
replace id=34310+`i' if A == "Chungnam" & strpos(B, "Geumsa") > 0
replace id=34320+`i' if A == "Chungnam" & strpos(B, "Yeongi") > 0	// "Yeongi" later changed to "Sejong" metropolitan city
replace id=34320+`i' if A == "Sejong" & strpos(B, "Sejong") > 0		// "Yeongi" later changed to "Sejong" metropolitan city
replace id=34330+`i' if A == "Chungnam" & strpos(B, "Buyeo") > 0
replace id=34340+`i' if A == "Chungnam" & strpos(B, "Seoch") > 0
replace id=34350+`i' if A == "Chungnam" & strpos(B, "Cheongy") > 0
replace id=34360+`i' if A == "Chungnam" & strpos(B, "Hongseong") > 0
replace id=34370+`i' if A == "Chungnam" & strpos(B, "Yesan") > 0
replace id=34380+`i' if A == "Chungnam" & strpos(B, "Taean") > 0
replace id=34390+`i' if A == "Chungnam" & strpos(B, "Dangjin") > 0

replace id=35010+`i' if A == "Jeonbuk" & strpos(B, "Jeonju") > 0
replace id=35020+`i' if A == "Jeonbuk" & strpos(B, "Gunsan") > 0
replace id=35030+`i' if A == "Jeonbuk" & strpos(B, "Iksan") > 0
replace id=35040+`i' if A == "Jeonbuk" & strpos(B, "Jeongeup") > 0
replace id=35050+`i' if A == "Jeonbuk" & strpos(B, "Namwon") > 0
replace id=35060+`i' if A == "Jeonbuk" & strpos(B, "Gimje") > 0
replace id=35310+`i' if A == "Jeonbuk" & strpos(B, "Wanju") > 0
replace id=35320+`i' if A == "Jeonbuk" & strpos(B, "Jinan") > 0
replace id=35330+`i' if A == "Jeonbuk" & strpos(B, "Muju") > 0
replace id=35340+`i' if A == "Jeonbuk" & strpos(B, "Jangsu") > 0
replace id=35350+`i' if A == "Jeonbuk" & strpos(B, "Imsil") > 0
replace id=35360+`i' if A == "Jeonbuk" & strpos(B, "Sunchang") > 0
replace id=35370+`i' if A == "Jeonbuk" & strpos(B, "Gochang") > 0
replace id=35380+`i' if A == "Jeonbuk" & strpos(B, "Buan") > 0

replace id=36010+`i' if A == "Jeonnam" & strpos(B, "Mokpo") > 0
replace id=36020+`i' if A == "Jeonnam" & strpos(B, "Yeosu") > 0
replace id=36030+`i' if A == "Jeonnam" & strpos(B, "Sunch") > 0
replace id=36040+`i' if A == "Jeonnam" & strpos(B, "Naju") > 0
replace id=36060+`i' if A == "Jeonnam" & strpos(B, "Gwangy") > 0
replace id=36310+`i' if A == "Jeonnam" & strpos(B, "Damy") > 0
replace id=36320+`i' if A == "Jeonnam" & strpos(B, "Goks") > 0
replace id=36330+`i' if A == "Jeonnam" & strpos(B, "Gurye") > 0
replace id=36350+`i' if A == "Jeonnam" & strpos(B, "Gohe") > 0
replace id=36360+`i' if A == "Jeonnam" & strpos(B, "Bose") > 0
replace id=36370+`i' if A == "Jeonnam" & strpos(B, "Hwas") > 0
replace id=36380+`i' if A == "Jeonnam" & strpos(B, "Jangh") > 0
replace id=36390+`i' if A == "Jeonnam" & strpos(B, "Gangjin") > 0
replace id=36400+`i' if A == "Jeonnam" & strpos(B, "Haenam") > 0
replace id=36410+`i' if A == "Jeonnam" & strpos(B, "Yeongam") > 0
replace id=36420+`i' if A == "Jeonnam" & strpos(B, "Muan") > 0
replace id=36430+`i' if A == "Jeonnam" & strpos(B, "Hampy") > 0
replace id=36440+`i' if A == "Jeonnam" & strpos(B, "Yeonggwang") > 0
replace id=36450+`i' if A == "Jeonnam" & strpos(B, "Jangs") > 0
replace id=36460+`i' if A == "Jeonnam" & strpos(B, "Wando") > 0
replace id=36470+`i' if A == "Jeonnam" & strpos(B, "Jindo") > 0
replace id=36480+`i' if A == "Jeonnam" & strpos(B, "Sinan") > 0

replace id=37010+`i' if A == "Gyeongbuk" & strpos(B, "Pohang") > 0
replace id=37020+`i' if A == "Gyeongbuk" & strpos(B, "Gyeongju") > 0
replace id=37030+`i' if A == "Gyeongbuk" & strpos(B, "Gimch") > 0
replace id=37040+`i' if A == "Gyeongbuk" & strpos(B, "Andong") > 0
replace id=37050+`i' if A == "Gyeongbuk" & strpos(B, "Gumi") > 0
replace id=37060+`i' if A == "Gyeongbuk" & strpos(B, "Yeongju") > 0
replace id=37070+`i' if A == "Gyeongbuk" & strpos(B, "Yeongch") > 0
replace id=37080+`i' if A == "Gyeongbuk" & strpos(B, "Sangju") > 0
replace id=37090+`i' if A == "Gyeongbuk" & strpos(B, "Mungy") > 0
replace id=37100+`i' if A == "Gyeongbuk" & strpos(B, "Gyeongsan") > 0
replace id=37310+`i' if A == "Gyeongbuk" & strpos(B, "Gunwi") > 0
replace id=37320+`i' if A == "Gyeongbuk" & strpos(B, "Uiseong") > 0
replace id=37330+`i' if A == "Gyeongbuk" & strpos(B, "Cheongs") > 0
replace id=37340+`i' if A == "Gyeongbuk" & strpos(B, "Yeongy") > 0
replace id=37350+`i' if A == "Gyeongbuk" & strpos(B, "Yeongd") > 0
replace id=37360+`i' if A == "Gyeongbuk" & strpos(B, "Cheongd") > 0
replace id=37370+`i' if A == "Gyeongbuk" & strpos(B, "Gory") > 0
replace id=37380+`i' if A == "Gyeongbuk" & strpos(B, "Seongju") > 0
replace id=37390+`i' if A == "Gyeongbuk" & strpos(B, "Chilgok") > 0
replace id=37400+`i' if A == "Gyeongbuk" & strpos(B, "Yech") > 0
replace id=37410+`i' if A == "Gyeongbuk" & strpos(B, "Bong") > 0
replace id=37420+`i' if A == "Gyeongbuk" & strpos(B, "Uljin") > 0
replace id=37430+`i' if A == "Gyeongbuk" & strpos(B, "Ulleung") > 0

replace id=38110+`i' if A == "Gyeongnam" & strpos(B, "Changwon") > 0	// formerly separated three districts later integrated into one as "Changwon"
replace id=38030+`i' if A == "Gyeongnam" & strpos(B, "Jinju") > 0
replace id=38050+`i' if A == "Gyeongnam" & strpos(B, "Tongy") > 0
replace id=38060+`i' if A == "Gyeongnam" & strpos(B, "Sach") > 0
replace id=38070+`i' if A == "Gyeongnam" & strpos(B, "Gimhae") > 0
replace id=38080+`i' if A == "Gyeongnam" & strpos(B, "Miry") > 0
replace id=38090+`i' if A == "Gyeongnam" & strpos(B, "Geoje") > 0
replace id=38100+`i' if A == "Gyeongnam" & strpos(B, "Yangsan") > 0
replace id=38310+`i' if A == "Gyeongnam" & strpos(B, "Uiry") > 0
replace id=38320+`i' if A == "Gyeongnam" & strpos(B, "Haman") > 0
replace id=38330+`i' if A == "Gyeongnam" & strpos(B, "Changny") > 0
replace id=38340+`i' if A == "Gyeongnam" & strpos(B, "Goseong") > 0
replace id=38350+`i' if A == "Gyeongnam" & strpos(B, "Namhae") > 0
replace id=38360+`i' if A == "Gyeongnam" & strpos(B, "Hadong") > 0
replace id=38370+`i' if A == "Gyeongnam" & strpos(B, "Sanch") > 0
replace id=38380+`i' if A == "Gyeongnam" & strpos(B, "Hamyang") > 0
replace id=38390+`i' if A == "Gyeongnam" & strpos(B, "Geoch") > 0
replace id=38400+`i' if A == "Gyeongnam" & strpos(B, "Hapch") > 0

replace id=39010+`i' if A == "Jeju" & strpos(B, "Jeju") > 0		// "Buk-Jeju" integrated into "Jeju"
replace id=39020+`i' if A == "Jeju" & strpos(B, "Seogwip") > 0	// "Nam-Jeju" integrated into "Seogwipo"

drop A B

save "`year'_`stype'_`var'", replace
clear

}
}

}



** merge all files using district code
*1 merge 2005-2010 general and vocational 

foreach stype in general vocational {

foreach var in schools student entrants graduation faculty classes changes {
use "2005_`stype'_`var'.dta", clear

foreach year in 2006 2007 2008 2009 2010 {
append using "`year'_`stype'_`var'"
}

save "2005-2010_`stype'_`var'", replace
}

use "2005-2010_`stype'_schools", clear
foreach var in student entrants graduation faculty classes changes {
merge 1:m id year using "2005-2010_`stype'_`var'"
drop _merge
drop if student == 0 | schools == 0 | missing(schools) | missing(student)
}

save "2005-2010_`stype'", replace 
}


//what to do with missing values in three 2007 graduation?? (general)
//missing values in four 2005 graduation and 37400.2 (vocational)



*2 merge 2005-2010 for general, specialized, special purpose and autonomous

foreach stype in general specialized spepurp auto {

foreach var in schools student entrants graduation faculty classes changes {
use "2011_`stype'_`var'.dta", clear

foreach year in 2012 2013 2014 {
append using "`year'_`stype'_`var'"
}

save "2011-2014_`stype'_`var'", replace
}

use "2011-2014_`stype'_schools", clear
foreach var in student entrants graduation faculty classes changes {
merge 1:m id year using "2011-2014_`stype'_`var'"
drop _merge
drop if student == 0 | schools == 0  | missing(schools) | missing(student)
}

save "2011-2014_`stype'", replace 
}



*3 merge all six files & erase unnecessary data files

use "2005-2010_general", clear
append using "2005-2010_vocational"
append using "2011-2014_general"
append using "2011-2014_specialized"
append using "2011-2014_spepurp"
append using "2011-2014_auto"

foreach var in schools student entrants graduation faculty classes changes {
foreach stype in general vocational {
erase "2005-2010_`stype'_`var'.dta"
forval i=2005/2010 {
erase "`i'_`stype'_`var'.dta"
}
}
foreach stype in general specialized spepurp auto {
erase "2011-2014_`stype'_`var'.dta"
forval i=2011/2014 {
erase "`i'_`stype'_`var'.dta"
}
}
}

**generate new variables useful for analysis

gen district=int(id/10)
gen province=int(id/1000)
gen school_type=id-(district*10)

*1 independent var

gen teach_per_stu=faculty/student
gen stu_per_class=student/classes

*2 dependent var

gen repeat_rate=repeat/student
egen total_turnover=rowtotal(turnover*)
gen dropout_rate=total_turnover/student

sort id year
order id province district school_type year

save "D:\Documents\Data and Dofiles\2005-2014_all_school_types", replace

cd "D:\Documents\Data and Dofiles\"
merge 1:m id province district school_type year using "2005-2014_second_data", gen(_merge2) 

drop if schools == .



** gen new data: spending per pupil, treatment/control groups, year and district dummies

*spending per pupil
gen dum=10000*(year-2000)+district
by dum, sort: egen student_district=sum(student)
drop dum
gen per_pupil=educ_tax/student_district
gen per_capita=gross_tax/pop

*generate treatment districts/school_types

gen treat_1=0 // district implemented policy in 2009 (14)
replace treat_1=1 if district == 3139 ///
| district == 3836 | district == 3835 | district == 3840 | district == 3831 ///
| district == 3537 | district == 3533 | district == 3536 | district == 3531 ///
| district == 3534 | district == 3538 | district == 3532 | district == 3535 ///
| district == 3647

gen treat_2=0 //2011 (7)
replace treat_2=1 if district == 2332 | district == 3235 ///
| district == 3838 | district == 3837 | district == 3832 | district == 3833 | district == 3834 ///

gen treat_3=0 //2012 (18)
replace treat_3=1 if district == 3232 ///
| district == 3811 | district == 3809 | district == 3805 | district == 3810 ///
| district == 3807 | district == 3806 | district == 3803 | district == 3808 ///
| district == 3648 | district == 3644 | district == 3636 | district == 3633 ///
| district == 3642 | district == 3641 | district == 3645 | district == 3601 | district == 3646

gen treat_4=0 //2013 (27)
replace treat_4=1 if district == 3118 ///
| id == 32312 | id == 32012 | id == 32372 | id == 32412 | id == 32362 | id == 32372 ///
| id == 32042 | id == 32032 | id == 32332 | id == 32022 | id == 32052 | district == 3239 ///
| district == 3638 | district == 3637 | district == 3640 | district == 3632 ///
| district == 3631 | district == 3647 | district == 3635 | district == 3643 ///
| district == 3606 | district == 3639 | district == 3603 | district == 3602 | district == 3604 ///
| district == 3731

gen treat_district=0
replace treat_district=1 if treat_1 == 1 | treat_2 == 1 | treat_3 == 1 | treat_4 == 1

*generate control district
gen control_district=0
replace control_district=1 if treat_1 != 1 & treat_2 != 1 & treat_3 != 1 & treat_4 != 1

*generate treated district & treated school type & after policy change

gen treat_dd=0
replace treat_dd=1 if treat_1 == 1 & year >= 2009
replace treat_dd=1 if treat_2 == 1 & year >= 2011
replace treat_dd=1 if treat_3 == 1 & year >= 2012
replace treat_dd=1 if treat_4 == 1 & year >= 2013

*generate year and district dummies

quietly tab year, gen(year_dum)
quietly tab district, gen(dist_dum) 
