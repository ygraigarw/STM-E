# STM-E
STM-E (space-time maxima and exposure) model

This repository accompanies the following article

Article

Statistical estimation of spatial wave extremes for tropical cyclones from small data samples: 
validation of the STM-E approach using long-term synthetic cyclone data for the Caribbean Sea
by
Ryota Wada, Jeremy Rohmer, Yann Krien and Philip Jonathan
in submission to NHESS.

Abstract

Occurrences of tropical cyclones at a location are rare, and for many locations, only short periods of observations or hindcasts are available. Hence, estimation of return values (corresponding to a period considerably longer than that for which data is available) for cyclone-induced significant wave height (SWH) from small samples is challenging. The STM-E (space-time maximum and exposure) model was developed to provide reduced bias in estimates of return values compared to competitor approaches in such situations, and realistic estimates of return value uncertainty. STM-E exploits data from a spatial neighbourhood satisfying certain conditions, rather than data from a single location, for return value estimation.

This article provides critical assessment of the STM-E model for tropical cyclones in the Caribbean Sea near Guadeloupe for which a large database of synthetic cyclones is available, corresponding to more that 3,000 years of observation. Results indicate that STM-E yields values for the 500-year return value of SWH and its variability, estimated from 200 years of cyclone data, consistent with direct empirical estimates from obtained by sampling 500 years of data from the full synthetic cyclone database. In general, STM-E also provides reduced bias and more realistic uncertainty estimates for return values relative to single location analysis.

Credits

The STM-E methodology was developed by Ryota Wada, Takuji Waseda and Philip Jonathan. The STM-E software was written by Ryota Wada.

Data

The data provided are synthetic cyclone-generated significant wave heights in space and time for the vicinity of Guadeloupe. Details are given in the article.

Code

The MATLAB software estimates generalised Pareto models for STM, and simulation under the fitted STM-E to estimate spatial return values over the neighbourhood of interest.

Warning

It is critical, when using STM-E, to establish that the underlying model assumptions are satisfied. These are described in the article.

Related published work

@ARTICLE{WadEA16,
author={R. Wada and T. Waseda and P. Jonathan},
title={Extreme value estimation using the likelihood-weighted method},
journal={Ocean Eng.},
year={2016},
volume = {124},
pages = {241-251}
}

@article{WadEA18,
	author={R. Wada and T. Waseda and P. Jonathan},
	title={{ A simple spatial model for extreme tropical cyclone seas}},
	journal={Ocean Eng.},
	volume={169},
	pages={315-325},
	year={2018},
}

@article{WadEA19,
	author={R. Wada and P. Jonathan and T. Waseda and S. Fan},
	title={{Estimating extreme waves in the Gulf of Mexico using a simple spatial extremes model}},
	journal={Proc. 38th Int. Conf. on Ocean, Offshore \& Arctic Engineering, Scotland},
	year={2019}
}
