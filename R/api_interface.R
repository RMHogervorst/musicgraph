# API interface


# basic api key handling ###########

check_env_for_api_key <- function(){
    Sys.getenv("MUSICGRAPH_KEY", unset = NA)
}

#' Find or define API key for musicgraph.com
#'
#' This function is not for direct use.
#'
#' @param key "quoted" key or by default searches in .Renviron en Sys.setenv for
#'     a key
#'
#' @return key
api_key <- function(key = NULL){
    if(is.null(key)){
        key <- find_musicgraph_token()
    }#else{
    #  message("Setting key for this session")
    #  Sys.setenv(MUSICGRAPH_KEY = key)
    #}
    key
}

# This function tries to find the
# api key necessary for this api to work.
#
#
find_musicgraph_token <- function(){
    # if the key is already loaded, there is no need for other actions.
    if(is.na(Sys.getenv("MUSICGRAPH_KEY"))){
        location <- normalizePath("~/.Renviron")
        # if the file exists read the key.
        if(file.exists(location)){
            token <- Sys.getenv("MUSICGRAPH_KEY")
            if(token == ""){
                key <- set_musicgraph_key()
            }
        }else{ # if there is no file, offer to create file.
            message("you have no .Renviron file")
            choice <- readline("Do you  want to create that file? (y/n) ")
            if(choice== "y"){
                writeLines("MUSICGRAPH_KEY = ",file.path(normalizePath("~/"), ".Rtest") )
                utils::file.edit(file.path(normalizePath("~/"), ".Renviron"))
            }else if(choice == "n"){
                message("You will have this message every time")
                key <- set_musicgraph_key()
            }
        }
    }else{
        key <- Sys.getenv("MUSICGRAPH_KEY")
    }
    key
}


# key writing function
# don't export, internal function.
# returns error or key (also sets it in local env)
set_musicgraph_key <- function(){
    message("No musicgraph key found")
    key <- readline("Please enter your musicgraph api key: ")
    key <- ifelse(grepl("\\D",key),-1,key)
    if(is.na(key)|key== ""){stop("no key given")
    }else{
        message("writing key, \nif you don't want to repeat this process every time \n use the function add_key_to_renviron()")
        Sys.setenv(MUSICGRAPH_KEY = key)
    }
    key
}

#### other stuff to connect to the api


api_get_call <- function(path, querylist, api_key= NULL){
    if(is.null(api_key)){
        api_key <- find_musicgraph_token()
    }

    if(is.null(querylist)){stop("the call needs at least a query")}
    # add api_key to query.
    query <- c(api_key = api_key ,querylist)
    object <- httr::GET(url =  httr::modify_url(url = "http://api.musicgraph.com/",
                                          path = path,
                                          query = query),
                        httr::user_agent("https://github.com/RMHogervorst/musicgraph"))
    object
}


## search validation
#


#' Internal function to validate genre
#'
#' It changes the string to titlecase if not already so
#' and checks it against the list found on the website.
#' The function fails / returns an error (I hope informative enough) when it
#' can't find a match.
#' I made this list for v2 of the API on 2017-02-16. It might
#' change. I hope not.
#' \url{https://developer.musicgraph.com/api-docs/v2/dictionary}
#' @param genrestring the genre string people give in searches
#' @return a string formatted in the correct way that matches the genrelist.
#' @family validators
validate_genre <- function(genrestring){
    # remove whitespace at end and front
    genrestring <- tolower(genrestring)
    # endresult: genre
    # check genre against:
    genrevector <- c("alternative/indie",
      "blues",
      "cast recordings/cabaret",
      "christian/gospel",
      "children's",
      "classical/opera",
      "comedy/spoken word",
      "country",
      "electronica/dance",
      "folk",
      "instrumental",
      "jazz",
      "latin",
      "new age",
      "pop",
      "rap/hip hop",
      "reggae/ska",
      "rock",
      "seasonal",
      "soul/r&b",
      "soundtracks",
      "vocals",
      "world")
    if(!genrestring %in% genrevector){
        stop("Cannot find: ", genrestring, " in genre list. Check developer.musicgraph.com/api-docs/v2/dictionary for more info.")
    }else
        genrestring
}


#' Internal function to check for decade
#'
#' This function matches decade against a list of possible decades.
#' It will throw an error when it doesn't match
#' @param decadestring a decade such as 1980s
#' @return correctly formatted decade that matches the list on musicgraph.com
#' @family validators
validate_decade <- function(decadestring){
    # accept 1890-2010
    validyears <- paste0(seq(1890, 2010, by = 10),"s")
    # possibly accept but warn and transform to values
    # add s to end.

    dec_pattern <- "[1-2]{1}[890]{1}[0-9]{2}"
    if(grepl(dec_pattern, x = decadestring)){
        return <- stringr::str_match(decadestring, dec_pattern)# return only the numbers and add an s
        output <- paste0(return,"s")
    }else{
        stop("Could not find a decade, try things like: 1980s, 2010s etc.")
    }
    if(!output %in% validyears){stop(decadestring, " is not a valid decade")}
    output
}


#' Internal function to check for gender
#'
#' This function checks if the gender is male or female.
#' It will throw an error when it doesn't match
#' @param gender male or female
#' @family validators
validate_gender <- function(gender){
    if(!is.null(gender)){
        gender <- tolower(gender)
        if(!gender %in% c("male", "female"))stop("Unfortunately you have to choose between Male or Female")
    }
    gender
}


response_code_translator <- function(parsed_result){
    status_code <- parsed_result$status$code
    # message_content <- switch(as.character(status_code),
    #                         "-1" = "Unknown Error",
    #                         "0" = "Success",
    #                         "1" = "Missing/unvalid api_key",
    #                         "2" = "This API key is not allowed to call this method",
    #                         "3" = "Rate Limit Exceeded",
    #                         "4" = "Not Supported",
    #                         "5" = "Invalid Search Operation",
    #                         "6" = "Invalid Edge Name",
    #                         "7" = "Invalid MusicGraph ID",
    #                         "8" = "Invalid type"
    #                         )
    message_content <- parsed_result$status$message
    output <- paste(status_code, ",", message_content)
    output
}


#' Check artistID against pattern
#'
#' When it doesn't match the pattern a warning will be given but the function
#' does continue.
#' @param artistID an artistID
#' @family validators
validate_artistID <- function(artistID){
    pattern <- "[a-zA-Z0-9]{8}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{12}"
    if(!grepl(pattern,artistID))warning("It seems the artistID doesn't match the pattern 8char-4char-4char-4char-12char")
    artistID
}
