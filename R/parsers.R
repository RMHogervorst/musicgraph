### parsers ####

#' Take the result from a query and move it to a data.frame
#'
#' This function takes an object and translates it into a data.frame.
#' @param object an object created with f.i. artist_lookup().
#' @family parsers
#' @export
#' @return a data.frame
result_to_dataframe <- function(object){
    # checks
    parsed_result <- result_parser(object)
    parsed_result$data
}

#result_to_dataframe(response)


result_parser <- function(object){
    result <- httr::content(object,encoding = "utf8",as = "text")
    parsed_result <- jsonlite::fromJSON(result)
    parsed_result
}
# TEST # response_code_translator(result_parser(response))

pagination_parser <- function(parsed_result){
    message(parsed_result$pagination$count, "results (page ",
            parsed_result$pagination$offset,") total results: ",
            parsed_result$pagination$total)
}
# TEST # pagination_parser(result_parser(response))

