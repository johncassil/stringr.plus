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
#' @return The part of the string before the pattern.
#' @examples
#' test_string <- 'url.com/string_before_pattern_after-another_string_with_pattern2/'
#' str_extract_before(string = test_string, pattern = '_pattern_')
#' str_extract_before(string = test_string, pattern = '_pattern_', num_char = 6)
#'
#'
str_extract_before <- function(string, pattern, num_char = NULL){
    position_of_pattern <- stringr::str_locate(string=string, pattern = pattern)
    start_of_pattern <- position_of_pattern[1]
    string_extract <- stringr::str_sub(string = string,
                                       start = if (is.null(num_char)) {0} else {(start_of_pattern - num_char)},
                                       end = (start_of_pattern - 1) )
    return(string_extract)
}



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
#' @return The part of the string after the pattern.
#' @examples
#' test_string <- 'url.com/string_before_pattern_after-another_string_with_pattern2/'
#' str_extract_after(string = test_string, pattern = '_pattern_')
#' str_extract_after(string = test_string, pattern = '_pattern_', num_char = 5)
#'
#'
str_extract_after <- function(string, pattern, num_char = NULL){
    position_of_pattern <- stringr::str_locate(string=string, pattern = pattern)
    end_of_pattern <- position_of_pattern[2]
    string_extract <- stringr::str_sub(string = string,
                                       start = (end_of_pattern + 1 ),
                                       end = if (is.null(num_char)) {nchar(string)} else {(end_of_pattern + num_char)})
    return(string_extract)
}



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
#' @export
str_detect_multiple_and <- function(string, patterns){
    str_detect_multiple(string, patterns, method = "and")
}



#' @rdname str_detect_multiple
#' @examples str_detect_multiple_or(test_string, c('hadley', 'csv'))
#' @export
str_detect_multiple_or <- function(string, patterns){
    str_detect_multiple(string, patterns, method = "or")
}
