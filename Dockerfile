FROM conda/miniconda3
LABEL authors="Francesco Lescai and Thomas Bleazard" \
      description="Docker image containing singularity instances to convert docker images"

# Install procps so that Nextflow can poll CPU usage
RUN apt-get update && apt-get install -y procps && apt-get clean -y

# Install the conda environment
COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a

# Add conda installation dir to PATH (instead of doing 'conda activate')
ENV PATH /usr/local/envs/singularityenv/bin:$PATH

# install samtools separately because it introduces complexities with conda
RUN apt-get install -y wget
RUN apt-get install -y gcc \
make \
libbz2-dev \
zlib1g-dev \
libncurses5-dev \
libncursesw5-dev \
liblzma-dev


# Dump the details of the installed packages to a file for posterity
RUN conda env export --name singularityenv > singularityenv.yml
