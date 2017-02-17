### artists api
### base url path: baseurl +artist
### endpoints /search, /suggest, /{id}, /{id}/albums, /{id}/tracks, /{id}/similar
###
### artist name and id lookup
### /suggest
### will autocomplete for you
### parameters  (* means not required)
###  - api_key
###  - prefix
###  - genre  * (there is a list of possible values)
###  - decade * (list of possible values)
###  - limit * defaults to 20
###  - offset * to perform pagination (f.i. 10)

#' Lookup an artist
#'
#' If you don't know the exact name of an artist this allows you to search for
#' an artist with partial matching.
#'
#'
#' @param query use this if you know exactly what your query is, leave NULL if you
#'     have want to build up the query in steps
#' @param prefix part of the name
#' @param genre *optional a genre such as Blues, Rock etc.\link{https://developer.musicgraph.com/api-docs/v2/dictionary}
#' @param decade *optional a decade for instance
#' @param limit *optional max number of results defaults to 20
#' @param offset *optional pagination which page of the results do you want
#' @param api_key your developer API key see \link{getting_api_key}
#'
#' @return a response object.
#' @export
#' @family artists_endpoint
artist_lookup <- function( prefix, genre = NULL, decade = NULL,
                             limit = 20, offset = 10,query = NULL, api_key = NULL){
    if(!is.null(query)){
        querystring <- query
    }else{
        query <- list(prefix, genre, decade, limit, offset)
    }

    result <- api_get_call(path = "api/v2/artist/suggest",querylist = querystring,api_key = api_key)
    result
}

#' Search for an artist
#'
#' Search for a specific artist, the name needs to match exactly. But you can
#' also search for similar artists but the name needs to match exactly too.
#'
#' @param name *optional Return artists who match the name; exact, case insensitive 	"John+Lennon"
#' @param similar_to *optional Return artists who are similar to the given name; exact, case insensitive 	&similar_to=Pink+Floyd
#' @inheritParams artist_lookup
#' @return a response object.
#' @export
#' @family artists_endpoint
artist_search <- function(name = NULL, similar_to = NULL,
                          decade = NULL, genre = NULL,country = NULL,
                          gender = NULL, limit = NULL, offset = NULL,
                          query = NULL, api_key = NULL){

    if(!is.null(query)){
        querystring <- query
    }else{
        if(!is.null(genre)){genre <- validate_genre(genre)}
        if(!is.null(decade)){decade <- validate_decade(decade)}
        if(!is.null(gender)){gender <- validate_gender(gender)}
        querystring <- list(name=name, similar_to = similar_to, decade = decade,
                            genre = genre, country = country, gender = gender,
                            limit = limit,offset = offset)
        }
    result <- api_get_call(path = "api/v2/artist/search",
                           querystring, api_key = api_key)
    result
}

result_to_dataframe <- function(object){
    # checks
    parsed_result <- result_parser(object)
    parsed_result$data
}
#result_to_dataframe(response)


#' Artist Edges
#'
#' Wow such inspiring
#'
#' either ID or id/similar, id/albums id/tracks
#' possibly fields
#' @param artistID an artistID or artistID/similar, artistID/albums or artistID/tracks
#' @param fields *optional f.i. name, id, spotify_id, gender, popularity etc.
#' @inheritParams artist_lookup
#' @return a response object.
#' @export
#' @family artists_endpoint
artist_edges <- function(artistID, fields = NULL, api_key = NULL){
    artist_id <- validate_artistID(artistID)
    #fields needs to be like id,name
    path <- paste0("api/v2/artist/",artist_id)
    result <- api_get_call(path = path,
                           querylist = list(fields = fields), api_key = api_key)
    result
}
# response2 <- artist_edges("f76a1bfe-b93c-49d5-8fc2-a6cbaece3b7a")

#names(result_to_dataframe(response2))
#View(names(result_to_dataframe(response2)))
