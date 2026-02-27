#write script here

#create dataset without headers
</data-shared/vcf_examples/luscinia_vars_flags.vcf.gz zcat | grep -v '^#' > data/NoHeaders.vcf

#extract columns 1-6 and read depth information

FILE=data/NoHeaders.vcf

<$FILE cut -f 1-6 > data/Columns1-6.tsv

<$FILE grep -E -o 'DP=([^;]+)' | sed 's/DP=//' > data/DPColumn.tsv

#check if all .tsv files are the same length

wc -l data/*.tsv

#combine files into one dataframe

paste data/Columns1-6.tsv data/DPColumn.tsv > data/AllColumns.tsv


