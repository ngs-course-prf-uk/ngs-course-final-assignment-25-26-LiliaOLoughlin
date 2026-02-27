[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/SzF8zjrH)
# Unix Course Final Assignment Tasks 1 and 2 
These tasks involve data extraction from a vcf file then graphically displaying the distributions of PHRED Quality Scores and read depths across the genome and by chromosome.

## Data extraction
The shell script workflow.sh processes vcf file and obtains relevant columns for data analysis.

First, a dataset is created without header information. 

```bash
</data-shared/vcf_examples/luscinia_vars_flags.vcf.gz zcat | grep -v '^#' > data/NoHeaders.vcf
```

Next, extract columns 1-6 and the DP values from the INFO column

```bash
FILE=data/NoHeaders.vcf

<$FILE cut -f 1-6 > data/Columns1-6.tsv

<$FILE grep -E -o 'DP=([^;]+)' | sed 's/DP=//' > data/DPColumn.tsv
```

Ensure DPColumn.tsv and Columns1-6.tsv are the same length.

```bash
wc -l data/*.tsv
```

Lastly combine all files into one dataframe.

```bash
paste data/Columns1-6.tsv data/DPColumn.tsv > data/AllColumns.tsv
```
## Generating Graphics in R Studio

The R script data-analysis.R uses dataframe from previous step to generate graphical representations of PHRED Quality Scores and Read Depths using R packages tidyverse, dplyr and hardhat. Firstly the vcf file is imported into R, columns names are added and chromosome names are simplified. This will prevent overlapping x axis text when viewing many chromosome boxplots in one pane. Rows with PHRED Quality Scores below 60.1 (to remove outliers above usual PHRED range) are extracted into new dataframe for quality score analysis. Finally the graphs can be generated. 

### PHRED Quality Scores Across Genome

<img width="1240" height="432" alt="image" src="https://github.com/user-attachments/assets/3e11224e-9ac0-48a0-8f8a-1fc796326155" />

<img width="1084" height="520" alt="image" src="https://github.com/user-attachments/assets/bf153ebd-dc09-4b00-8a14-fee98495e832" />

Boxplots and histograms are representations of the distribution of data points. From these two graphs, we can see that quality scores throughout the genome are not normally distributed, but are skewed to the right. For further analysis, we may wish to exclude data points with quality scores below the lower interquartile range (<9).  

### PHRED Quality Scores by Chromosome

<img width="1695" height="556" alt="image" src="https://github.com/user-attachments/assets/7e31c9e0-d5a1-4784-8e4d-4cdc9ed26fe1" />

The majority of chromosomes have median quality scores around 20, with the exceptions of Chr 11 random, Chr 17 random, Chr 7 random and Chr 9 random. Most chromosomes' quality scores appear skewed to the right.

### Read Depth Across Genome

<img width="1086" height="426" alt="image" src="https://github.com/user-attachments/assets/49122485-ece4-4855-a179-8e615fdd8c7a" />

<img width="1752" height="568" alt="image" src="https://github.com/user-attachments/assets/9fcf3bfe-98eb-4421-b778-2f68d11c007f" />

These graphs show that the majority of sequences have a depth less than 50, however in the boxplot it is apparent that there are a large number of outliers with read depth above 100. 

### Read Depth By Chromosome

<img width="1695" height="556" alt="image" src="https://github.com/user-attachments/assets/48b1945d-fac1-43c5-b0c2-4bf9cd106b54" />

These boxplots show that while most chromosomes have many high outlier values, 50% of data points (by chromosome) consistently fall within the ~ 10-40 range of read depth. Before further analysis, sequences with depths below 30 may be removed to ensure high accuracy of results. 




