
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/musicgraph)](https://cran.r-project.org/package=musicgraph)[![Licence](https://img.shields.io/badge/licence-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)[![minimal R version](https://img.shields.io/badge/R%3E%3D-3.2-6666ff.svg)](https://cran.r-project.org/)[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)

<!-- README.md is generated from README.Rmd. Please edit that file -->
README
======

Basic overview of the project

The basic idea is to connect to the graphsearch api, not the other pieces. I will make some pieces that connect and keep as many things open. So that you can construct a query without much interference from R. My idea is to have a query field like "prefix=gree&genre=rock". The graphsearch consists of Artist, Album and Track.

\[\] build something that takes into acoount the rate limiting. \[x\] function that translates the result into a data.frame \[\] check limit when given between 1 and 100

You will usually have to do multiple calls. Searching for artist returns an ID and the ID can then be used on the artists metadata.

Installation
============

Install with `devtools::install_github("RMHogervorst/musicgraph")`

Basic use
=========

1.  register on musicgraph.com for a developer key.
2.  You have to either supply the key in every call, or save the api key in your .Renviron as MUSICGRAPH\_KEY = "yourkey" and restart your R-session.

3.  do calls with the package

Practical usecase
-----------------

I want to find out about the albums of the nu-metal / rock band Linkin Park.

### artist search

``` r
library(musicgraph)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
# do a search for the artist
kinda_like_linkinpark <- artist_lookup("Linkin")
# view the results
result_to_dataframe(kinda_like_linkinpark) %>% 
    select(id, name) %>% 
    head(3)
#> 14results (page 10) total results: 23
#>                                     id         name
#> 1 1fa27142-c125-4b3f-ad41-eeb586377486 Linkin Purpz
#> 2 cef94f14-4f1f-4a34-8e7b-5a0e1dd600c7  LINKIN PARK
#> 3 735dbcca-a5cd-4211-956c-a4004c456ad8 Linkin' Logs
```

This search (i'm only showing the top 3 results of the twenty) gives me the artistID: "cef94f14-4f1f-4a34-8e7b-5a0e1dd600c7". "e6207e83-a6b5-11e0-b446-00251188dd67" Then let's download all the tracks. The results are parsed per page, the limit parameter tells you how many results per page, and the offset which page you want to download.

``` r
LP_results1 <- artist_edges(artistID = "e6207e83-a6b5-11e0-b446-00251188dd67/tracks", limit = 100)
LP_results2 <- artist_edges(artistID = "e6207e83-a6b5-11e0-b446-00251188dd67/tracks", limit = 100, offset = 2)
result_to_dataframe(LP_results1) %>% dim()
#> 100results (page 1) total results: 3267
#> [1] 100  22
result_to_dataframe(LP_results1) %>% names()
#> 100results (page 1) total results: 3267
#>  [1] "track_artist_id"       "release_year"         
#>  [3] "title"                 "track_musicbrainz_id" 
#>  [5] "popularity"            "artist_name"          
#>  [7] "id"                    "track_index"          
#>  [9] "duration"              "album_title"          
#> [11] "track_album_id"        "original_release_year"
#> [13] "entity_type"           "isrc"                 
#> [15] "producer"              "writer"               
#> [17] "track_ref_id"          "main_genre"           
#> [19] "track_youtube_id"      "lyricist"             
#> [21] "composer"              "track_spotify_id"
```

The dataframes are thus 100 rows by 22 columns.

### track search

One of the tracks has the id : "794c1901-3da7-45d1-913b-da7da90d0387" It's guilty all the same. If we want to know more about that track we can explore the tracks endpoint.

``` r
song <- track_edges("794c1901-3da7-45d1-913b-da7da90d0387")
result_to_dataframe(song)
#> results (page ) total results:
#> $popularity
#> [1] 0
#> 
#> $track_artist_id
#> [1] "e6207e83-a6b5-11e0-b446-00251188dd67"
#> 
#> $release_year
#> [1] 2014
#> 
#> $producer
#>           name                                   id
#> 1 Mike Shinoda 832189a1-8d67-1844-d5d5-2a3b0a8da18c
#> 2  Brad Delson e40094f2-19f9-4bba-8291-6a30d2db657d
#> 
#> $title
#> [1] "Guilty All the Same"
#> 
#> $track_album_id
#> [1] "516c15c1-c80c-4456-abd5-1a271f170ab3"
#> 
#> $track_musicbrainz_id
#> [1] "a14bc9b1-f5c3-4074-942d-2f9a5ddd7477"
#> 
#> $writer
#>                     name                                   id
#> 1           Mike Shinoda 832189a1-8d67-1844-d5d5-2a3b0a8da18c
#> 2            Brad Delson e40094f2-19f9-4bba-8291-6a30d2db657d
#> 3     Chester Bennington 9b41591f-7eb9-21a1-6bd0-aa947b448af3
#> 4                  Rakim 3a799ddf-d5aa-206e-0e91-ccf175f39c33
#> 5 Robert Gregory Bourdon 67c1cb2f-6d42-47b4-af8e-bc0bac5184b2
#> 6          Chairman Hahn f709d8eb-a10f-ea44-596b-29fb629bb056
#> 7           Dave Farrell d4319e7a-769e-4451-b2f0-ced7032f8b82
#> 
#> $artist_name
#> [1] "Linkin Park"
#> 
#> $id
#> [1] "794c1901-3da7-45d1-913b-da7da90d0387"
#> 
#> $track_index
#> [1] "3"
#> 
#> $duration
#> [1] 355
#> 
#> $isrc
#> [1] "USWB11401337"
#> 
#> $album_title
#> [1] "The Hunting Party"
#> 
#> $original_release_year
#> [1] 2014
#> 
#> $entity_type
#> [1] "track"
```

### album search

In the artist search a album ID came up for the album 'the hunting party': "516c15c1-c80c-4456-abd5-1a271f170ab3"

``` r
album <- album_edges(albumID = "516c15c1-c80c-4456-abd5-1a271f170ab3/tracks")
album %>% 
    result_to_dataframe() %>% 
    select( title, release_year, popularity,  main_genre) %>% 
    head(4)
#> 20results (page 1) total results: 104
#>                      title release_year popularity main_genre
#> 1 Lies Greed Misery (live)         2014          0       <NA>
#> 2                Rebellion         2014          0       <NA>
#> 3                Rebellion         2014          0       <NA>
#> 4          All for Nothing         2014          0       <NA>
```

### known issues

-   when an artist has no tracks an empty list is returned.
-   I have not made a message that returns how many results there are
-   tracks result is not useful. it returns a nested list.
