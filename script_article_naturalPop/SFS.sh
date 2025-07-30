#!/bin/bash
fileName=$1
##
bcftools view ${fileName}.snpMV.vcf -Oz -o ${fileName}.snpMV.vcf.gz
##
bcftools index ${fileName}.snpMV.vcf.gz
##
Pop-Con -i ${fileName}.snpMV.vcf.gz -o ${fileName}.snpMVsfs

