ity{smcl}
{* 4may2017}{...}
{* version 8}
{viewerjumpto "Legend" "bgshade##legend"}{...}
{viewerjumpto "Legend Example" "bgshade##legend_ex"}{...}
{title:Title}

{p 4 4 2}{hi: bgshade} {hline 2} Add background shading to twoway plots using either
dummy variable(s) denoting shaded areas and/or precoded NBER recessions.


{title:Syntax}
	{p 8 4 2}
    {bf:bgshade} {it:xvar} [{it:{help if}}] [{it:{help in}}] [, {it:options}]{p_end}
	{p 4 4 2}
	where {it:xvar} is the variable on the x axis. {it:if} and {it:in} statements
	apply only to the shaders, not to the plotted variables.

	
    {it:options}{col 40}{...}
description
    {hline}
    {cmd:shaders(}{it:varlist and/or NBER}{cmd:)}{col 40}{...}
variable used for shading or {it:NBER option}
    {cmd:sstyle(}{it:{help added_line_options}}{cmd:)}{col 40}{...}
include added line suboptions for shaders
    {cmd:{ul:leg}end}{col 40}{...}
Include shaded regions in legend
    {cmd:twoway(}{it:{help twoway}}{cmd:)}{col 40}{...}
full twoway command minus shading goes in here

    {it:twoway legend suboptions}{col 40}{...}
description
    {hline}
    legend([{it:order()}][{help legend_options:{it:options}}]){col 40}{...}
{it:order} can include the shaders and labels in the graph legend

    {it:NBER options}{col 40}{...}
description
    {hline}
    {cmd:quarter}{col 40}{...}
quarterly recessions (using end of period aggregation)
    {cmd:month}{col 40}{...}
monthly recessions 
    {cmd:week}{col 40}{...}
weekly recessions (if first week of month is in recession month)
    {cmd:day}{col 40}{...}
daily recessions (mapped to full month)
    {hline}


{title:Description}

{p 4 4 2}
{cmd:bgshade} plots {it:varlist} as a {help twoway} plot which includes 
either NBER recession shading whose dates come from 
{browse "https://fred.stlouisfed.org/series/USREC"} and/or the dummy variable(s)
specified in {cmd:shaders()} as added lines. Returns the full twoway command, 
the list of xlines by shader, and the lwidth for the added lines.


{title:Options}

{p 4 8 2}
{cmd:shaders(}{it:namelist}{cmd:)} sets the shaded regions. NBER recessions are hard
coded and can be called with any of the {it:NBER options}. If you want to plot
your own shaded regions, simply have a dummy variable that = 1 if that observation
should be shaded and = 0 otherwise. It is also possible to leave this option blank, 
in which case no shaded areas are plotted.

{p 4 8 2}
{cmd:sstyle(}{it:{help added_line_options}}{cmd:)} sets any line style options for
the shaded regions. Only some options will have any effect though, these include
style, lstyle, noextend, lpattern, lwidth, and lcolor. 

{pmore}
These options do exactly what they say they do in {it:{help added_line_options}}, with the
difference that you specify however many options as you have shaders. If I have two
shaders (var1 and var2) and I want var1 to be green and var2 to be red then I would specify
{cmd:sstyle(lcolor(}green red{cmd:))}. The lwidth option can also be specified only
once and will, in that case apply to all shaders.

{pmore}
{it:Advanced options:} 

{pmore}
{it:noxextend()} takes a number input or "on" for default
settings. {it:noxextend(on)} tells {cmd:bgshade} that the shaded regions
extend off the edge of the plot area to the right or left. {cmd:bgshade} will then 
figure out which side is the issue (or both) and take off 25% of the left- or 
right-most added line. Setting a number tells {cmd:bgshade} to take off that % of 
the added line that is going off the chart.
It is possible to specify any number, but > 100 has the same
functionality as 100 and negative numbers extend, rather than retract the shading.
See the example below and play around with it yourself if you're curious.

{pmore}
{it:intensity()} takes a number input that adjusts the intensity of a color. The default is 
.4. To shut off intensity shifting, use intensity(1). For further elaboration,
see the Adjusting intensity section in {it:{help colorstyle}}.

