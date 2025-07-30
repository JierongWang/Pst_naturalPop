#!/bin/bash
fq1=$1
fq2=$2
sample=$3
################################
mash screen AZ2A.msh <(zcat ${fq1} ${fq2}) > ${sample}_AZ2A.tab
##
mash screen AZ2B.msh <(zcat ${fq1} ${fq2}) > ${sample}_AZ2B.tab
##
mash screen Pst104A.msh <(zcat ${fq1} ${fq2}) > ${sample}_Pst104A.tab
##
mash screen Pst104B.msh <(zcat ${fq1} ${fq2}) > ${sample}_Pst104B.tab
##
mash screen Pst134alt.msh <(zcat ${fq1} ${fq2}) > ${sample}_Pst134alt.tab
##
mash screen Pst134pri.msh <(zcat ${fq1} ${fq2}) > ${sample}_Pst134pri.tab

