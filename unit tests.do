* unit tests:
pause on
preserve
cd "C:\Stata function\working update"
sysuse gnp96, clear
forvalues ii = 1/8 {
   gen res`ii' = _n == `ii'+2
}

// NBER shaders
bgshade date, shaders(quarter) twoway(tsline gnp)
di r(tw_cmd)
pause
bgshade date, shaders(month) twoway(tsline gnp)
di r(tw_cmd)
 pause
bgshade date, shaders(week) twoway(tsline gnp)
di r(tw_cmd)
 pause
bgshade date, shaders(day) twoway(tsline gnp)
di r(tw_cmd)
 pause

// in statements
bgshade date in 1/12, shaders(res5) ///
	twoway(line gnp date)
di r(tw_cmd)
 pause
bgshade date in 1/12, shaders(res5) ///
	twoway(line gnp date in 1/12)
di r(tw_cmd)
 pause

// if statements
bgshade date if _n < 12, shaders(res5) ///
	twoway(line gnp date)
di r(tw_cmd)
 pause
bgshade date if _n < 12, shaders(res5) ///
	twoway(line gnp date if _n < 12)
di r(tw_cmd)
 pause

// multiple shaders
bgshade date in 1/12, shaders(res1 res2 res3 res4) ///
	twoway(line gnp date in 1/12)
di r(tw_cmd)
 pause
bgshade date if _n < 12, shaders(res1 res2 res3 res4) ///
	twoway(line gnp date if _n < 12)
di r(tw_cmd)
 pause

// mixing NBER and custom shaders
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	twoway(line gnp date in 1/50)
di r(tw_cmd) 
pause

// sstyle options:
*style
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	twoway(line gnp date in 1/50) ///
	sstyle(style(unextended extended default unextended))
di r(tw_cmd) 
pause

*lstyle
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	twoway(line gnp date in 1/50) ///
	sstyle(style(unextended) ///
	lstyle(foreground p13box p4other p1))
di r(tw_cmd)
pause

*noextend
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	twoway(line gnp date in 1/50) ///
	sstyle(noextend)
di r(tw_cmd)
pause

*lpattern
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	twoway(line gnp date in 1/50) ///
	sstyle(noextend lpattern(_ l - l))
di r(tw_cmd)
pause

*lwidth
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	twoway(line gnp date in 1/50) ///
	sstyle(noextend lpattern(_ l - l) ///
	lwidth(5))
di r(tw_cmd)
pause
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	twoway(line gnp date in 1/50) ///
	sstyle(noextend lpattern(l l - _) ///
	lwidth(.5 7 3 4))
di r(tw_cmd)
pause

*lcolor
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	twoway(line gnp date in 1/50) ///
	sstyle(noextend lpattern(l l - _) ///
	lwidth(.5 7 3 4) ///
	lcolor(red green blue "0 0 0"))
di r(tw_cmd)
pause

*intensity
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	twoway(line gnp date in 1/50) ///
	sstyle(noextend lpattern(l l - _) ///
	lwidth(.5 7 3 4) ///
	lcolor(red green blue "0 0 0") ///
	intensity(*1))
di r(tw_cmd)
pause

bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	twoway(line gnp date in 1/50) ///
	sstyle(noextend lpattern(l l - _) ///
	lwidth(.5 7 3 4) ///
	lcolor(red green blue "0 0 0") ///
	intensity(%80))
di r(tw_cmd)
pause

// legend
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	twoway(line gnp date in 1/50) ///
	sstyle(noextend lpattern(l l - _) ///
	lwidth(.5 7 3 4) ///
	lcolor(red green blue "0 0 0") ///
	intensity(*1)) ///
	legend
di r(tw_cmd)
pause

// more advanced twoway stuff
*multiple commas
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	sstyle(noextend lpattern(l l - _) ///
	lwidth(.5 7 3 4) ///
	lcolor(red green blue "0 0 0") ///
	intensity(*1)) ///
	legend ///
	twoway((line gnp date in 1/50, lcolor(magenta)), xlab(, angle(45)) title("title")) 
di r(tw_cmd)
pause

*multiple plots
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	sstyle(noextend lpattern(l l - _) ///
	lwidth(.5 7 3 4) ///
	lcolor(red green blue "0 0 0") ///
	intensity(*1)) ///
	legend ///
	twoway((line gnp date, lcolor(magenta)) (area date date) in 1/50, xlab(, angle(45))) 
di r(tw_cmd)
pause

*legend order suboption
bgshade date in 1/50, shaders(quarter res2 res3 res4) ///
	sstyle(noextend lpattern(l l - _) ///
	lwidth(.5 7 3 4) ///
	lcolor(red green blue "0 0 0") ///
	intensity(*1)) ///
	legend ///
	twoway((line gnp date, lcolor(magenta)) (area date date) in 1/50, xlab(, angle(45)) ///
	legend(order(6 "Line 2" 5 "Magenta" 1 "NBER"))) 
di r(tw_cmd)
pause


//nonxextend
bgshade date in 4/6, shaders(quarter res2 res3 res4) ///
	legend ///
	twoway((line gnp date, lcolor(magenta)) (area date date) in 4/6, xlab(, angle(45)) ///
	legend(order(6 "Line 2" 5 "Magenta" 1 "NBER"))) ///
	sstyle(noextend lpattern(l l - _) ///
	lcolor(red green blue "0 0 0") ///
	intensity(*1) ///
	noxextend(on)) old
	
di r(tw_cmd)
pause
bgshade date in 4/6, shaders(quarter res2 res3 res4) ///
	legend ///
	twoway((line gnp date, lcolor(magenta)) (area date date) in 4/6, xlab(, angle(45)) ///
	legend(order(6 "Line 2" 5 "Magenta" 1 "NBER"))) ///
	sstyle(noextend lpattern(l l - _) ///
	lcolor(red green blue "0 0 0") ///
	intensity(*1) ///
	noxextend(100)) old
di r(tw_cmd)
pause

//horizontal
bgshade date, shaders(quarter res2 res3 res4) ///
	legend ///
	twoway(line date gnp, lcolor(magenta) ///
	xtitle("gnp") ytitle("date") title("horizontal option")) ///
	sstyle(lcolor(red green blue "0 10 0") ///
	intensity(%80)) ///
	horizontal
di r(tw_cmd)

restore
