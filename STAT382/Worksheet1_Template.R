## Worksheet 1
## Name: Yelizaveta Semikina


## Question 1 - Download file to your computer. No code required.


## Question 2 - Current Working Directory
## Make sure to also copy and paste results from your code
getwd()

# Results:
#  "/Users/liza"


## Question 3 - Change Working Directory (only code)

setwd("Users/liza/Desktop/STAT382")

# Results: setwd("/Users/liza/Desktop/STAT382")


## Question 4 - Import Dataset (only code)

bears2021 <- read.csv("bears2021.csv", header = TRUE)


## Question 5 - Verify Import
	# Environment Window. What information does this contain? Should mention at least 2 characteristics.
  # It contains a data set called bears2021 and the data set has 44 observations 

	# Print first 10 rows (only code)
	head(bears2021, 10)

	# View the structure (only code)
  str(bears2021)


## Question 6 - Sacks scored category (Sacks_cat)

bears2021$Sacks_cat[bears2021$Sacks >= 3] <- "Many"
bears2021$Sacks_cat[bears2021$Sacks > 0 & bears2021$Sacks < 3] <- "Some"
bears2021$Sacks_cat[bears2021$Sacks == 0] <- "None"

bears2021$Sacks_cat <- factor(bears2021$Sacks_cat)

	
## Question 7 - Sort the Data descending by G_played (only code).
## Save this as bears2021_sorted.

attach(bears2021)
bears2021_sorted <- bears2021[order(-G_played),]
detach(bears2021)


	
## Question 8 - Export File
## Make sure to submit your exported file when you submit everything to Gradescope
