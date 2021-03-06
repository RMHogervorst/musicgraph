% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/artists_api.R
\name{artist_lookup}
\alias{artist_lookup}
\title{Lookup an artist}
\usage{
artist_lookup(prefix, genre = NULL, decade = NULL, limit = 20,
  offset = 10, query = NULL, api_key = NULL)
}
\arguments{
\item{prefix}{part of the name}

\item{genre}{*optional a genre such as Blues, Rock etc.}

\item{decade}{*optional a decade for instance}

\item{limit}{*optional max number of results defaults to 20}

\item{offset}{*optional pagination which page of the results do you want}

\item{query}{use this if you know exactly what your query is, leave NULL if you
have want to build up the query in steps}

\item{api_key}{your developer API key see \link{getting_api_key}}
}
\value{
a response object.
}
\description{
If you don't know the exact name of an artist this allows you to search for
an artist with partial matching.
\url{https://developer.musicgraph.com/api-docs/v2/dictionary}
}
\seealso{
Other artists_endpoint: \code{\link{artist_edges}},
  \code{\link{artist_search}}
}
