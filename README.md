# fgini
 Quickly compute Gini coefficients in Stata
 
 Install this package using the following command in Stata:
 
 `net install fgini, from("https://github.com/drofphilosophe/Stata-fgini/raw/main") replace`
 
 ## Description
 This program will compute the Gini coefficient of a numeric variable. The Gini is defined as a function of all pairwise combinations 
 of the values of a variable and many implmentations scale in compute time with the square of the number of observations. This program
 implements in algorithim described by Vic Duoba and Nairn MacGibbon, which after sorting data scales linearlly with the number of 
 observations. The algorithim is implmentated in Mata, and can be substantially faster than other implementations, particularlly 
 when the number of observations is large. 

 ## Citation
 If you use this software, please cite it as

 Archsmith, J. , stata-fgini: Fast calculation if GINI coefficients in Stata (Version 1.0.0) [Computer software]. <https://github.com/drofphilosophe/Stata-fgini>

 ## License

 This sofware is licensed under the Apache License Version 2.0. 
 
