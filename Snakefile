# Snakemake workflow ot align reads to one or more 
# genomic sequences and produce useful outputs including 
# coverage maps and summary tables.

# See the README.md for more information.

# Authors: Louis Taylor and Arwa Abbas

include: "rules/align.rules"

rule all:
	input:
		str(config["dirs"]["root"]+"/"+config["dirs"]["output"]+"/alignments/summary.txt")

#rule grab_data:
#	input:
#		#list of URL? data location?
#	output:
#		#temp(data files formatted properly?)
#	shell:
#		"""
#		wget {url}/{input}
#		tar -xzvf {input}
#		"""

#rule build_indexes:
#	input:
#		#see config["dirs"]["targets"]... right now given as a directory TODO: figure out how to split thse out (and do the same with the fastqs) 
#	output:
#		str(config["dirs"]["targets"]+'/'+ {target})
#	shell:
#		"bowtie2-build -f {input} {output}"

#rule process_alignment:
#	input:
#		expand(config["dirs"]["root"]+"/"+config["dirs"]["output"]+"/alignments/{sample}.sam",sample=config["samples"])
#	output:
#		# what do we want as the output of this rule? Whatever necessary for coverage calculation
#	shell:
#		# samtools view
#		# samtools sort, overwrite old .bam
#		# samtools index
#		# samtools idxstats

#rule calculate_coverage:
#	input:
#		rules.process_alignment.output
#	output:
#		str(config["dirs"]["root"]+"/"+config["dirs"]["output"]+"/summary/coverage/{sample}_coverage.csv")
#	shell:
#		#however we want to do this (Arwa script?)

#rule summarize_coverage:
#	input:
#		rules.calculate_coverage.output
#	output:
#		str(config["dirs"]["root"]+"/"+config["dirs"]["output"]+"/summary/all_coverage.csv")
#	shell:
#		"cat {input} | tail -n 1 >> {output}"

#rule coverage_maps:
#	input: 
#		#custom function returning only samples passing our threshold (set thresholds in config file!)
#	output:
#		str(config["dirs"]["root"]+"/"+config["dirs"]["output"]+"/summary/{target}/{sample}_coverage.pdf")
#	shell:
#		#figure out coverage vis


