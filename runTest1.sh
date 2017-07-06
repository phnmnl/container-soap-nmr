#!/bin/bash

mkdir -p /data
cd /data

# Fetch test data
apt-get -y install wget
wget 'https://raw.githubusercontent.com/phnmnl/container-nmrglue/develop/test_data_spectra.csv.gz'
wget 'https://raw.githubusercontent.com/phnmnl/container-nmrglue/develop/test_data_ppm.csv.gz'
wget 'https://raw.githubusercontent.com/phnmnl/container-nmrglue/develop/test_data_fid.csv.gz'
gunzip test_data_spectra.csv.gz
gunzip test_data_ppm.csv.gz
gunzip test_data_fid.csv.gz

# Fetch MTBLS1
#apt-get -y install unzip
#wget -O /data/MTBLS1.zip 'https://www.ebi.ac.uk/metabolights/MTBLS1/files/MTBLS1'
#unzip -d MTBLS1 MTBLS1.zip
#cd MTBLS1
#for i in *; do unzip $i; done
#rm -rf *.nmrML audit *.xlsx a_* i_* m* s_* *.zip __*
#cd ..

# Run test
wget -O /data/runTest2.r 'https://raw.githubusercontent.com/phnmnl/container-soap-nmr/develop/runTest2.r'
chmod 755 /data/runTest2.r
/data/runTest2.r

# Compare results
#if [[ "$(cat data_spectra.csv | head -n 1)" != "$(zcat test_data_spectra.csv.gz | head -n 1)" ]]; then
#	echo "Test failed! Results do not match test data."
#	exit 1
#else
#	echo "Test succeeded successfully."
#fi

