#' Extract characters in a string which occur after a specified pattern, and before a (different) specified pattern
#'
#' Vectorised over `string` and `pattern`.
#'
#' @param string The string from which to extract.
#' @param pattern1 Pattern to look for before the return content of a string
#' @param pattern2 Pattern to look for after the return content of a string
#'
#' The default interpretation is a regular expression, as described in stringi::stringi-search-regex. Control options with regex().
#'
#' Match a fixed string (i.e. by comparing only bytes), using fixed(). This is fast, but approximate. Generally, for matching human text, you'll want coll() which respects character matching rules for the specified locale.
#'
#' Match character, word, line and sentence boundaries with boundary(). An empty pattern, "", is equivalent to boundary("character").
#' @return The part of the string after the first pattern and before the second pattern.
#' @export
#' @examples
#' test_string <- 'url.com/string_before_pattern_after-another_string_with_pattern2/'
#' str_extract_between(string = test_string, pattern1 = "_pattern_", pattern2 = "_pattern2")
#'
#'
str_extract_between <- function(string, pattern1, pattern2){
    position_of_pattern1 <- stringr::str_locate(string=string, pattern = pattern1)
    end_of_pattern1 <- position_of_pattern1[2]
    position_of_pattern2 <- stringr::str_locate(string=string, pattern = pattern2)
    start_of_pattern2 <- position_of_pattern2[1]
    string_extract <- stringr::str_sub(string = string, start = (end_of_pattern1 + 1), end = (start_of_pattern2 - 1) )
    return(string_extract)
}
