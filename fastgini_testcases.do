/* Some sample data. The GINI of these data should be about 0.48 */
clear //all
input x
	50
	50
	50
	50
	50
	50
	1
	1
	1
	1
	1
	1
end
fastgini x

clear
set obs 1000000
set seed 12345
**Generate some lognormal data
gen x = exp(rnormal())
**These data should have a GINI of erf(1/2)=0.5204998778
fastgini x

/* The GINI of uniformly-distributed values should be about 0.33.
   Run with increasing sample sizes so we can get a sense of the computational
   complexity of the algorithm
 */
timer clear
clear
set obs 1000
gen x = runiform()
timer on 1
fastgini x
timer off 1

clear
set obs 10000
gen x = runiform()
timer on 2
fastgini x
timer off 2
timer list

clear
set obs 100000
gen x = runiform()
timer on 3
fastgini x
timer off 3


clear
set obs 1000000
gen x = runiform()
timer on 4
fastgini x
timer off 4

clear
set obs 10000000
gen x = round(runiform()*20000)
timer on 5
fastgini x
timer off 5

/* Do this again, collapsing the data on x before computing the coefficient */
timer on 6
fastgini x, discrete
timer off 6
timer list	