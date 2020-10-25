#' Detect the presence or absence of a patterns in a string.
#'
#' Vectorised over `string` and `pattern`. Equivalent to str_detect, but capable of multiple patterns.
#'
#' @param string Input vector. Either a character vector, or something coercible to one.
#' @param patterns Patterns to look for as a character vector (e.g. c("foo", "bar) )
#'
#' The default interpretation of each pattern in the character vector is a regular expression, as described in stringi::stringi-search-regex. Control options with regex().
#'
#' Match a fixed string (i.e. by comparing only bytes), using fixed(). This is fast, but approximate. Generally, for matching human text, you'll want coll() which respects character matching rules for the specified locale.
#'
#' Match character, word, line and sentence boundaries with boundary(). An empty pattern, "", is equivalent to boundary("character").
#' @param method Match method: "and" or "or". "and" will only match strings where all patterns in the character vector are found in the string. "or" will match strings where any of the patterns in the character vector are found in the string.

#' @return The part of the string after the first pattern and before the second pattern.
#' @export str_detect_multiple
#' @examples
#' test_string <- 'complicated_file_name-32.csv'
#' str_detect_multiple(test_string, c('hadley', 'csv'), method = "and")
#' str_detect_multiple(test_string, c('hadley', 'csv'), method = "or")
#'
#'
str_detect_multiple <- function(string, patterns, method){
    if(method == 'and'){
        all(stringr::str_detect(string, patterns))
    } else if (method == 'or'){
        any(stringr::str_detect(string, patterns))
    } else {stop("argument 'method' must be either 'or' or 'and'")}
}



#' @rdname str_detect_multiple
#' @examples str_detect_multiple_and(test_string, c('hadley', 'csv'))
#' @export str_detect_multiple_and
str_detect_multiple_and <- function(string, patterns){
    str_detect_multiple(string, patterns, method = "and")
}



#' @rdname str_detect_multiple
#' @examples str_detect_multiple_or(test_string, c('hadley', 'csv'))
#' @export str_detect_multiple_or
str_detect_multiple_or <- function(string, patterns){
    str_detect_multiple(string, patterns, method = "or")
}
