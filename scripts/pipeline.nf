#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.fastq = "/state/partition1/home2/eisha.sines/project/data/test.fastq"
params.ref   = "/state/partition1/home2/eisha.sines/project/data/test_ref.fa"
params.outdir = "/state/partition1/home2/eisha.sines/project/results"

process ALIGN {
    publishDir "${params.outdir}", mode: 'copy'

    output:
    path "aligned.sorted.bam"
    path "aligned.sorted.bam.bai"

    script:
    """
    /share/apps/packages/bwa/bwa-0.7.13/bwa mem ${params.ref} ${params.fastq} | \
    /share/apps/packages/samtools/samtools-1.3/samtools sort -o aligned.sorted.bam
    /share/apps/packages/samtools/samtools-1.3/samtools index aligned.sorted.bam
    """
}

process VARIANT_CALL {
    publishDir "${params.outdir}", mode: 'copy'

    input:
    path bam
    path bai

    output:
    path "variants.vcf"

    script:
    """
    /share/apps/packages/samtools/samtools-1.3/samtools mpileup -uf ${params.ref} ${bam} | \
    /share/apps/packages/bcftools/bcftools-1.3/bcftools call -mv -Ov -o variants.vcf
    """
}

workflow {
    (bam, bai) = ALIGN()
    VARIANT_CALL(bam, bai)
}
