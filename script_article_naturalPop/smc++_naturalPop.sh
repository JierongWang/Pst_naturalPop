################################### deal with reference genome
splitfa AZ2B.fa 35 | split -l 20000000 -d - read.split
############
ls ./read.split*[0-9] | while read aa
do
echo "#!/bin/sh
bwa aln -t 4  -R 1000000 -O 3 -E 3 AZ2B.fa $aa > $aa.sai
bwa samse AZ2B.fa $aa.sai $aa | gzip > $aa.sam.gz
" > $aa.bwa.sh
done
############
gzip -dc read.split*.sam.gz | ~/software/seqbility-20091110/gen_raw_mask.pl > rawMask_35.fa
## 
~/software/seqbility-20091110/gen_mask -l 35 -r 0.5 rawMask_35.fa > mask_35_50.fa
##
cat AZ2Bchr.list | while read chr
do
echo "~/software/seqbility-20091110/apply_mask_s mask_35_50.fa $chr.fa > $chr.mask.fa
perl ~/software/seqbility-20091110/get_lcase.pl $chr.mask.fa > $chr.mask.bed
bgzip $chr.mask.bed
tabix $chr.mask.bed.gz
" >> AZ2Bchr.sh
done
################################### deal with population vcf file
####### vcf2smc of CL1 
cat AZ2Bchr.list | while read chr
do
echo "smc++ vcf2smc -m $chr.mask.bed.gz gs290.snpM.vcf.gz CL1snpM_vcf2smc/CL1$chr.smc.gz $chr CL1:YN-2,XZ-21,GSY15-12,GS-5,GSY11-4,GSY13-10,GSY19-15,GSY17-10,GSY19-4" >> CL1snpM_vcf2smc.sh
done
####### vcf2smc of CL2
cat AZ2Bchr.list | while read chr
do
echo "smc++ vcf2smc -m $chr.mask.bed.gz gs290.snpM.vcf.gz CL2snpM_vcf2smc/CL2$chr.smc.gz $chr CL2:XZ-20,XZ-14,XZ-1,XZ-22,XZ-5,XZ-7,GSY22-13,GSY12-9,GSY15-20,GSY12-16,GS-20,GS-14,SC11-7,GS-4,SC7-5,GSY22-7,GSY15-11,GSY21-19,GSY18-9,GSY16-6,GSY18-1,SC7-4,SC11-3,SC7-11,GSY15-5,SC12-8,SC13-5,SC12-7,HB-1,GS-12,QH-4,QH-2,QH-1,SC11-13,GSY21-20,GSY21-13,GSY21-14,GSY22-10,GSY22-1,GSY20-5,GSY22-22,GSY20-23,GSY20-24,PL17-7,GSY15-21,GS-3,GSY12-1,GZ-1,SC-1,GS-1,GSY20-16,GS-9,GSY20-12,GS-17,QH-3,GS-8,GS-15" >> CL2snpM_vcf2smc.sh
done
############
smc++ estimate --cores 8 --knots 15 --timepoints 0 1000000 --spline cubic -o CL1snpM_analysis 2e-08 CL1snpM_vcf2smc/CL1AZ2B_Chr*.smc.gz
####
smc++ estimate --cores 8 --knots 15 --timepoints 0 1000000 --spline cubic -o CL2snpM_analysis 2e-08 CL2snpM_vcf2smc/CL2AZ2B_Chr*.smc.gz
###########
smc++ split -o CL1CL2snpMsplit CL1snpM_analysis/model.final.json CL2snpM_analysis/model.final.json CL1CL2snpM_vcf2smc/CL*AZ2B_Chr*.smc.gz
###########
smc++ plot --csv -g 1 --linear CL1CL2snpM_split.plot.pdf CL1CL2snpMsplit/model.final.json

