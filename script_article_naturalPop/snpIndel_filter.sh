#!/bin/bash
REF=$1
fileName=$2
#################### select snp
java -Xmx500g -jar ~/software/gatk-4.4.0.0/gatk-package-4.4.0.0-local.jar SelectVariants -R ${REF} -V ${fileName}.gatk.combined.raw.vcf --select-type-to-include SNP -O ${fileName}.gatk.snp.raw.vcf
##
java -Xmx500g -jar ~/software/gatk-4.4.0.0/gatk-package-4.4.0.0-local.jar VariantFiltration -R ${REF} -V ${fileName}.gatk.snp.raw.vcf -O ${fileName}.snp.filterM.vcf --filter-expression "FS > 10.0 || MQ < 40.0 || ReadPosRankSum < -8.0 || SOR > 3.0 || MQRankSum < -12.5 || QD < 2.0" --filter-name "MsnpFilter" --cluster-size 3 --cluster-window-size 10
##
java -Xmx500g -jar ~/software/gatk-4.4.0.0/gatk-package-4.4.0.0-local.jar SelectVariants -R ${REF} -V ${fileName}.snp.filterM.vcf --exclude-filtered -O ${fileName}.snpM.vcf
####
vcftools --vcf ${fileName}.snpM.vcf --max-alleles 2 --min-alleles 2 --minDP 5 --recode --recode-INFO-all -c > ${fileName}.snpM1.vcf
mv ${fileName}.snpM1.vcf ${fileName}.snpM.vcf
vcftools --vcf ${fileName}.snpM.vcf --max-missing 1 --maf 0.05 --recode --recode-INFO-all -c > ${fileName}.snpMV.vcf
############# filter SNPs based on linkage disequilibrium
bcftools annotate --set-id +'%CHROM\_%POS\_%REF\_%FIRST_ALT' ${fileName}.snpMV.vcf -Oz -o ${fileName}.snpMVa.vcf.gz
##
plink --vcf ${fileName}.snpMVa.vcf.gz --allow-extra-chr --indep-pairwise 50 1 0.4 --const-fid --out ${fileName}.snpMVa
##
plink --allow-extra-chr --extract ${fileName}.snpMVa.prune.in --make-bed --out ${fileName}.snpMVad --recode vcf-iid --vcf ${fileName}.snpMVa.vcf.gz
#################### select indel
java -Xmx500g -jar ~/software/gatk-4.4.0.0/gatk-package-4.4.0.0-local.jar SelectVariants -R ${REF} -V ${fileName}.gatk.combined.raw.vcf --select-type-to-include INDEL -O ${fileName}.gatk.indel.raw.vcf
##
java -Xmx500g -jar ~/software/gatk-4.4.0.0/gatk-package-4.4.0.0-local.jar VariantFiltration -R ${REF} -V ${fileName}.gatk.indel.raw.vcf -O ${fileName}.indel.filterM.vcf --filter-expression "QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0" --filter-name "MsnpFilter"
##
java -Xmx500g -jar ~/software/gatk-4.4.0.0/gatk-package-4.4.0.0-local.jar SelectVariants -R ${REF} -V ${fileName}.indel.filterM.vcf --exclude-filtered -O ${fileName}.indelM.vcf
####
perl filterIndel.pl ${fileName}.indelM.vcf > ${fileName}.indelM1.vcf
vcftools --vcf ${fileName}.indelM1.vcf --max-alleles 2 --min-alleles 2 --minDP 5 --recode --recode-INFO-all -c > ${fileName}.indelM.vcf
##################### annotation
java -Xmx20g -jar ~/software/snpEff/snpEff.jar eff -c ~/software/snpEff/snpEff.config -v -ud 1000 AZ2B ${fileName}.snpM.vcf > ${fileName}.snpMeff.vcf
##
java -Xmx20g -jar ~/software/snpEff/snpEff.jar eff -c ~/software/snpEff/snpEff.config -v -ud 1000 AZ2B ${fileName}.indelM.vcf > ${fileName}.indelMeff.vcf
####

