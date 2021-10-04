#' Extract characters in a string which occur before a specified pattern
#'
#' Vectorised over `string` and `pattern`.
#'
#' @param string The string from which to extract.
#' @param pattern Pattern to look for.
#'
#' The default interpretation is a regular expression, as described in stringi::stringi-search-regex. Control options with regex().
#'
#' Match a fixed string (i.e. by comparing only bytes), using fixed(). This is fast, but approximate. Generally, for matching human text, you'll want coll() which respects character matching rules for the specified locale.
#'
#' Match character, word, line and sentence boundaries with boundary(). An empty pattern, "", is equivalent to boundary("character").
#' @param num_char The number of characters to return from before the pattern.  Leave NULL to return everything before the pattern.
#' @param which If there are multiple patterns, should the function bring back the "first" or "last" occurrence?
#' @return The part of the string before the pattern.
#' @export str_extract_before
#' @importFrom purrr map_int
#' @examples
#' test_string <- 'url.com/string_before_pattern_after-another_string_with_pattern2/'
#' str_extract_before(string = test_string, pattern = '_pattern_')
#' str_extract_before(string = test_string, pattern = '_pattern_', num_char = 6)
#' str_extract_before(string = test_string, pattern = '_', which = "last")
#'
str_extract_before <- function(string, pattern, which = "first", num_char = NULL){

    position_of_patterns <- stringr::str_locate_all(string=string, pattern = pattern)

    if(which == "first"){
        start_of_pattern <- purrr::map_int(position_of_patterns, function(position){
            position[,'start'][1]
        })
    } else if (which == "last") {
        start_of_pattern <- purrr::map_int(position_of_patterns, function(position){
            position[,'start'][length(position[,'start'])]
        })
    } else(
        stop("which must be one of c('first', 'last')")
    )

    string_extract <- stringr::str_sub(string = string,
                                       start = if (is.null(num_char)) {0} else {(start_of_pattern - num_char)},
                                       end = (start_of_pattern - 1) )
    return(string_extract)
}
