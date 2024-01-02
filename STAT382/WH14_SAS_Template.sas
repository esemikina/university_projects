/*  STAT 382 HOMEWORK 14 */



/* Task 1: Data Frame Creation */
TITLE1 "Task 1";
TITLE2 "Q1 Part a) Import Datasets";




TITLE2 "Q1 Part b) Modify column formats";
DATA nyse; *change the name to whatever you named your NYSE dataset;
  LENGTH Exchange $30 SYMBOL $30;
  FORMAT Exchange $30. SYMBOL $30.;
  SET nyse; *change the name to whatever you named your NYSE dataset;
RUN;

DATA nasdaq; *change the name to whatever you named your NASDAQ dataset;
  LENGTH Exchange $30 Symbol $30 Name $35;
  FORMAT Exchange $30. Symbol $30. Name $35.;
  SET nasdaq;  *change the name to whatever you named your NASDAQ dataset;
RUN;



TITLE2 "Q1 Part c) Combine NYSE and NASDAQ Datasets"; * list NYSE first;




TITLE2 "Q1 Part d) Sort stocks by ascending Sector";




TITLE2 "Q1 Part e) Create the dataset SectorVolatility";




TITLE2 "Q1 Part f) Sort SectorVolatility by ascending Sector";




TITLE2 "Q1 Part g) Merge the stocks dataset and the SectorVolatility dataset to create stocks2";









/* Task 2: Cleaning and Formatting */
TITLE1 "Task 2";
TITLE2 "Q2) Replace NA values for DividendYield with 0s in new dataset stocks_divfix";




TITLE2 "Q3) Remove rows for PricetoEarnings and PricetoBook that are NA. Do this in a new dataset called stocks_clean";









/* Task 3: Variable Creation and Subsetting */
TITLE1 "Task 3";
TITLE2 "Q4) Create a new variable called spread = FiftytwoWeekHigh - FiftytwoWeekLow";




TITLE2 "Q5) Create a new variable called Earnings_category";




TITLE2 "Q6) Create dividends dataset";









/* Task 4: Descriptive Statistics and Graphics */
TITLE1 "Task 4";
TITLE2 "Q7) Create a frequency table for Sector";




TITLE2 "Q8) Create a vertical bar chart for Sector";




TITLE2 "Q9) Compute only the mean and the median Price by Sector";




TITLE2 "Q10) Create a histogram for EarningsperShare";




TITLE2 "Q11) Create a horizontal boxplot for FiftytwoWeekHigh";








