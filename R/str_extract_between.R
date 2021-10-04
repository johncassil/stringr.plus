#' Extract characters in a string which occur after a specified pattern, and before a (different) specified pattern
#'
#' Vectorised over `string` and `pattern`.
#'
#' @param string The string from which to extract.
#' @param pattern1 Pattern to look for before the return content of a string.
#'
#' The default interpretation is a regular expression, as described in stringi::stringi-search-regex. Control options with regex().
#'
#' Match a fixed string (i.e. by comparing only bytes), using fixed(). This is fast, but approximate. Generally, for matching human text, you'll want coll() which respects character matching rules for the specified locale.
#'
#' Match character, word, line and sentence boundaries with boundary(). An empty pattern, "", is equivalent to boundary("character").
#' @param pattern2 Pattern to look for after the return content of a string.  See pattern1 for more details.
#' @param which_pattern1 If there are multiple patterns, what should the function return? "first" (the default) returns the first occurrence of pattern1
#' @param which_pattern2 If there are multiple patterns, what should the function return? "last" (the default) returns the last occurrence of pattern2
#' @return The part of the string after the first pattern and before the second pattern.
#' @export str_extract_between
#' @importFrom purrr map_int
#' @examples
#' test_string <- 'url.com/string_before_pattern_after-another_string_with_pattern2/'
#' str_extract_between(string = test_string, pattern1 = "_pattern_", pattern2 = "_pattern2")
#'
#'
str_extract_between <- function(string, pattern1, pattern2, which_pattern1 = "first", which_pattern2 = "last"){

    position_of_patterns1 <- stringr::str_locate_all(string=string, pattern = pattern1)
    position_of_patterns2 <- stringr::str_locate_all(string=string, pattern = pattern2)


    if(which_pattern1 == "first"){
        end_of_pattern1 <- purrr::map_int(position_of_patterns1, function(position){
            position[,'end'][1]
        })

    } else if (which_pattern1 == "last") {
        end_of_pattern1 <- purrr::map_int(position_of_patterns1, function(position){
            position[,'end'][length(position[,'end'])]
        })
    } else(
        stop("which_pattern1 must be one of c('first', 'last')")
    )


    if(which_pattern2 == "first"){
        start_of_pattern2 <- purrr::map_int(position_of_patterns2, function(position){
            position[,'start'][1]
        })
    } else if (which_pattern2 == "last") {
        start_of_pattern2 <- purrr::map_int(position_of_patterns2, function(position){
            position[,'start'][length(position[,'start'])]
        })
    } else(
        stop("which must be one of c('first', 'last')")
    )

    string_extract <- stringr::str_sub(string = string, start = (end_of_pattern1 + 1), end = (start_of_pattern2 - 1) )

    return(string_extract)
}
