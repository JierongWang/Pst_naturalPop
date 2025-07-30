#!/bin/bash
sample=$1
fq1=$2
fq2=$3
################################ illumina
~/conda_envs/smash/bin/sourmash sketch dna -p k=21,scaled=10 <(zcat ${fq1} ${fq2}) -o ${sample}.sig
####
~/conda_envs/smash/bin/sourmash search Pst_bE1-HD2.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bE1-HD2.search
~/conda_envs/smash/bin/sourmash search Pst_bE4-HD2.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bE4-HD2.search
~/conda_envs/smash/bin/sourmash search Pst_bE6-HD2.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bE6-HD2.search
~/conda_envs/smash/bin/sourmash search Pst_bE7-HD2.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bE7-HD2.search
~/conda_envs/smash/bin/sourmash search Pst_bE8-HD2.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bE8-HD2.search
~/conda_envs/smash/bin/sourmash search Pst_bE9-HD2.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bE9-HD2.search
~/conda_envs/smash/bin/sourmash search Pst_bW1-HD1.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bW1-HD1.search
~/conda_envs/smash/bin/sourmash search Pst_bW4-HD1.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bW4-HD1.search
~/conda_envs/smash/bin/sourmash search Pst_bW6-HD1.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bW6-HD1.search
~/conda_envs/smash/bin/sourmash search Pst_bW7-HD1.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bW7-HD1.search
~/conda_envs/smash/bin/sourmash search Pst_bW8-HD1.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bW8-HD1.search
~/conda_envs/smash/bin/sourmash search Pst_bW9-HD1.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bW9-HD1.search
~/conda_envs/smash/bin/sourmash search Pst_bE1-1HD2.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bE1-1HD2.search
~/conda_envs/smash/bin/sourmash search Pst_bW1-1HD1.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bW1-1HD1.search
~/conda_envs/smash/bin/sourmash search Pst_bE2-HD2.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bE2-HD2.search
~/conda_envs/smash/bin/sourmash search Pst_bE3-HD2.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bE3-HD2.search
~/conda_envs/smash/bin/sourmash search Pst_bE5-HD2.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bE5-HD2.search
~/conda_envs/smash/bin/sourmash search Pst_bW2-HD1.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bW2-HD1.search
~/conda_envs/smash/bin/sourmash search Pst_bW3-HD1.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bW3-HD1.search
~/conda_envs/smash/bin/sourmash search Pst_bW5-HD1.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.bW5-HD1.search
~/conda_envs/smash/bin/sourmash search Pst_STE3.cds.sig ${sample}.sig --containment --threshold 0 -o ${sample}.STE3.search
