#!/bin/bash
REF=$1
fa=$2
sample=$3
############################### 0
####
blasr ${fa} ${REF} --nproc 4 > ${sample}_ps_0.blasr.out
## filter recovered read hits by the lenght of the match to the genome (here, at least 500bp hit length)
awk '{a=$8-$7;print $0,a;}' ${sample}_ps_0.blasr.out | sort -n -r -k14,14 | awk '$14>500' | sort -uk1,1 > ${sample}_ps_0.blasr.sort.out
## pull out names of reads that hit the genome with min hit length
cut -d ' ' -f1,1 ${sample}_ps_0.blasr.sort.out > ${sample}_ps_0.blasr.sort.out.fixed
##
seqtk subseq ${fa} ${sample}_ps_0.blasr.sort.out.fixed > ${sample}_ps_0.blasr.sort.out.fixed.fa
#
gzip ${sample}_ps_0.blasr.sort.out.fixed.fa
##
canu -p ${sample}_ps_0 -d ${sample}_ps_0 genomeSize=100k corOutCoverage=200 -pacbio-hifi ${sample}_ps_0.blasr.sort.out.fixed.fa.gz 2> ${sample}_ps_0.log
######
ln -s ${sample}_ps_0/${sample}_ps_0.contigs.fasta ./
############################### 1
##
blasr ${fa} ${sample}_ps_0.contigs.fasta --nproc 20 > ${sample}_ps_1.blasr.out
## 
awk '{a=$8-$7;print $0,a;}' ${sample}_ps_1.blasr.out | sort -n -r -k14,14 | awk '$14>500' | sort -uk1,1 > ${sample}_ps_1.blasr.sort.out
##
cut -d ' ' -f1,1 ${sample}_ps_1.blasr.sort.out > ${sample}_ps_1.blasr.sort.out.fixed
##
grep -F -x -v -f ${sample}_ps_0.blasr.sort.out.fixed ${sample}_ps_1.blasr.sort.out.fixed > ${sample}_ps_1.blasr.sort.out.fixednew
##
seqtk subseq ${fa} ${sample}_ps_1.blasr.sort.out.fixednew > ${sample}_ps_1.blasr.sort.out.fixed.fa
##
less ${sample}_ps_0.blasr.sort.out.fixed.fa.gz | cat >> ${sample}_ps_1.blasr.sort.out.fixed.fa 
grep '>' ${sample}_ps_1.blasr.sort.out.fixed.fa > ${sample}_ps_1.blasr.sort.out.fixed
sed -i 's/>//' ${sample}_ps_1.blasr.sort.out.fixed
# 
gzip ${sample}_ps_1.blasr.sort.out.fixed.fa
## 
canu -p ${sample}_ps_1 -d ${sample}_ps_1 genomeSize=100k corOutCoverage=200 -pacbio-hifi ${sample}_ps_1.blasr.sort.out.fixed.fa.gz 2> ${sample}_ps_1.hifi.log
## 
ln -s ${sample}_ps_1/${sample}_ps_1.contigs.fasta ./
###############################
