<!-- Guidance:
Logo: The logo needs have the text "Logo" inside the square bracket place holder to be recognized at the App Library.
Tool name: First single hashtag (#) will be taken as tool name.
Version: Should always go after the first hastag and before the second hastag. The line needs to respond to the regexp "^Version: (.+)" being the first group the actual version.

Fields: for the App Library, the following fields will be parsed:

# Name of the tool
Version: z.x-whatever
## Short description
## Description
## Key features
## Publications
## Screenshots
## Tool Authors 
- Author 1 and affiliation
- [Author 2](link_to_author_2) and affiliation
## Container Contributors
- Contributor 1
- [Contributor 2](link_to_contributior_2) and affiliation
## Website
## Usage Instructions

Free text with triple tick code blocks, comprising docker, ipython and galaxy usage

## Installation 

They all have to be at the second hashtag level

For screenshots, you should use the following scheme:

![screenshot](screenshots/s1.gif)
![screenshot](screenshots/s2.gif)

-->

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

## Tool Authors 
- Benoît Legat 

## Container Contributors
- [Kristian Peters](https://github.com/korseby) (IPB-Halle)

## Website
- https://github.com/ManonMartin/SOAP-NMR

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
