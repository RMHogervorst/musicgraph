
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

basic information
=================

basic call : <http://api.musicgraph.com/>

Response Codes

-1 - Unknown Error

0 - Success

1 - Missing/ Invalid API Key

2 - This API key is not allowed to call this method

3 - Rate Limit Exceeded

4 - Not Supported

5 - Invalid Search Operation

6 - Invalid Edge Name

7 - Invalid MusicGraph ID

8 - Invalid Type

200 - Success

304 - Not Modified

400 - Bad Request - the request is not valid

403 - Forbidden - you are not authorized to access that resource

404 - Incorrect path; Not Found - The requested resource could not be found

429 - Too Many Requests - You have exceeded the rate limit associated with your API key

5XX - Server Error

example:

`GET /api/v2/artist/ee2564c7-a6b5-11e0-b446-00251188dd67?api_key=c8303e90962e3a5ebd5a1f260a69b138&fields=id,name,albums.limit(10).fields(id,title)`

Nested requests
===============

`GET api.musicgraph.com/api/v2/{node-id}?fields={first-level}.fields({second-level})` Here's an example query that will retrieve the ID and title of up to ten albums by Adele. `GET /api/v2/artist/ee2564c7-a6b5-11e0-b446-00251188dd67?api_key=c8303e90962e3a5ebd5a1f260a69b138&fields=id,name,albums.limit(10).fields(id,title)`

If you want to pull in Adele's albums and tracks, you can just append to the url.

`GET /api/v2/artist/ee2564c7-a6b5-11e0-b446-00251188dd67?api_key=c8303e90962e3a5ebd5a1f260a69b138&fields=id,name,albums.limit(10).fields(id,title),tracks.limit(5).fields(id,title)`
