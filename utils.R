## this R script holds utility functions for the run_analysis.R script

## merge data from two different files into one dataset
merged_data <- function(firstFile,secondFile){
  
  firstDateframe <- read.table(firstFile)
  secondDateframe <- read.table(secondFile)
  rbind(firstDateframe,secondDateframe)
}