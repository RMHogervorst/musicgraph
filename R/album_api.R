#
#  http://api.musicgraph.com/api/v2/album/
#
#  /search
#  /suggest
#  /{id}
#  /{id}/tracks
#  /{id}/artists
#' If you don't know the exact name of an album this allows you to search for
#' an artist with partial matching.
#'
#' It will also return the album id.
#' See for genres and decade valid options:
#' \url{https://developer.musicgraph.com/api-docs/v2/dictionary}
#'
#' @param query use this if you know exactly what your query is, leave NULL if you
#'     have want to build up the query in steps
#' @param prefix part of the name
#' @param genre *optional a genre such as Blues, Rock etc.
#' @param decade *optional a decade for instance
#' @param limit *optional max number of results defaults to 20
#' @param offset *optional pagination which page of the results do you want
#' @param api_key your developer API key see \link{getting_api_key}
#'
#' @return a response object.
#' @export
#' @family album_endpoint
album_lookup <- function( prefix= NULL, genre = NULL, decade = NULL,
                           limit = 20, offset = 10,query = NULL, api_key = NULL){
    if(!is.null(query)){
        querystring <- query
    }else{
        if(is.null(prefix))stop("a prefix is not optional, f.i.: black holes")
        querystring <- list(prefix = prefix, genre = genre, decade = decade,
                            limit = limit, offset =offset)
    }

    result <- api_get_call(path = "api/v2/album/suggest",
                           querylist = querystring,api_key = api_key)
    result
}
# result <- album_lookup(prefix = "black holes")

#' Search for a specific album
#'
#' Search for a specific album, the name needs to match exactly. But you can
#' also search for similar albums but the name needs to match exactly too.
#' See for genres and decade valid options:
#' \url{https://developer.musicgraph.com/api-docs/v2/dictionary}
#' @param name *optional Return albums who match the name; exact, case insensitive 	"White+album"
#' @param similar_to *optional Return albums who are similar to the given name; exact, case insensitive similar_to="The wall"
#' @param country see the dictionary
#' @param top_rated only the top results
#' @param gender male or female
#' @inheritParams album_lookup
#' @return a response object.
#' @export
#' @family album_endpoint
album_search <- function(name = NULL, similar_to = NULL,
                          decade = NULL, genre = NULL,country = NULL,
                          gender = NULL, limit = NULL, offset = NULL,
                          query = NULL, top_rated = NULL, api_key = NULL){

    if(!is.null(query)){
        querystring <- query
    }else{
        if(!is.null(genre)){genre <- validate_genre(genre)}
        if(!is.null(decade)){decade <- validate_decade(decade)}
        if(!is.null(gender)){gender <- validate_gender(gender)}
        querystring <- list(name=name, similar_to = similar_to, decade = decade,
                            genre = genre, country = country, gender = gender,
                            limit = limit,offset = offset, top_rated = top_rated)
    }
    result <- api_get_call(path = "api/v2/album/search",
                           querystring, api_key = api_key)
    result
}
# result <- album_search(similar_to = "the wall")
# result_to_dataframe(result)

#' Album Edges
#'
#' Search for more information about a album Either general information or
#' artists of the album or tracks.
#'
#'
#' possibly fields
#' @param albumID an albumID or albumID/artists or albumID/tracks
#' @param fields *optional f.i. name, id, spotify_id, gender, popularity etc.
#' @inheritParams artist_lookup
#' @return a response object.
#' @export
#' @family album_endpoint
#'
#'
album_edges <- function(albumID, fields = NULL, api_key = NULL){
    albumID <- validate_artistID(albumID)
    #fields needs to be like id,name
    path <- paste0("api/v2/album/",albumID)
    result <- api_get_call(path = path,
                           querylist = list(fields = fields), api_key = api_key)
    result
}

