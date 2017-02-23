
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/musicgraph)](https://cran.r-project.org/package=musicgraph)[![Licence](https://img.shields.io/badge/licence-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)[![minimal R version](https://img.shields.io/badge/R%3E%3D-3.2-6666ff.svg)](https://cran.r-project.org/)[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)

<!-- README.md is generated from README.Rmd. Please edit that file -->
README
======

Basic overview of the project

\[x\] First I build the scaffolding for api calls I will use the same thing I did for cortical.io, read .Renviron for a key or ask for a key.

The basic idea is to connect to the graphsearch api, not the other pieces. I will make some pieces that connect and keep as many things open. So that you can construct a query without much interference from R. My idea is to have a query field like "prefix=gree&genre=rock" that you can fill yourself. I might add functions on top that would fill in some of those fields for you.

Every endpoint has the option to fill in parameters or use `query` to type it yourself.

The graphsearch consists of Artist, Album and Track.

\[\] build something that takes into acoount the rate limiting. \[x\] function that translates the result into a data.frame \[\] check limit when given between 1 and 100

You will usually have to do multiple calls. Searching for artist returns an ID and the ID can then be used on the artists metadata.
