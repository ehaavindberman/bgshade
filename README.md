# bgshade
Stata function to add shading to twoway plots with NBER recessions hard coded.

To download the code, you can run `ssc install bgshade` in your Stata window.

To access the detailed help files you can run `help bgshade` in your Stata window.

For those who don't know, Stata is a statistical programming language used widely by Economists. In Stata there are not options to shade regions of a graph effectively. Bgshade fixes this issue.

On its surface, bgshade is a command that takes a dummy variable in a Stata dataset and adds shading to the areas where that dummy variable = 1. We extended this to include the following features: pre-coded NBER recession shading; horizontal or vertical shaded regions; separate styling for more than one shaded region; and adding shaded regions and their labels to the legend if asked.

An example is included directly below that shows US gross national product between 1967 and 2002 as the blue line. Shaded regions show periods when the US is at war and NBER recessions.
[Stata bgshade regions](http://www.haavindberman.com/Public/bgshade/wars.png)
