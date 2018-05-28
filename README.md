# hisss
A Snakemake workflow to download/align reads to targets and produce useful outputs.

## Installing

Getting it up and running is hopefully simple:

    git clone https://github.com/louiejtaylor/hisss
    cd hisss
    
We use conda to handle dependencies; you can install miniconda from [here](https://conda.io/miniconda.html). Make a new conda enviroment, then install dependencies from `requirements.txt` like so:
    
    conda create -n hisss
    source activate hisss
    conda install -c bioconda -c conda-forge --file requirements.txt 
    
Conda is great for managing dependencies and environments without requiring any admin privileges.

## Configuration

Hisss can run on both local and remote fastqs that are either paired or unpaired. The options in `config_template.yml` should be self-explanatory--just replace the placeholders with the relevant paths to your samples and alignment targets. 

The final step in setting up your config is to add your samples. We include two utilites to simplify adding samples to your config file depending on where your data are located: `list_SRA.py` and `list_samples.py`.

### SRA data

If you're using data from [the SRA](https://www.ncbi.nlm.nih.gov/sra), grabbing all the samples from a study is as simple as passing the project identifier (SRP#) to `list_SRA.py` like so:

    ./scripts/list_SRA.py SRP####### >> my_config.yml

This command will append nicely-formatted sample names to `my_config.yml`, along with some metadata of questionable utility. It also saves the full SRA metadata file as a .csv (so we recommend running this in your project directory). You also don't need to know whether the reads are paired- or single-end beforehand--as long as the information is in the SRA metadata it'll be included.

### Local data

If you're running on local samples, use `list_samples.py`. Let's say your fastqs are paired, located in `/project/fastq/`, and are named like `Sample_[sample_name]_R[pair].fastq`:

    ./scripts/list_samples.py -pattern "Sample_{sample}_R{rp}.fastq" /project/fastq/ >> my_config.yml

## Running

To run, simply execute the following in the hisss root dir. (The -p flag will print out the shell commands that will be executed)

    snakemake -p --configfile [path/to/my_config.yml] all

Some modifications that may be useful when running hiss include:

    snakemake -p --restart-times 3 --configfile [path/to/my_config.yml] all

This will retry a failed rule up to 3 times. This can be useful if there are failures in obtaining data from remote databases.

Additional information about snakemake options can be found [here](http://snakemake.readthedocs.io/en/stable/executable.html)

As an example, you can run the dummy data (which should complete very quickly):

    snakemake -p --configfile test_data/test_config.yml all
    
If you want to run the dummy data again after tinkering with the Snakefile or rules, you can clean up the test output like so:

    cd test_data
    bash clean_test.sh

When you're done, to leave the conda environment:

    source deactivate

## Current workflow 

![directed acyclic graph of workflow](assets/dag.png)

(generated by [graphviz](https://www.graphviz.org/doc/info/lang.html))

hisss = HIgh-throughput Shotgun Sequence Searcher
