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

#simplify chromosome names for clearer reading of graph
ChromosomeData$Chromosome <- str_remove(ChromosomeData$Chromosome, "chr")
ChromosomeData$Chromosome <- str_remove(ChromosomeData$Chromosome,"_")
ChromosomeData$Chromosome <- str_remove(ChromosomeData$Chromosome,"andom")
ChromosomeData$Chromosome <- str_remove(ChromosomeData$Chromosome, "mapped")

#make chromosome into factor
ChromosomeData$Chromosome <- as.factor(ChromosomeData$Chromosome)

#Check all chromosome names with hardhat
get_levels(ChromosomeData)

#recode factors using dplyr 
ChromosomeData$Chromosome <- recode_factor(ChromosomeData$Chromosome, "LG2" = "L2")
ChromosomeData$Chromosome <- recode_factor(ChromosomeData$Chromosome, "LG5" = "L5")
ChromosomeData$Chromosome <- recode_factor(ChromosomeData$Chromosome, "LGE22" = "L22")
ChromosomeData$Chromosome <- recode_factor(ChromosomeData$Chromosome, "LGE22r" = "L22r")

#check factors
ChromosomeData$Chromosome


#remove rows with Quality value over 60 in new dataframe
TotalQuality <- ChromosomeData %>% filter(ChromosomeData$Quality < 60.1)

#make box plot of genome quality values
ggplot(TotalQuality, aes(x=Quality)) +
  geom_boxplot()+
  ggtitle("Boxplot of PHRED Scores Across Genome")+
  xlab("PHRED Quality Score") +
  theme(axis.title.y=element_blank(),
axis.text.y=element_blank(),
axis.ticks.y=element_blank(),
plot.title = element_text(hjust = 0.5))


#histogram of Quality scores 
ggplot(TotalQuality, aes(x=Quality)) +
  geom_histogram()+
  ggtitle("Histogram of PHRED Scores Across Genome")+
  xlab("PHRED Quality Score")+
  ylab("Count")
  theme(plot.title = element_text(hjust = 0.5))

#boxplot by chromosome
ggplot(TotalQuality, aes(y=Quality, x=Chromosome)) +
  geom_boxplot()+
  ggtitle("Boxplots of Chromosome PHRED Scores")+
  xlab("Chromosome Number") +
  ylab("PHRED Quality Score")+
  theme(axis.text.x=element_text(size = 6),
        plot.title = element_text(hjust = 0.5)) 

#Read depth by genome boxplot

ggplot(ChromosomeData, aes(x=DP))+
  geom_boxplot(outlier.size = 0.5)+
  ggtitle("Boxplot of Read Depth Across Genome")+
  xlab("Read Depth")+
  ylab("Count")+
  theme(plot.title = element_text(hjust = 0.5))

#read depth by genome histogram
ggplot(ChromosomeData, aes(x=DP)) +
  geom_histogram(binwidth = 50)+
  ggtitle("Histogram of Read Depth Across Genome")+
  xlab("Read Depth")+
  ylab("Count")+
  theme(plot.title = element_text(hjust = 0.5))

#boxplots of read depth by chromosome
ggplot(ChromosomeData, aes(y=DP, x=Chromosome)) +
  geom_boxplot(outlier.size = 0.5)+
  ggtitle("Boxplots of Read Depth by Chromosome")+
  xlab("Chromosome") +
  ylab("Read Depth")+
  theme(axis.text.x=element_text(size = 6),
        plot.title = element_text(hjust = 0.5))
