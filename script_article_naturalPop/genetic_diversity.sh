#!/bin/bash
fileName=$1
python ~/software/vcf2phylip-v2.0/vcf2phylip.py -i ${fileName}.snpMV.vcf
##
~/software/variscan-1.0.2/variscan ${fileName}.snpMV.min4.phy variscan_phy.conf > ${fileName}.snpMV.variscan
