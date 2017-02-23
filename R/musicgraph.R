#' Connect to the musicgraph api to collect music information.
#'
#' Search the database and return things back to a data.frame.
#' I have implemented the three main api endpoints: artists, albums and tracks.
#' For now you have to do 2 steps: use one of the functions starting with
#' artist_... album_ ... or track_... to download the data to your R session.
#' Step 2 is parsing the results with result_to_dataframe().
#'
#' \link{getting_api_key}
#' @family general_documentation
#' @aliases musicgraph musicgraph-package
#' @docType package
#' @name musicgraph
NULL
