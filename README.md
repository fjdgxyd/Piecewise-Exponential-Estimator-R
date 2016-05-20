#Piecewise-Exponential-Estimator-R  
I am not a professional programmer. I coded this inspired by a thesis which has some sort of mistakes. And it is part of my recent school work in the course of "Survival Modeling.  

I created 2 functions, “pexe()”  and “pexefun()”. 

•	pexe(time = , event =)  
pexe() needs two numeric vector arguments. The first vector stores observed time, excluding time “0”. The second vector stores 0s and 1s. 1: uncensored, 0: censored
It returns a list of 4; 2 vectors, 1 data frame and 1 list. Two vectors named “start” and “end”, which refer to the start and end point of an interval. The data frame is used to print failure rate within each interval. The list stores exponential function pieces for further use.

•	pexefun(steP = , endvec =, funclist =)   
pexefun() needs 3 arguments. The first is “steP”, the same “step” you use to generate a sequence of numbers in R. It is used to generate x values to plot PEXE. The second argument is a numeric vector named “endvec”. It is exactly the "end" vector we’ve got from the function pexe(). It is used as conditions for choosing which function from the function list to apply to x in the “x” vector.
The third argument is a list of functions pieces as mentioned before.
This function returns a list of 2 vectors named “x” and “y”. These 2 vectors are used to plot the PEXE.  
##Inspiring Thesis
J. S. Kim and F. Proschan, "Piecewise exponential estimator of the survivor function," in IEEE Transactions on Reliability, vol. 40, no. 2, pp. 134-139, Jun 1991.
