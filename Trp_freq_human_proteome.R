library(stringr)
library(tidyverse)
library(Biostrings)
library(openxlsx)

# This dataset includes one protein for one gene
# It's from uniprot, downloaded 23/04/14

data = readAAStringSet("./data/UP000005640_9606.fasta")

plot(letterFrequency(data,"W"))

freq = as.data.frame(letterFrequency(data,"W", as.prob = T))
freq$position = 1:dim(freq)[1]

# Select the protein with 0% frequency of tryptophane

freq = 
  freq %>% 
  filter(W == 0)

datanow = data[freq$position]

# Checking that the subsetting was accurate

letterFrequency(datanow,'W', as.prob = T)
aaa = as.data.frame(names(datanow))

bbb = as.data.frame(str_split_fixed(aaa$`names(datanow)`, pattern = "_HUMAN",2))
ccc = as.data.frame(str_split_fixed(bbb$V1, pattern = "\\|",3))

ccc$description = bbb$V2
colnames(ccc) = c("origin","uniprot","protein","description")

write.table(ccc,"./data_output/Proteins_no_W.txt")
write.xlsx(ccc,"./data_output/Proteins_no_W.xlsx")

# Select the protein with 50% frequency of tryptophane

freq1 = as.data.frame(letterFrequency(data,"W", as.prob = T))
freq1$position = 1:dim(freq1)[1]

freq2 = 
  freq %>% 
  filter(W >=1e-1)

datayesw = data[freq2$position]


# There are 9 proteins whose sequence is made of 0,1% of tryptophane

# Checking that the subsetting was accurate

letterFrequency(datayesw,'W', as.prob = T)
names(datayesw)





