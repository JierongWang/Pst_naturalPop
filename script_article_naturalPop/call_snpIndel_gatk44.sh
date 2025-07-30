#!/bin/bash
REF=$1
sample=$2
bamdir=$3
########## gatk
java -Xmx500g -jar ~/software/gatk-4.4.0.0/gatk-package-4.4.0.0-local.jar HaplotypeCaller -R ${REF} -I ${bamdir}${sample}.bam -ERC GVCF -O ${sample}.gatk.g.vcf.gz
