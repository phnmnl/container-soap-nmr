# SOAP-NMR

## Short description

An R package for 1H-NMR data pre-treatment.

## Description

This package provides R functions for common pre-treatment steps that are applied on 1H-NMR data. It also provides the function ReadFids to read the FID directly from the Bruker output.

## Key features

- FirstOrderPhaseCorrection: Correct for the first order phase correction.
- SolventSuppression: Remove solvent signal from the FID.
- Apodization: Increase the Signal-to-Noise ratio of the FID.
- FourierTransform: Transform the FID into a spectrum.
- ZeroOrderPhaseCorrection: Correct for the zero order phase correction.
- BaselineCorrection: Remove the spectral baseline.
- NegativeValuesZeroing: Set negatives values to 0.
- PPMConversion: Convert the frequency scale (Hertz -> ppm).
- Warping: Warp the samples according to a reference spectrum.
- WindowSelection: Select the informative part of the spectrum.
- Bucketing: Proceed to data reduction.
- RegionRemoval: Set a desired region to 0.
- ZoneAggregation: Aggregate a region to a single peak.
- Normalization: Normalize the spectra.

## Instrument Data Types

- NMR / 1D NMR
- NMR / 2D NMR / 2D TOCSY
- NMR / 1H NMR

## Tool Authors 

- Benoît Legat 

## Container Contributors

- [Kristian Peters](https://github.com/korseby) (IPB-Halle)

## Website

- https://github.com/ManonMartin/SOAP-NMR

## Git Repository

- https://github.com/phnmnl/container-soap-nmr.git

## Installation 

For local individual installation:

```bash
docker pull docker-registry.phenomenal-h2020.eu/phnmnl/soap-nmr
```

## Usage Instructions

For direct docker usage:

```bash
docker run docker-registry.phenomenal-h2020.eu/phnmnl/soap-nmr ...
```

## Publications

- Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences actuarielles, Université catholique de Louvain, Belgium).
