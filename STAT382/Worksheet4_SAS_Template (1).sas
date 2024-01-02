/* STAT 382 WORKSHEET 4 */


/* IMPORT DATASET */
TITLE1 'TASK 0: IMPORT DATASET';
FILENAME bears "/home/u62830651/sasuser.v94/Worksheet4/SAS_bears2021.csv";

PROC IMPORT DATAFILE=bears
		    OUT=bears
		    DBMS=CSV
		    REPLACE;
RUN;




/* Question 2: Compute a 93% Confidence Interval for Mean Age */
TITLE1 'TASK 1: INFERENCE';
TITLE2 'Q2) 93% CI for Mean Age';

PROC UNIVARIATE DATA = bears
CIBASIC (ALPHA = 0.07 TYPE = TWOSIDED);
VAR Age;
RUN;
	
	/* The 93% CI is:      
	26.46012 < mu < 28.67625
	*/
	
	

	
/* Question 3: Test the claim that the mean G_Played is
	greater than 12 at a 7.5% significance level. */
TITLE2 'Q3) G_Played HT';

/* Hypotheses:
	H0: mu = 12
	H1: mu > 12
*/


* Code;	
PROC TTEST data=bears h0=12 sides=u plots;
var G_Played ;
run;


/* 
P-value = 0.1045
Decision: Do not reject. 
Conclusion: There is not enough evidence that the mean G_Played is greater than 12 at a 7.5% significance level.
*/





/* Question 4: Code for MLR Model */
TITLE1 'TASK 2: MULTIPLE LINEAR REGRESSION';
TITLE2 'Q4) Code for Multiple Linear Regression Model';

PROC REG DATA=bears;
MODEL G_Started=G_Played Age;
RUN;



/* Question 5: Overall Model Analysis
Null Hypothesis: H0=Beta1=Beta2=0 
Alternative Hypothesis: H1: at least one Betai !=0
Let 1 = G_Played and 2 = Age

Test Statistic = F=6.87
P-Value = 0.0027

Decision: Reject H0
Conclusion: There is evidence variable explaining some variability 
*/




/* Question 6: Individual Variable Analysis - If needed /*
/* Analysis for G_Played (if needed)
Null Hypothesis: H0=BetaG_Played=0
Alternative Hypothesis: H1=BetaG_Played!=0

Test Statistic = t= 3.57
P-Value = 0.0009

Decision: Reject H0
Conclusion: There is enough evidence that G_Played is important in explaining some of the 
variability in G_Started.


If analysis is not needed, state so here:
*/



/* Analysis for Age (if needed)
Null Hypothesis: H0=BetaAge=0
Alternative Hypothesis: H1=BetaAge!=0

Test Statistic = t = -0.45	
P-Value = 0.6566

Decision: Do not reject H0
Conclusion: There is enough evidence that Age variable is not important in explaining some 
of the variability in G_Started.

If analysis is not needed, state so here:
*/





/* Question 7: Compute Pearson's and Spearman's Correlation Matrix */
TITLE2 'Q7) Pearson and Spearman Correlation Matrix';
PROC CORR DATA=bears pearson spearman;
var G_Played Age G_Started;
RUN;

