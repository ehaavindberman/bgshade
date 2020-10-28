# bgshade
Stata function to add shading to twoway plots with NBER recessions hard coded.

To download the code, you can run `ssc install bgshade` in your Stata window.

To access the detailed help files you can run `help bgshade` in your Stata window.

For those who don't know, Stata is a statistical programming language used widely by Economists. In Stata there are not options to shade regions of a graph effectively. Bgshade fixes this issue.

On its surface, bgshade is a command that takes a dummy variable in a Stata dataset and adds shading to the areas where that dummy variable = 1. We extended this to include the following features: pre-coded NBER recession shading; horizontal or vertical shaded regions; separate styling for more than one shaded region; and adding shaded regions and their labels to the legend if asked.

An example is included directly below that shows US gross national product between 1967 and 2002 as the blue line. Shaded regions show periods when the US is at war and NBER recessions.

<img src = "http://www.haavindberman.com/Public/bgshade/wars.png" width=400 >

```Stata
sysuse gnp96, clear

gen wars = 0
replace wars = 1 if date <= yq(1978,4) // Korean war
replace wars = 1 if date >= yq(1990,1) & date <= yq(1991,4) // Gulf war
replace wars = 1 if date >= yq(2001,1) // Afghanistan
lab var wars "US War Periods"

bgshade date if date < yq(2002,4), shaders(wars quarter) legend ///
  twoway(line gnp date if date < yq(2002,4), title("US GNP (1967-2002)") lcolor(navy) ///
    legend(cols(1) order(3 1 2 "NBER US Recessions")))
```
Source: http://www.haavindberman.com/bgshade.html
