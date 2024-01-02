/* Homework 14 */
/* Yelizaveta Semikina */

/* Task 1 */
/* 1.a */

/** Import the stocks nasdaq file.  **/
FILENAME nasdaq "/home/u62830651/SAS_stocks_nasdaq.csv";

PROC IMPORT DATAFILE=nasdaq
		    OUT=nasdaq
		    DBMS=CSV
		    REPLACE;
RUN;

/** Import the stocks nyse file.  **/
FILENAME nyse "/home/u62830651/SAS_stocks_nyse.csv";

PROC IMPORT DATAFILE=nyse
		    OUT=nyse
		    DBMS=CSV
		    REPLACE;
RUN;

/* 1.b */
DATA nasdaq; 
LENGTH Exchange $30 Symbol $30 Name $35;
FORMAT Exchange $30. Symbol $30. Name $35.;
SET nasdaq; 
RUN;

DATA nyse; 
LENGTH Exchange $30 SYMBOL $30;
FORMAT Exchange $30. SYMBOL $30.;
SET nyse; 
RUN;

/* 1.c */
DATA stocks;
SET NYSE NASDAQ;
PROC PRINT DATA = stocks;
RUN;

/* 1.d */
PROC SORT DATA = stocks out=stocks;
by sector;
RUN;

/* 1.e */
DATA SectorVolatility;
INFILE datalines dlm=',' dsd;
LENGTH Sector $22.;
LENGTH Sector_Volatility $30.;
INPUT Sector $ Sector_Volatility $ @@;
datalines;
Materials, Low
Information_Technology, High
Consumer_Discretionary, High
Health_Care, Moderate
Consumer_Staples, Moderate
Telecomm_Services, High
Financials, High
Industrials, Low
Energy, High
Utilities, Moderate
Real_Estate, Low
;
RUN;
PROC PRINT DATA = SectorVolatility;
RUN;

/* 1.f */
PROC SORT DATA = SectorVolatility out=SectorVolatility;
by sector;
RUN;

/* 1.g */
DATA stocks2;
MERGE stocks SectorVolatility;
PROC SORT DATA = stocks2 out=stocks2;
by sector;
RUN;
PROC PRINT DATA = stocks2; 
RUN;



/* Task 2 */
/* 2.2 */
DATA STOCKS_DIVFIX;
SET STOCKS2;
IF DividendYield = . THEN DividendYield = 0;
PROC PRINT DATA = stocks_divfix; 
RUN;

/* 2.3 */
DATA STOCKS_CLEAN;
SET STOCKS_DIVFIX;
IF PricetoEarnings = . THEN DELETE;
IF PricetoBook = . THEN DELETE;
PROC PRINT DATA = STOCKS_CLEAN; 
RUN;



/* Task 3 */
/* 3.4 */
DATA stocks_clean;
SET stocks_clean;
Spread=FiftytwoWeekHigh-FiftytwoWeekLow;
PROC PRINT DATA = STOCKS_CLEAN; 
RUN;

/* 3.5 */
DATA stocks_clean;
SET stocks_clean;
LENGTH Earnings_Category $6.;
IF EarningsperShare<0 THEN Earnings_Category = "Loss";
IF EarningsperShare>=0 AND EarningsperShare<3 THEN Earnings_Category = "Small";
IF EarningsperShare>=3 AND EarningsperShare<10 THEN Earnings_Category = "Good";
IF EarningsperShare>=10 THEN Earnings_Category = "Strong";
PROC PRINT DATA = STOCKS_CLEAN; 
RUN;

/* 3.6 */
DATA dividends;
SET stocks_clean;
KEEP Symbol Name Exchange Sector DividendYield;
WHERE DividendYield > 0;
IF DividendYield = 0 THEN DELETE;
PROC PRINT DATA = dividends; 
RUN;



/* Task 4 */
/* 4.7 */
PROC FREQ DATA=stocks_clean;
    TABLE Sector;    
RUN;

/* 4.8 */
proc sgplot data=stocks_clean;
 vbar Sector;
run;

/* 4.9 */
PROC MEANS DATA=stocks_clean MEAN MEDIAN; 
var Price;
by Sector;
RUN;

/* 4.10 */
proc sgplot data=stocks_clean;
histogram EarningsperShare;
run;

/* 4.11 */
proc sgplot data=stocks_clean;
hbox FiftytwoWeekHigh;
run;


















