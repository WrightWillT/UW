# README

***
## Bias in Data
Name: Will Wright
Date: 2019-10-17
***

## Goal
The goal of this project is to explore how bias can enter data science projects. For this investigation, we look at data regarding the quality of English Wikipedia articles about politicians in a country (created by the ORES machine learning system) by country along with country population data to get a sense for how the coverage and quality of articles is different across the globe.

## Data sources used
To create the tables in the 'results' folder, data was pulled from three data sources:
1. (Politicians by Country from English-language Wikipedia)[https://figshare.com/articles/Untitled_Item/5513449]
2. Population by Country came from within (UW's Canvas system)[https://canvas.uw.edu/courses/1319253/files] (student and course resources) and this is based on data from (The World Population Datasheet](https://www.prb.org/international/indicator/population/table/)
3. Article quality ratings came from (ORES)[https://www.mediawiki.org/wiki/ORES]

## Resources Used
This analysis was prepared using Python 3.7 running in a Jupyter Notebook environment.
Documentation for Python can be found here: https://docs.python.org/3.7/
Documentation for Jupyter Notebook can be found here: http://jupyter-notebook.readthedocs.io/en/latest/

The following Python packages were used and their documentation can be found at the accompanying links:
(Pandas)[https://pandas.pydata.org/]
(Numpy)[https://numpy.org/]
(httr)[https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html]
(magrittr)[https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html]

## Files Created
The R script and Jupyter Notebook create 1 clean .csv file, 6 .csv results files, and 5 .csv raw files.

## License
This assignment code is released under an open MIT license.
Code fore the ORES API came from (this Github repo)[https://github.com/Ironholds/data-512-a2] with an open MIT license.
The country population data looks like it needs a (Publication Permisison Request)[https://www.prb.org/publication-permission-request/], but since it's being used for this class assignment, it's probably a good assumption that the professor cleared it, but this isn't guaranteed.
The (Politicians by Country data)[https://figshare.com/articles/Untitled_Item/5513449] has a CC-BY license
The (ORES API)[https://www.mediawiki.org/wiki/ORES] has a CC-SA license