{p 4 8 2}
{cmd:legend} tells {cmd:bgshade} to include the shaded regions in the legend.
{cmd:bgshade} adds the shaders to the legend first. This is separate from the
notes on the legend suboption of twoway included in {cmd:bgshade}

{p 4 8 2}
{cmd:twoway(}{it:string}{cmd:)} sets literally any twoway graph you want.
Literally. Does it run as a twoway plot? It will run here. The one exception is 
that the {it:{help bgshade##legend:legend}} suboption does have some 
extra frills explained below.



{title:Twoway legend suboption}

{marker legend}{...}
{p 4 8 2}
{it:{help legend_options}} are all included, but we have added
functionality to include shaded regions in the legend by adding to the {cmd:order()}
subsuboption {help bgshade##legend_ex:Example} included below.

{pmore}
If you would rather a wordy explanation: the shaders are added to the legend 
automatically and appear first, so if you have 2 shaders and 2 y-variables, your
legend order will be shader1 shader2 yvar1 yvar2 and if you wanted to put your
y-variables first in the legend and not include the shaders,for example, you could specify
order(3 "yvar1" 4 "yvar2").



{title:NBER Options}

{p 4 8 2}
{bf: day}, {bf:week}, {bf:month}, 
and {bf:quarter} set the period for recession shading to be daily, 
weekly, monthly, or quarterly respectively. This only affects the placement of 
the shading, not the data you are using. When using {bf:quarter}, the end of period 
aggregation is used, so recession shading may be somewhat left-biased. When using 
{bf:week} or {bf:day} the first of each month is used, so recession shading may
not extend to the end of the month.


{title:Examples}

{col 5}{txt}*basic use
	{com}sysuse gnp96
	{com}format date %tq
	{com}bgshade date if date >= yq(1970,1), legend shaders(quarter) ///
	{com}   twoway(line gnp96 date if date >= yq(1970,1), title("GNP") lcolor(navy))
	{com}
{col 5}{txt}*full time series of nber recessions available:
	{com}drop _all
	{com}set obs 2000
	{com}gen date = _n-1280
	{com}format date %tm
	{com}gen series = sqrt(_n)+runiform()
	{com}gen series2 = series*runiform()/2
	{com}bgshade date, shaders(month) ///
	{com}   twoway(line series date, title("All Monthly Recessions"))
	{com}
{col 5}{txt}*all default shading options
	{com}drop _all
	{com}set obs 12
	{com}gen date = _n-1
	{com}gen res1 = inlist(date,4,5,6,7,8,9)
	{com}gen res2 = inlist(date,2,3,4,5)
	{com}gen res3 = inlist(date,4,9,10,11,12)
	{com}gen res4 = inlist(date,5,6,10,11)
	{com}gen line1 = sqrt(_n)
	{com}gen line2 = _n*_n/20
	{com}
	{com}bgshade date, shaders(res1 res2 res3 res4) ///
	{com}   twoway(line line1 date || sc line2 date, xlab(-2(2)14) ///
	{com}   title("All default shading colors and patterns"))       

{col 5}{txt}*using extra options in twoway
	{com}bgshade date, shaders(res1 res2 res3 res4) ///
	{com}   twoway(line line1 date, lcolor(magenta) || (sc line2 date, msize(huge)), xlab(-2(2)14) ///
	{com}   title("Using extra options in twoway")) 
	{com}
{col 5}{txt}*using custom and NBER shaders
	{com}bgshade date, shaders(quarter res2 res3 res4) ///
	{com}   twoway(line line1 date || sc line2 date, xlab(-2(2)14) ///
	{com}   title("Using custom and NBER shaders") ///
	{com}   subtitle("We recommend putting nber shaders first because it looks best"))
	{com}
{col 5}{txt}*sstyle options
	{com}bgshade date, shaders(res2 res3 res4) ///
	{com}   sstyle(noextend lcolor("255 0 0" green blue) lpattern(_ - -_)) ///
	{com}   twoway(line line1 date || sc line2 date, xlab(-2(2)14) ///
	{com}   title("Using some sstyle options"))
	{com}
{col 5}{txt}*using lstyle and style suboptions
	{com}bgshade date, shaders(res2 res3 res4) ///
	{com}   sstyle(lstyle(foreground p2 refline) style(default unextended extended)) ///
	{com}   twoway(line line1 date || sc line2 date, xlab(-2(2)14) ///
	{com}   title("Using lstyle and style suboptions"))
	{com}
{col 5}{txt}*legend options
	{com}lab var res1 "Shader 1"
	{com}lab var res2 "Shader 2"
	{com}bgshade date, shaders(res1 res2 res3 res4) legend ///
	{com}   twoway(line line1 date || sc line2 date, xlab(-2(2)14) ///
	{com}   title("Add shaders to the legend")) 
   
{col 5}{txt}*mix it up with the legend
	{com}bgshade date, shaders(res1 res2 res3 res4) legend ///
	{com}   twoway(line line1 date || sc line2 date, xlab(-2(2)14) ///
	{com}   title("Using order legend suboption") ///    
	{com}   legend(order(5 "Square Root of N" 6 "N Squared over 20" 2 "Res2" 4 "Res4") cols(2)))    

{col 5}{txt}*more than 4 shaders example
	{com}drop res*
	{com}forvalues ii = 1/8 {
	{com}   gen res`ii' = _n == `ii'+2
	{com}}
	{com}
	{com}bgshade date, shaders(res1 res2 res3 res4 res5 res6 res7 res8) ///
	{com}   sstyle(lpattern( l _ l _ l _ l _) lcolor(green blue red magenta orange navy "255 0 0" eltgreen)) ///
	{com}   twoway(line line1 date || sc line2 date, xlab(0(1)12) ///
	{com}   title("More than 4 shaders"))

{col 5}{txt}*playing with the shader width since it's not perfect above
	{com}bgshade date, shaders(res1 res2 res3 res4 res5 res6 res7 res8) ///
	{com}   sstyle(lwidth(*30) ///
	{com}   lpattern( l _ l _ l _ l _) lcolor(green blue red magenta orange navy "255 0 0" eltgreen)) ///
	{com}   twoway(line line1 date || sc line2 date, xlab(0(1)12) ///
	{com}   title("Changing all widths"))
	{com}   
{col 5}{txt}*alternative setting each individual shader's width
	{com}bgshade date, shaders(res1 res2 res3 res4 res5 res6 res7 res8) ///
	{com}   sstyle(lwidth(*30 *40 *10 *50 *10 *30 *40 *70) ///
	{com}   lpattern( l _ l _ l _ l _) lcolor(green blue red magenta orange navy "255 0 0" eltgreen)) ///
	{com}   twoway(line line1 date || sc line2 date, xlab(0(1)12) ///
	{com}   title("Changing individual widths"))
	{com}
{col 5}{txt}*noxextend example
	{com}gen res = _n < 3 | _n > 10
	{com}
	{com}bgshade date, shaders(res) sstyle(noxextend(100)) ///
	{com}	twoway(line line1 date, title("Too hot"))
	{com}bgshade date, shaders(res) sstyle(noxextend(-100)) ///
	{com}	twoway(line line1 date, title("Too cold"))
	{com}bgshade date, shaders(res) sstyle(noxextend(60)) ///
	{com}	twoway(line line1 date, title("Just right"))	
	
	
{title:Future plans}
{txt}
	Adding functionality for more customizable color intensity and noxextend options.
	Let us know what you need and please let us know if you find any bugs!
		
{title:Authors}

	Eric Haavind-Berman, University of Wisconsin - Madison, ehaavindberman@gmail.com
	Aaron Markiewitz, University of Michigan
	
	Many thanks to the wonderful Research Assistants at the Boston Fed for helpful
	feedback and comments.
	
{title:Also see}

{p 4 8 2}
Kit Baum has a great program {cmd:nbercycles} available from SSC which 
tackles the same problem as here, but by adding area graphs to your line plot
rather than adding lines and resizing them.
				
				

				
				
