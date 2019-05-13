## test favicons
[![MIT version](https://img.shields.io/badge/license-MIT-blue.svg)](https://www.mit.org/package/favicons)
[![rstudio](https://travis-ci.org/itgalaxy/favicons.svg?branch=master)](https://travis-ci.org/itgalaxy/favicons)
[![shiny](https://coveralls.io/repos/github/itgalaxy/favicons/badge.svg?branch=master)](https://coveralls.io/github/itgalaxy/favicons?branch=master)
[![Jekyll](https://david-dm.org/itgalaxy/favicons/status.svg)](https://david-dm.org/itgalaxy/favicons)


The predictive analysis is carried out based on the attributes of the patients. The data
originally consists of 76 attributes(including the target class label) but we are given the
subset of 14 attributes from where 3 attributes are removed. The 3 attributes slope, ca and thal
are removed due to big proportions of missing values(33.6%, 66.4% and 52.8%). The
medical reason for removing ca is that the number of major vessels (0-3) colored by
flourosopy will not change because of the presence or absence of heart disease. After
removing the 3 attributes, the missing values from other 11 attributes are changed to “NA”
and later replaced with a value by applying mean of existing values in each column. The
target class label consists of a value ranges from 0 to 4 indicating the intensity of heart
disease. It refers to the presence of heart disease i.e., 0 means no heart disease and 1 to 4
means presence of heart disease (higher the value, higher the certainty).
