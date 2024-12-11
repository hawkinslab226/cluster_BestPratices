#$ -S /bin/bash   ##require 
#$ -pe serial 1 ##cluster nodes
#$ -l mfree=85G -l h_rt=100:00:00  #memory request and total time to run the job  
#$ -o /net/hawkins/vol1/home/aolima/atac_seq_chicken/seq_230825 #log file: output 
#$ -e /net/hawkins/vol1/home/aolima/atac_seq_chicken/seq_230825 #log file: error
###**************************************************************************************************
##Job Name: ATACSeq  #job name #Best Pratices 
##Project Name: FAANG - Chicken Funtional Annotation # project name
##Process & Mapping ATAC-Seq data  #analysis type 
##Author Name: Andressa Oliveira de Lima 
##Email: aolima@uw.edu
##chmod + x (execute the job)
##****************************************************************************************************
###Example job 
#
###softwares via module or conda **module avail**
module load bedtools/2.31.1
#
cd /net/hawkins/vol1/home/aolima/atac_seq_chicken/seq_230825 #folder path that you are running your job
##your job 
bedtools sort -i file.bed > file.sorted.bed 


