#!/bin/bash
fileName=$1
popList=$2
##
pixy --stats fst dxy --vcf ${fileName}.snpMV.vcf --populations ${popList} --window_size 20000 --output_prefix ${fileName}.snpMVpop --bypass_invariant_check yes --n_cores 8

