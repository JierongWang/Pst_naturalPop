#!/bin/bash
REF=$1
fq1=$2
fq2=$3
sample=$4
################################ illumina
###
bwa mem -t 4 ${REF} ${fq1} ${fq2} | samtools view -@ 4 -Sbh | samtools sort -@ 4 > ${sample}.bam
### rmdup
samtools rmdup ${sample}.bam ${sample}.rd.bam
### add RG
samtools addreplacerg -r 'ID:'"${sample}"'' -r 'LB:'"${sample}"'' -r 'SM:'"${sample}"'' ${sample}.rd.bam -o ${sample}.bam
### index
samtools index ${sample}.bam
### qualimap
qualimap bamqc -bam ${sample}.bam -outdir ${sample}.bamqc_result -outformat HTML --java-mem-size=30G
