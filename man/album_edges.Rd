% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/album_api.R
\name{album_edges}
\alias{album_edges}
\title{Album Edges}
\usage{
album_edges(albumID, fields = NULL, api_key = NULL)
}
\arguments{
\item{albumID}{an albumID or albumID/artists or albumID/tracks}

\item{fields}{*optional f.i. name, id, spotify_id, gender, popularity etc.}

\item{api_key}{your developer API key see \link{getting_api_key}}
}
\value{
a response object.
}
\description{
Search for more information about a album Either general information or
artists of the album or tracks.
}
\details{
possibly fields
}
\seealso{
Other album_endpoint: \code{\link{album_lookup}},
  \code{\link{album_search}}
}
