*******************************
	Exam 2
	Name: Yelizaveta Semikina
	Version: Embers version 2
*******************************;


*******************************
******** Task 1: DATA *********
*******************************;

/* Question 1: Import Data */
TITLE 'Task1 Q1: Import Data';

FILENAME Rides1 "/home/u62830651/sasuser.v94/Exam2/rides1.csv";

PROC IMPORT DATAFILE=Rides1
		    OUT=Rides1
		    DBMS=CSV
		    REPLACE;
RUN;
PROC PRINT DATA = Rides1;
RUN;


/* Question 2: Change values to 0 where there is missing data in the xxx column (see PDF for column) */
TITLE 'Task1 Q2: Adjust for Missing Data';

DATA Rides1_Task1;
SET Rides1;
IF Fall_Distance = . THEN Fall_Distance = 0;
RUN;
PROC PRINT DATA = Rides1_Task1;
RUN;


/* Question 3: Create a new character variable */
TITLE 'Task1 Q3: Create Character Variable';
DATA Rides1_Task1;
SET Rides1_Task1;
LENGTH LengthGroup $8.;
IF Distance_Traveled<=1700 THEN LengthGroup = "Short";
IF Distance_Traveled>1700 AND Distance_Traveled<=4000 THEN LengthGroup = "Medium";
IF Distance_Traveled>4000 THEN LengthGroup = "Long";
PROC PRINT DATA = Rides1_Task1; 
RUN;



/* Question 4: Create a new variable called Ratio */
TITLE 'Task1 Q4: Create Ratio';
DATA Rides1_Task1;
SET Rides1_Task1;
Ratio=Elevation/MPH;
RUN;
PROC PRINT DATA = Rides1_Task1; 
RUN;


/* Question 5: Create a New Dataset called High_Ratio and Print it */
TITLE 'Task1 Q5: Create Dataset High_Ratio';
DATA High_Ratio;
SET Rides1_Task1;
WHERE Ratio>2.75;
KEEP Material_Used Elevation MPH Fall_Distance;
RUN;
PROC PRINT DATA = High_Ratio; 
RUN;








************************************************
******** Task 2: INTRODUCTORY ANALYSIS *********
************************************************;

/* Question 6: Compute ONLY values of sample mean / median / std dev / IQR
	/ # Observations / # Missing */
TITLE 'Task2 Q6: Summary Statistics';
PROC MEANS DATA=Rides1 MEAN MEDIAN STD QRANGE N NMISS;
var Ride_Length_Time;
RUN;

	
/* Question 7: Histogram with density normal and describe it */
TITLE 'Task2 Q7: Histogram with Density Normal';
/* CODE */
PROC SGPLOT DATA=Rides1;
HISTOGRAM Fall_Distance;
DENSITY Fall_Distance / type=normal;
RUN;


/* Describe the histogram */
/* Based on the curve we can say that the histogram does not look normal and it is right 
   skewed.*/


	
/* Question 8: Bar Chart */
TITLE 'Task2 Q8: Bar Chart';
PROC SGPLOT DATA=Rides1;
VBAR SpeedGroup;
label SpeedGroup='Speed Group';
RUN;



/* Question 9: Boxplot */
TITLE 'Task2 Q9: Boxplot';
/* CODE */
PROC SGPLOT DATA=Rides1;
HBOX Elevation;
RUN;


/* Are there outliers? */
/* Yes, there are outliers to the right of the boxplot. There are five outliers. */







************************************************
******** Task 3: INFERENCE *********************
************************************************;

TITLE 'Task3 Q10, Q11: Inference';
	/* CODE */
PROC TTEST DATA=Rides1 h0=0 sides=2 ALPHA=0.026 plots;
class Material_Used;
var Distance_Traveled; 
run;

PROC TTEST DATA=Rides1 h0=-825 sides=u ALPHA=0.026 plots;
class Material_Used;
var Distance_Traveled;
RUN;
	


	/* Question 10: Equal Variance Test */
	/* 	Hypotheses
			H0: σ^2Steel=σ^2Wood
			H1: σ^2Steel!=σ^2Wood
		Test Statistic: F=1.35
		P-Value: 0.3650
		Decision: Do not reject H0
		Conclusion: There is not enough evidence that the variances are different. 
		Variances are equal.
	*/

	
	/* Question 11: Mean Testing */
	/*	Hypotheses
			H0: muSteel - muWood = -825;
			H1: muSteel - muWood < -825;
		Test Statistic: t=-2.02
		P-Value: 0.9775
		Decision: Do not reject H0
		Conclusion: There is not enough evidence that the mean Distance_Traveled for steel materials minus 
		the mean Distance_Traveled for wood materials is less than -825.
	*/
			
			
	
	
	
	
