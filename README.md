# Variant Calling Pipeline - HG002 PacBio

## Overview
This pipeline performs variant calling on PacBio HG002 data using Nextflow on HPC (NUST RCMS HPC - afrit cluster).

## Pipeline Steps
1. Read alignment using BWA
2. BAM sorting and indexing using Samtools
3. Variant calling using Samtools mpileup + BCFtools
4. Benchmarking against GIAB truth set

## Requirements
- BWA 0.7.13
- Samtools 1.3
- BCFtools 1.3
- Nextflow 24.10.6
- Java 17
- Python 3.8

## Project Structure
project/
├── data/          # Input FASTQ and reference genome
├── results/       # Output BAM and VCF files
├── scripts/       # Pipeline and job scripts
├── logs/          # Log files
└── benchmark/     # GIAB benchmarking results

## How To Run

### Step 1 - Setup environment
source /share/apps/packages/anaconda3/bin/activate
conda activate /state/partition1/home2/eisha.sines/myenv
export JAVA_HOME=/usr/local/Wolfram/Mathematica/14.0/SystemFiles/Java/Linux-x86-64
export PATH=/usr/local/Wolfram/Mathematica/14.0/SystemFiles/Java/Linux-x86-64/bin:$PATH

### Step 2 - Run pipeline
nextflow run scripts/pipeline.nf -resume

### Step 3 - Submit via SGE
qsub scripts/run_pipeline.sh

## Results
- Aligned BAM: results/aligned.sorted.bam
- Variants VCF: results/variants.vcf

## Reference Genome
GRCh38 human reference genome

## Data
PacBio HG002 HiFi reads from GIAB

## Author
Eisha Sines - NUST RCMS
