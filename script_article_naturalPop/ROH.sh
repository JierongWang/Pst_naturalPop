#!/bin/bash
fileName=$1
##
plink --vcf ${fileName}.snpMV.vcf --maf 0.05 --allow-extra-chr --homozyg --homozyg-density 50 --homozyg-gap 10 --homozyg-kb 40 --homozyg-snp 50 --homozyg-window-het 1 --homozyg-window-missing 5 --homozyg-window-snp 50 --out ${fileName}.snpMV

