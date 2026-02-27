#set working directory

setwd("~/ngs-course-final-assignment-25-26-LiliaOLoughlin/data")

#set up library
library(tidyverse)
library(dplyr)
library(hardhat)

#import data
ChromosomeData <- read_tsv("AllColumns.tsv", col_names = FALSE) 

#set column names
colnames(ChromosomeData) <- c("Chromosome","Position","ID","Reference","Alternative","Quality","DP")

#simplify chromosome names for better graphing
ChromosomeData$Chromosome <- str_remove(ChromosomeData$Chromosome, "chr")
ChromosomeData$Chromosome <- str_remove(ChromosomeData$Chromosome,"_")
ChromosomeData$Chromosome <- str_remove(ChromosomeData$Chromosome,"andom")
ChromosomeData$Chromosome <- str_remove(ChromosomeData$Chromosome, "mapped")

#make chromosome into factor
ChromosomeData$Chromosome <- as.factor(ChromosomeData$Chromosome)

#Check chromosome names with hardhat
get_levels(ChromosomeData)

#recode factors using dplyr 
ChromosomeData$Chromosome <- recode_factor(ChromosomeData$Chromosome, "LG2" = "L2")
ChromosomeData$Chromosome <- recode_factor(ChromosomeData$Chromosome, "LG5" = "L5")
ChromosomeData$Chromosome <- recode_factor(ChromosomeData$Chromosome, "LGE22" = "L22")
ChromosomeData$Chromosome <- recode_factor(ChromosomeData$Chromosome, "LGE22r" = "L22r")

#check factors
ChromosomeData$Chromosome


#make highest value 60
TotalQuality <- ChromosomeData %>% filter(ChromosomeData$Quality < 60.1)





#make box plot of general quality values
ggplot(TotalQuality, aes(x=Quality)) +
  geom_boxplot()+
  ggtitle("Boxplot of Genome PHRED Scores")+
  xlab("PHRED Quality Score") +
  theme(axis.title.y=element_blank(),
axis.text.y=element_blank(),
axis.ticks.y=element_blank())


#histogram of Quality scores 
ggplot(TotalQuality, aes(x=Quality)) +
  geom_histogram()+
  ggtitle("Histogram of Genome PHRED Scores")+
  xlab("PHRED Quality Score")

#boxplot by chromosome
ggplot(TotalQuality, aes(y=Quality, x=Chromosome)) +
  geom_boxplot()+
  ggtitle("Boxplots of Chromosome PHRED Scores")+
  xlab("PHRED Quality Score") +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) 
TotalQuality$Chromosome

