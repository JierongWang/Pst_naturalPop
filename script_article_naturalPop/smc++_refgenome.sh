################# 
splitfa AZ2B.fa 35 | split -l 20000000 -d - read.split
#################
ls ./read.split*[0-9] | while read aa
do
echo "#!/bin/sh
bwa aln -t 4  -R 1000000 -O 3 -E 3 AZ2B.fa $aa > $aa.sai
bwa samse AZ2B.fa $aa.sai $aa | gzip > $aa.sam.gz
" > $aa.bwa.sh
done
###################
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

