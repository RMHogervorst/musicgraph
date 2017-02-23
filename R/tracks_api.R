#
#  http://api.musicgraph.com/api/v2/tracks/
#
#  /search
#  /suggest
#  /{id}

#' If you don't know the exact name of an track this allows you to search for
#' it with partial matching.
#'
#'
#'
#' @param query use this if you know exactly what your query is, leave NULL if you
#'     have want to build up the query in steps
#' @param prefix part of the name
#' @param genre *optional a genre such as Blues, Rock etc.\url{https://developer.musicgraph.com/api-docs/v2/dictionary}
#' @param decade *optional a decade for instance
#' @param limit *optional max number of results defaults to 20
#' @param offset *optional pagination which page of the results do you want
#' @param api_key your developer API key see \url{getting_api_key}
#'
#' @return a response object.
#' @export
#' @family tracks_endpoint
track_lookup <- function( prefix= NULL, genre = NULL, decade = NULL,
                          limit = 20, offset = 10,query = NULL, api_key = NULL){
    if(!is.null(query)){
        querystring <- query
    }else{
        if(is.null(prefix))stop("a prefix is not optional, f.i.: black holes")
        querystring <- list(prefix = prefix, genre = genre, decade = decade,
                            limit = limit, offset =offset)
    }

    result <- api_get_call(path = "api/v2/track/suggest",
                           querylist = querystring,api_key = api_key)
    result
}
# result <- track_lookup(prefix = "black holes")


#' Search for a specific track, the name needs to match exactly. But you can
#' also search for similar albums but the name needs to match exactly too.
#'
#' @param artist_name *optional Return tracks who match the name; exact, case insensitive 	"White+album"
#' @param title *optional title of the track
#' @param isrc *optional Return tracks that match a given isrc; exact, case sensitive, f.i. "GBBKS0700574"
#' @param lyrics_phrase *optional Return tracks with lyrics that have an exact match of the given string; case insensitive
#' @param lyrics_keywords *optional Return tracks with lyrics that have keywords that are "most representative" (i.e. in the song's "bag of words"); case insensitive
#' @param lyrics_lang *optional Return tracks with lyrics of a specified language;
#' @param genre *optional a genre such as Blues, Rock etc.\url{https://developer.musicgraph.com/api-docs/v2/dictionary}
#' @param decade *optional a decade for instance
#' @param limit *optional max number of results defaults to 20
#' @param offset *optional pagination which page of the results do you want
#' @param query use this if you know exactly what your query is, leave NULL if you
#'     have want to build up the query in steps
#' @param api_key your developer API key see \url{getting_api_key}
#' @return a response object.
#' @export
#' @family tracks_endpoint
track_search <- function(title = NULL,
                         artist_name = NULL,
                         decade = NULL,
                         genre = NULL,
                         isrc = NULL,
                         lyrics_phrase = NULL,
                         lyrics_keywords = NULL,
                         lyrics_lang = NULL,
                         limit = NULL,
                         offset = NULL,
                         query = NULL,
                         api_key = NULL){

    # do something with the language
    if(!is.null(query)){
        querystring <- query
    }else{
        if(!is.null(genre)){genre <- validate_genre(genre)}
        if(!is.null(decade)){decade <- validate_decade(decade)}
        querystring <- list(title = title, artist_name = artist_name,
                            decade = decade,genre = genre, isrc = isrc,
                            lyrics_phrase = lyrics_phrase,
                            lyrics_keywords= lyrics_keywords,
                            lyrics_lang = lyrics_lang,
                            limit = limit,offset = offset)
    }
    result <- api_get_call(path = "api/v2/track/search",
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
#' @param trackID a trackID
#' @param fields *optional f.i. name, id, spotify_id, gender, popularity etc.
#' @param api_key your developer API key see \url{getting_api_key}
#' @return a response object.
#' @export
#' @family tracks_endpoint
#'
#'
track_edges <- function(trackID, fields = NULL, api_key = NULL){
    trackID <- validate_artistID(trackID)
    #fields needs to be like id,name
    path <- paste0("api/v2/track/",albumID)
    result <- api_get_call(path = path,
                           querylist = list(fields = fields), api_key = api_key)
    result
}

