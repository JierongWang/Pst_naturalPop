#!/bin/bash
fileName=$1
python ~/software/vcf2phylip-v2.0/vcf2phylip.py -i ${fileName}.snpMV.vcf -p -n
