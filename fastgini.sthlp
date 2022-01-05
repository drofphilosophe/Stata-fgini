{smcl}
{* *! version 1.2.1  07mar2013}{...}
{findalias asfradohelp}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help help"}{...}
{viewerjumpto "Syntax" "examplehelpfile##syntax"}{...}
{viewerjumpto "Description" "examplehelpfile##description"}{...}
{viewerjumpto "Options" "examplehelpfile##options"}{...}
{viewerjumpto "Remarks" "examplehelpfile##remarks"}{...}
{viewerjumpto "Examples" "examplehelpfile##examples"}{...}
{title:Title}

{phang}
{bf:fastgini} {hline 2} Quickly compute Gini coefficients


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:fastgini}
{it:varname}
[{it:weight}]
{ifin}
{cmd:,} [{it:options}]


{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:{opt discrete}}Treat {it:varname} as discrete. This will speed calculation if there are many repeated values of {it:varname}

{synoptline}
{p2colreset}{...}
{p 4 6 2}
{it:varname} is a numeric variable.{p_end}

{marker description}{...}
{title:Description}


{pstd}
{cmd:fastgini} computes the Gini coefficient of {it:varname}. While the Gini is defined
as a function of all pariwise combinations of values in {it:varname}, the algorithim used
in {cmd:fastgini} scales in complexity approximately linearly with the number of observations. 


{marker remarks}{...}
{title:Remarks}

{pstd}
The algorithim used in {cmd:fastgini} was adapted from {browse "http://freerangestats.info/blog/2017/08/05/weighted-gini":freerangestats.info/blog/2017/08/05/weighted-gini}, which appears to follow {it:Working Paper No 17–02 by Vic Duoba and Nairn MacGibbon} at {browse "https://www.stats.govt.nz/methods/research-papers/working-papers-original/calc-gini-index-17-02.aspx":www.stats.govt.nz/methods/research-papers/working-papers-original/calc-gini-index-17-02.aspx}, which as of January 2022 is a dead link. 

{pstd}
Obtain the latest version using

{bf:net install fastgini, from("https://github.com/drofphilosophe/Stata-fastgini/raw/main") replace}

Suggested citation

Archsmith, James. (2022) fastgini -- Quickly compute Gini coefficients. https://github.com/drofphilosophe/Stata-fastgini


{marker examples}{...}
{title:Examples}

Setup
{phang}{cmd:. webuse highschool}{p_end}

Compute Gini coefficient on height
{phang}{cmd:. fastgini height}{p_end}

Compute Gini coefficient on height using sampling weights
{phang}{cmd:. fastgini height [fweight=sampwgt]}{p_end}

Compute Gini coefficient on height, using sampling weights, treating height as discrete
{phang}{cmd:. fastgini height [pweight=sampwgt], discrete}{p_end}

