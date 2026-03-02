#!/bin/bash
#$ -N variant_pipeline
#$ -j y
#$ -o /state/partition1/home2/eisha.sines/project/logs/pipeline.log
#$ -pe orte 8

source /share/apps/packages/anaconda3/bin/activate
conda activate /state/partition1/home2/eisha.sines/myenv

export JAVA_HOME=/usr/local/Wolfram/Mathematica/14.0/SystemFiles/Java/Linux-x86-64
export JAVA_CMD=/usr/local/Wolfram/Mathematica/14.0/SystemFiles/Java/Linux-x86-64/bin/java
export PATH=/usr/local/Wolfram/Mathematica/14.0/SystemFiles/Java/Linux-x86-64/bin:$PATH

cd /state/partition1/home2/eisha.sines/project

/state/partition1/home2/eisha.sines/myenv/bin/nextflow run scripts/pipeline.nf -resume
