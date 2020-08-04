import yaml

# ############ SETUP ##############################
configfile: "configs/config_devel.yaml"
# configfile: "configs/config.json"
workdir: config['workdir']

# include helper functions
include: "includes/io.snk"
include: "includes/utils.snk


# retrieve the file_df with all the file paths from the samplesheet
sample_df, short_sample_df = get_files(config['inputdirs'], config['samples']['samplesheet'])
chrom_list = get_chrom_list(config)

# ############ INCLUDES ##############################  
include: "includes/splitBAM.snk"
include: "includes/EB.snk"
# convenience variables
ref_gen = full_path('genome')

# ############## MASTER RULE ##############################################

rule all:
    input:
        expand("EB/{samples}.csv", samples=sample_df.index)
