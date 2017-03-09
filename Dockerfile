FROM container-registry.phenomenal-h2020.eu/phnmnl/rbase

LABEL software=soap-nmr
LABEL software.version=1.0
LABEL version=0.2

LABEL Description="An R package for 1H-NMR data pre-treatment."

MAINTAINER PhenoMeNal-H2020 Project <phenomenal-h2020-users@googlegroups.com>



# Install packages for compilation
RUN apt-get -y update
RUN apt-get -y --no-install-recommends install git make gcc gfortran g++ libnetcdf-dev libblas-dev liblapack-dev

# Install R dependencies
RUN R -e 'source("https://bioconductor.org/biocLite.R"); biocLite("MassSpecWavelet")'
RUN R -e 'install.packages(c("ptw","speaq","ggplot2","gridExtra","matrixStats","reshape2","data.table"), repos="https://mirrors.ebi.ac.uk/CRAN/")'
RUN R -e 'source("https://bioconductor.org/biocLite.R"); biocLite("ropls")'

# Install SOAP-NMR
WORKDIR /usr/src
RUN git clone https://github.com/ManonMartin/SOAP-NMR
RUN R -e 'install.packages("/usr/src/SOAP-NMR", repos=NULL, type="source")'
RUN R -e 'require(SOAP)'

# De-install not needed packages
RUN apt-get -y --purge --auto-remove remove make gcc gfortran g++

# Clean-up
RUN apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

# Add R scripts
ADD galaxy/*.r /usr/local/bin/

# Define Entry point script
RUN mkdir /data
WORKDIR /data
#ENTRYPOINT ["Rscript"]

