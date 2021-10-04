#' Extract characters in a string which occur after a specified pattern
#'
#'Vectorised over `string` and `pattern`.
#'
#' @param string The string from which to extract.
#' @param pattern Pattern to look for.
#'
#' The default interpretation is a regular expression, as described in stringi::stringi-search-regex. Control options with regex().
#'
#' Match a fixed string (i.e. by comparing only bytes), using fixed(). This is fast, but approximate. Generally, for matching human text, you'll want coll() which respects character matching rules for the specified locale.
#'
#' Match character, word, line and sentence boundaries with boundary(). An empty pattern, "", is equivalent to boundary("character").
#' @param num_char The number of characters to return from after the pattern.  Leave NULL to return everything after the pattern.
#' @param which If there are multiple patterns, should the function bring back the "first" or "last" occurrence?
#' @return The part of the string after the pattern.
#' @export str_extract_after
#' @importFrom purrr map_int
#' @examples
#' test_string <- 'url.com/string_before_pattern_after-another_string_with_pattern2/'
#' str_extract_after(string = test_string, pattern = '_pattern_')
#' str_extract_after(string = test_string, pattern = '_pattern_', num_char = 5)
#' str_extract_after(string = test_string, pattern = '_', which = "last")
#'
str_extract_after <- function(string, pattern, which = "first", num_char = NULL){
    position_of_patterns <- stringr::str_locate_all(string=string, pattern = pattern)

    if(which == "first"){
        end_of_pattern <- purrr::map_int(position_of_patterns, function(position){
            position[,'end'][1]
        })
    } else if (which == "last") {
        end_of_pattern <- purrr::map_int(position_of_patterns, function(position){
            position[,'end'][length(position[,'end'])]
        })
    } else(
        stop("which must be one of c('first', 'last')")
    )
    string_extract <- stringr::str_sub(string = string,
                                       start = (end_of_pattern + 1),
                                       end = if (is.null(num_char)) {nchar(string)} else {(end_of_pattern + num_char)})
    return(string_extract)
}
