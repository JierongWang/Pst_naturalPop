#!/bin/bash
fileName=$1
##
perl varType.pl ${fileName}.snpMV.vcf | perl sampleHetHomMisNum.pl - > ${fileName}.snpMV.het

