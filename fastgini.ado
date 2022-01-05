/********************************************
** fastgini
**

Copyright 2016 James Archsmith

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


This program computes a GINI coefficient from an arbitrary data series using Mata. 
*************************************************/


mata
	/* Compute the GINI coefficient of x using weights w 
	   Assumes x as been sorted in ascending order. 
	   Why don't I assert the data are sorted? The program should be fast and
	   we call to sort before calling this function. 
	   I adapted the algorithm from here:
	   http://freerangestats.info/blog/2017/08/05/weighted-gini
	   which is licensed under CC BY-SA 4.0
	   It references a working paper "Working Paper No 17–02 by Vic Duoba and Nairn MacGibbon"
	   at https://www.stats.govt.nz/methods/research-papers/working-papers-original/calc-gini-index-17-02.aspx
	   which is a dead link. Google Scholar searches do not turn up the working paper
	   
	   This algorithim is O(n) once the data are sorted by x and the sort is O(n log n)
	   compared to other algorithms that are O(n^2)
	*/
	real scalar fastgini(x,w) {
		real vector wx, wsum, wxsum, pxi, pci
		real scalar N, g, i
		
		N = length(x)
		wx = x :* w
		
		wxsum = quadsum(wx)
		wsum = quadsum(w)
		
		pxi = quadrunningsum(wx) / wxsum
		pci = quadrunningsum(w) / wsum
		
		g = quadsum( pxi[|2\N|]:*pci[|1\N-1|] - pci[|2\N|]:*pxi[|1\N-1|])
		return(g)
	}
end

capture program drop fastgini
program define fastgini, rclass
	syntax varname [if] [in] [fw aw/], [discrete]
	version 16.0
	
	di "{txt}Computing GINI coefficient for variable {res}`varlist'"
	marksample touse
	
	if "`exp'" != "" {
		local w `exp'
		markout `touse' `w'
		di "{txt}Using weights {res}`exp'"
	}
	else {
		/* set weights to one if not specified */
		tempvar w
		gen long `w' = 1
	}
	
	/* This is most efficient using frames, available in Stata 16 or later */
	if c(stata_version) >= 16 {
		qui frame
		local ORIGFRAME `r(currentframe)'
		
		tempname DFRAME
		frame put `varlist' `w' if `touse', into(`DFRAME')
		frame change `DFRAME'
	} 
	else {
		/* Otherwise preserve */
		preserve
	}

		/* Collapse the data if the discrete option is specified. 
		   This will be helpful if x is discrete otherwise not so much.
		   I could count unique values of varlist and guess whether I should
		   collapse, but this program is supposed to be fast. 
		*/
		if "`discrete'" == "discrete" {
			di "{txt}Assuming {res}`varlist' {txt}is discrete"
			collapse (sum) `w', by(`varlist') fast
		}
		else {
			di "{txt}Assuming {res}`varlist' {txt}is continuous"
		}
		
		/* fastgini() requires data to be sorted by x
		   we'll use the fastest sorting algorithim I have... quicksort
		*/
		sort `varlist'
		
		/* Supply data to the mata objects */
		tempname mata_x mata_w coef
		mata: `mata_x'=st_data(.,"`varlist'")		/* Vector of x values */
		mata: `mata_w'=st_data(.,"`w'")			/* Vector of weights */
		
		/* Compute GINI and return the result to coef */
		mata: st_numscalar("`coef'",fastgini(`mata_x',`mata_w')) 

	
	/* Return the data to the original format */
	if c(stata_version) >= 16 {
		qui frame change `ORIGFRAME'
		qui frame drop `DFRAME'
	} 
	else {
		restore
	}

	/* Return results and display them */
	di "{txt}GINI Coefficient: {res}" `coef'
	return scalar coef=`coef'
	
end


	