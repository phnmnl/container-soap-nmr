#!/usr/bin/env Rscript
# Script for pre-processing and analysis of MTBLS1

# Setup R error handling to go to stderr
options(show.error.messages=F, error=function(){cat(geterrmessage(),file=stderr());q("no",1,F)})

# Set proper locale
loc <- Sys.setlocale("LC_MESSAGES", "en_US.UTF-8")

# Import library
#library(getopt)
options(stringAsfactors = FALSE, useFancyQuotes = FALSE)

# Take in trailing command line arguments
args <- commandArgs(trailingOnly = TRUE)


# Created by Daniel Canueto
library(SOAP)
library(data.table)
library(speaq)

# dataset of Bruker-processed spectra read with nmrglue (CSV format)
dataset_path=args[[1]]
initial_dataset=fread(dataset_path,header=F,sep=',')

# ppm axis for each bin of the dataset read with nmrglue (CSV format)
ppm_path=args[[2]]
ppm=fread(ppm_path,header=F,sep=',')

# fid info read with nmrglue (CSV format)
fid_info_path=args[[3]]
fid_info=as.matrix(fread(fid_info_path,header=F,sep=','))
colnames(fid_info)=c("TD",      "BYTORDA" ,"DIGMOD",  "DECIM",   "DSPFVS" , "SW_h" ,   "SW"  ,    "O1" ,     "DT"   ) 

# Adaptation of dataset to SOAP structure
initial_dataset=t(apply(initial_dataset,1,as.complex))
attributes(initial_dataset)$dimnames[[2]]=as.vector(t(ppm))

# Referencing to TSP
pre_processed_dataset=InternalReferencing(initial_dataset,fid_info)
# Selection of edges of the window of spectrum with valuable information
pre_processed_dataset=WindowSelection ( pre_processed_dataset,from.ws = 0.2, to.ws = 9.3)
# Removal of regions of spectrum with not useful information that can worsen later pre-procesing steps
fromto=list(Glucose=c(3.19,3.99),Glucose2=c(5.21,5.27),Water =c(4.5, 5.1), Urea=c(5.5,6.1))
pre_processed_dataset=RegionRemoval(pre_processed_dataset,typeofspectra = "manual",fromto.rr=fromto)
# PQN noormalitzationof spectra. SOAP does not allow selection of spectra as reference. Workflow4metabolomics allows it.
pre_processed_dataset<-Normalization(pre_processed_dataset,type.norm='pqn')
# Setting of dataset structure for signal alignment with 'speaq' package
aligned_dataset=t(apply(pre_processed_dataset,1,as.numeric))
# Signal alignment with 'speaq' package 
peakList <- detectSpecPeaks(aligned_dataset,
  nDivRange = c(128),
  scales = seq(1, 16, 2),
  baselineThresh = quantile(aligned_dataset,0.60,na.rm=T),
  SNR.Th = -1,
  verbose=FALSE
);
resFindRef<- findRef(peakList);
refInd <- resFindRef$refInd;
maxShift = round(0.025/mean(diff(as.numeric(colnames(pre_processed_dataset)))));
aligned_dataset <- dohCluster(aligned_dataset,
  peakList = peakList,
  refInd = refInd,
  maxShift = maxShift,
  acceptLostPeak = TRUE, verbose=FALSE);

# Bucketing of spectra to reduce dimensionality and reduce misalignments of signals
colnames(aligned_dataset)=colnames(pre_processed_dataset)
aligned_dataset = Bucketing(aligned_dataset,width=T,m=0.01)
# Variable to analyze in PLS: 48 first samples have diabetes, the others not. When you decide how the metadata is treated, this can change
#variable=rep(c(1,2),times=c(48,84))

# Export data set used for OPLS
aligned_dataset <- rbind(aligned_dataset, rep(c(1,2),times=c(48,84)))
write.csv(aligned_dataset, file=args[[4]], row.names=FALSE)

