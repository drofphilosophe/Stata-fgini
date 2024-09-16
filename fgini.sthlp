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
{viewerjumpto "License" "examplehelpfile##license"}{...}
{title:Title}

{phang}
{bf:fgini} {hline 2} Quickly compute Gini coefficients


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:fgini}
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
{cmd:fgini} computes the Gini coefficient of {it:varname}. While the Gini is defined
as a function of all pariwise combinations of values in {it:varname}, the algorithim used
in {cmd:fgini} scales in complexity approximately linearly with the number of observations. 


{marker remarks}{...}
{title:Remarks}

{pstd}
The algorithim used in {cmd:fgini} was adapted from {browse "http://freerangestats.info/blog/2017/08/05/weighted-gini":freerangestats.info/blog/2017/08/05/weighted-gini}, which appears to follow {it:Working Paper No 17–02 by Vic Duoba and Nairn MacGibbon} at {browse "https://statsnz.contentdm.oclc.org/digital/collection/p20045coll1/id/4199/":statsnz.contentdm.oclc.org/digital/collection/p20045coll1/id/4199}. 

{pstd}
Obtain the latest version using

{bf:net install fgini, from("https://github.com/drofphilosophe/Stata-fgini/raw/main") replace}

Suggested citation

Archsmith, James. (2022) fgini -- Quickly compute Gini coefficients. https://github.com/drofphilosophe/Stata-fgini


{marker examples}{...}
{title:Examples}

Setup
{phang}{cmd:. webuse highschool}{p_end}

Compute Gini coefficient on height
{phang}{cmd:. fgini height}{p_end}

Compute Gini coefficient on height using sampling weights
{phang}{cmd:. fgini height [aweight=sampwgt]}{p_end}

Compute Gini coefficient on height, using sampling weights, treating height as discrete
{phang}{cmd:. fgini height [aweight=sampwgt], discrete}{p_end}

{marker license}{...}
{title:License}
fastgini - Quickly compute Gini coefficients

Copyright 2022 James Archsmith

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
