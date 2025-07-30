#!/bin/bash
link=$1
fileName=$2
#################### nj tree
perl VCF_fasta.pl ${link} ${fileName}.snpMVad.vcf ${fileName}.snpMVad.vcf.fasta
##
~/software/rapidNJ/bin/rapidnj ${fileName}.snpMVad.vcf.fasta -b 1000 -c 4 -x ${fileName}.snpMVad.vcf.nwk
sed -i $'s/\'//g' ${fileName}.snpMVad.vcf.nwk
#################### maximum likelihood phylogenetic tree
perl VCF_Phylip.pl ${link} ${fileName}.snpMVad.vcf ${fileName}.snpMVad.vcf.phy
##
~/software/RAxML-master/raxmlHPC-PTHREADS -f a -x 12345 -p 12345 -# 10 -k -s ${fileName}.snpMVad.vcf.phy -m GTRGAMMA -n ${fileName}.snpMVad

