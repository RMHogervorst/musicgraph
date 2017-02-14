# API interface


# basic api key handling ###########

check_env_for_api_key <- function(){
    Sys.getenv("MUSICGRAPH_KEY", unset = NA)
}

#' Find or define API key for musicgraph.com
#'
#' This function is not for direct use.
#'
#' @param key "quoted" key or by default searches in .Renviron en Sys.setenv
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
                file.edit(file.path(normalizePath("~/"), ".Renviron"))
            }else if(choice == "n"){
                message("You will have this message every time")
                key <- set_musigraph_key()
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
list()
ua = httr::user_agent("https://github.com/RMHogervorst/")