************************************************
******** Task 4: REGRESSION ********************
************************************************;
TITLE 'Task4 Q12: Multiple Linear Regression';
/* CODE */
PROC REG DATA=Rides1 ALPHA=0.012 ;
MODEL Ride_Length_Time=Distance_Traveled Type;
RUN;


			
/*
Part a - Check model assumptions
	Linearity
		Graph / results looked at: Residual by Regressors for Ride_Length_Time
		Is the linearity condition met or not? 
		Linearity is met because there is no patterns. 

	Normality
		Graph / results looked at: Fit Diagnostics: Residual vs Quantile and Percent vs Residual
		Is the normality of residuals condition met or not? 
		
		Normality is not met because on the Residual vs Quantile we can see that there are
		dots in the right top corner that are too far away from the line.
		Also, on the Percent vs Residual graph, we can see that the histogram is somewhat bell
		shaped but not perfectly 

	Equal Variance
		Graph / results looked at: Residual vs Predicted Value
		Is the equal variance of residuals condition met or not? 
		Condition is met because there is no pattern. 
		
		
	
Part b - Give the equation of the Multiple Linear Regression line

Ride_Length_Time=44.60286+0.02367*Distance_Traveled+14.09045×Type
		
		
Part c - Does the model in total explain variability in Ride_Length_Time?
	Hypotheses
		H0: Beta_Distance_Traveled = Beta_Type = 0
		H1: at leats one Beta != 0
	Test Statistic: F=146.47
	P-Value: <.0001
	Decision: Reject H0
	Conclusion: There is enough evidence that there is at least one variable explaining 
	the variability in Ride_Length_Time.
			
			

			
Part d (If needed. If not needed, state why.)

	Testing Individual Variables (Variable 1 = Distance_Traveled)
		Hypotheses
			H0: Beta_Distance_Traveled = 0
			H1: Beta_Distance_Traveled != 0
		Test Statistic: 16.90
		P-Value: <.0001
		Decision: Reject H0
		Conclusion: There is enough evidence that Distance_Traveled is important in explaining
        some of the variability in Ride_Length_Time.
		
		
	Testing Individual Variables (Variable 2 = Type)
		Hypotheses
			H0: Beta_Type = 0
			H1: Beta_Type != 0
		Test Statistic: 2.29
		P-Value: 0.0238
		Decision: Do not reject H0
		Conclusion: There is enough evidence that the Type variable is not important in explaining 
		some of the variability in Ride_Length_Time.
			


			
Part e - Value of R^2 and interpretation
	R^2: 0.6861
	Interpretation: 68.61% of the variability in Ride_Length_Time is explained 
	by Distance_Traveled and Type.
		
		
*/
	
	
	
	
	
	
	
************************************************
******** Task 5: 1-way ANOVA *******************
************************************************;
TITLE 'Task5 Q13: 1-Way ANOVA';

TITLE2 'Part a: Mean Duration for each Group';
	/* CODE */
PROC MEANS DATA = Rides1; CLASS SpeedGroup;
VAR Ride_Length_Time;
RUN;


	/* Detail any difference by group. 
 There are three groups. Fast has the highest number of observations(non-missing) which is 94 and slow has the lowest
 number of non-missing observations which is 13 (which is <30), for the middle, it is 30, 
 which is equal to 30. As for means, the lowest mean has Slow which is (85.0769231) and the 
 highest has Fast(137.1170213). Means are decreasing from Fast to Slow. Standard deviation for
 Slow and Middle are kind of close and the STD for Fast is bigger than STD for Slow and Middle. 
	

*/	
TITLE2 'Part b: Side by Side Boxpots';
	/* CODE */
PROC SGPLOT DATA=Rides1;
HBOX Ride_Length_Time / Category=SpeedGroup;
RUN;


	/* Detail any difference by group. 
	All three means are different and the mean/median increases by going from Low to Fast.
	Slow Group has Outliers but Middle and Fast do not have any. 
	
	   How many groups are there? 
	   There are 3 groups.
	
	
	   Are the sample sizes large (>30) in each group?
	   Yes, the Fast Group has the biggest sample size and the Middle and Low has smaller 
	   sample sizes. */

TITLE2 'Part c: Run a 1-way ANOVA model';

PROC GLM DATA=Rides1 ALPHA=0.03;
CLASS SpeedGroup;
MODEL Ride_Length_Time = SpeedGroup;
MEANS SpeedGroup / BON TUKEY CLDIFF HOVTEST = LEVENE;
OUTPUT OUT = ANOVA221 r = residual;
RUN;
	
	
	
TITLE2 'Part d: Normality Test';
/* Will you test the normality assumption using the overall dataset, or for each group 
individually? 
No, because there is only one sample size for Fast equals >30, for the Middle it is equals
to 30 and for the Low it is <30. */


/* CODE, if needed */
PROC UNIVARIATE NORMAL PLOT DATA = ANOVA221 ALPHA=0.03;
VAR residual;
RUN;

/* Conclusion(s): 
Normality check is met because Shapiro-Wilk has p-value of 0.0329, which is a little bigger 
than significance level of 0.03. Thus, the normality check for overall model was passed.
*/

	
TITLE2 'Part e: Equal Variance Assumption Check';
/* Conclusion: 
Equal Variance Check is not met. Based on the Levene Test, there is a p-value of 0.0021, thus, 
it means that 0.0021 is smaller than the significance level of 0.03. 
*/




TITLE2 'Part f: Is there a significant evidence of an effect?';
/*	Hypotheses
		H0: mu_Slow = mu_Middle = mu_Fast = 0
		H1: at least one mu != 0
	Test Statistic: F=15.98
	P-Value: <.0001
	Decision: Reject H0
	Conclusion: There is enough evidence to say that there is significant evidence of an effect.
*/




TITLE2 'Part g: Bonerroni or Tukey';
/* Are you providing Bonferroni or Tukey Intervals? 
Bonferroni Intervals
*/


/* Provide confidence intervals for each difference
	(make sure to indicate the difference you are writing a confidence interval for): 
Fast - Middle (14.632, 59.202)
Fast - Slow	(20.594, 83.487)	
Middle - Fast (-59.202,	-14.632)
Middle - Slow (-20.164, 50.410) 
Slow - Fast	(-83.487, -20.594)	
Slow - Middle (-50.410, 20.16)	
*/


/* For each pair, state whether the difference is significant or not 
Fast - Middle: difference is significant;
Fast - Slow: difference is significant;
Middle - Fast: difference is significant;
Middle - Slow: difference is not significant;
Slow - Fast: difference is significant;
Slow - Middle: difference is not significant.
*/





TITLE;
TITLE2;