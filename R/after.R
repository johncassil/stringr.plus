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
#' @export
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




#' Extract characters in a string which occur after a date
#'
#' Vectorised over `string` and `symbol`.
#'
#' @param string The string from which to extract.
#' @param symbol Character symbol seperating the components of the date.
#' @param format The format of the date in the string. Must be one of 'num' (year-month-day, month-day-year, or day-month-year with all numerical components), 'mdy-abbr' (month-day-year, abbreviated month name), 'dmy-abbr' (day-month-year, abbreviated month name), 'mdy-full' (month-day-year, full month name), or dmy-full' (day-month-year, full month name).
#' @param num_char The number of characters to return from after the pattern.  Leave NULL to return everything after the pattern.
#' @importFrom glue glue
#' @return The part of the string after the pattern.
#' @export
#' @examples
#' test_string <- 'url.com/string_before_pattern_2020_08_01/index.html'
#' str_extract_after_date(string = test_string, symbol = "_")
#' str_extract_after_date(string = test_string, symbol = "_", num_char = 6)
#'
#' test_string <- 'I-should-use-version-control-12-31-2020-final.csv'
#' str_extract_after_date(string = test_string, symbol = "-")
#'
#' test_string <- 'I-should-use-version-control-Dec-31-2020-final.csv'
#' str_extract_after_date(string = test_string, symbol = "-", format = "mdy-abbr")
#'
#' test_string <- 'I-should-use-version-control-December-31-2020-final.csv'
#' str_extract_after_date(string = test_string, symbol = "-", format = "mdy-full")
#'
#' test_string <- 'I-should-use-version-control-31-Dec-2020-final.csv'
#' str_extract_after_date(string = test_string, symbol = "-", format = "dmy-abbr")
#'
#' test_string <- 'I-should-use-version-control-31-December-2020-final.csv'
#' str_extract_after_date(string = test_string, symbol = "-", format = "dmy-full")
#'
str_extract_after_date <- function(string, symbol = "", format = "num", num_char = NULL){

    if (format == "num") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue("[:punct:][0-9{symbol}]{{8,}}"))
    }
    else if (format == "mdy-abbr") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue("([:alpha:]{{3}}{symbol}\\d{{1,2}}{symbol}\\d{{4}}[:punct:])"))
    }
    else if (format == "mdy-full") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue("([:alpha:]{{3,}}{symbol}\\d{{1,2}}{symbol}\\d{{4}}[:punct:])"))
    }
    else if (format == "dmy-abbr") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue("(\\d{{1,2}}{symbol}[:alpha:]{{3}}{symbol}\\d{{4}}[:punct:])"))
    }
    else if (format == "dmy-full") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue("(\\d{{1,2}}{symbol}[:alpha:]{{3,}}{symbol}\\d{{4}}[:punct:])"))
    }
    else {
        stop("category must be one of 'num', 'mdy-abbr', 'mdy-full', 'dmy-abbr', or 'dmy-full'")
    }

    end_of_pattern <- position_of_pattern[2]
    string_extract <- stringr::str_sub(string = string,
                                       start = (end_of_pattern + 1 ),
                                       end = if (is.null(num_char)) {nchar(string)} else {(end_of_pattern + num_char)})
    return(string_extract)
}
