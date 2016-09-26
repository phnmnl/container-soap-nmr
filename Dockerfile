FROM docker-registry.phenomenal-h2020.eu/phnmnl/ipo

MAINTAINER Kristian Peters <kpeters@ipb-halle.de>

LABEL Description="An R package for 1H-NMR data pre-treatment."

# Install dependencies
RUN apt-get -y update
RUN apt-get -y install git

# Install R dependencies
RUN R -e "install.packages(\"SOAP\")"
RUN R -e "install.packages(\"ptw\", repos=\"https://mirrors.ebi.ac.uk/CRAN/\")"

# Install SOAP-NMR
WORKDIR /usr/src
RUN git clone https://github.com/ManonMartin/SOAP-NMR
RUN R -e "install.packages(\"/usr/src/SOAP-NMR\", repos=NULL, type=\"source\")"
RUN R -e "require(SOAP)"

# Define Entry point script
#ENTRYPOINT ["Rscript"]

