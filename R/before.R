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
#' @export str_extract_before
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

#' Extract characters in a string which occur before a date
#'
#' Vectorised over `string` and `date_sep`.
#'
#' @param string The string from which to extract.
#' @param date_sep Character symbol seperating the components of the date.
#' @param format The format of the date in the string. Must be one of 'num' (year-month-day, month-day-year, or day-month-year with all numerical components), 'mdy-abbr' (month-day-year, abbreviated month name), 'dmy-abbr' (day-month-year, abbreviated month name), 'mdy-full' (month-day-year, full month name), or dmy-full' (day-month-year, full month name).
#' @param num_char The number of characters to return from before the pattern.  Leave NULL to return everything before the pattern.
#' @importFrom glue glue
#' @return The part of the string before the pattern.
#' @export str_extract_before_date
#' @examples
#' test_string <- 'url.com/string_before_pattern_2020_08_01/index.html'
#' str_extract_before_date(string = test_string, date_sep = "_")
#' str_extract_before_date(string = test_string, date_sep = "_", num_char = 21)
#'
#' test_string <- 'really-long-file-name-12-31-2020.csv'
#' str_extract_before_date(string = test_string, date_sep = "-")
#'
#' test_string <- 'really-long-file-name-Mar-18-2018.csv'
#' str_extract_before_date(string = test_string, date_sep = "-", format = "mdy-abbr")
#'
#' test_string <- 'really-long-file-name-March-18-2018.csv'
#' str_extract_before_date(string = test_string, date_sep = "-", format = "mdy-full")
#'
#' test_string <- 'really-long-file-name-28-Mar-2018.csv'
#' str_extract_before_date(string = test_string, date_sep = "-", format = "dmy-abbr")
#'
#' test_string <- 'really-long-file-name-28-March-2018.csv'
#' str_extract_before_date(string = test_string, date_sep = "-", format = "dmy-full")
#'
str_extract_before_date <- function(string, date_sep = "", format = "num", num_char = NULL){

    if (format == "num") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue("[:punct:][0-9{date_sep}]{{8,}}"))
    }
    else if (format == "mdy-abbr") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue("([:punct:][:alpha:]{{3}}{date_sep}\\d{{1,2}}{date_sep}\\d{{4}})"))
    }
    else if (format == "mdy-full") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue("([:punct:][:alpha:]{{3,}}{date_sep}\\d{{1,2}}{date_sep}\\d{{4}})"))
    }
    else if (format == "dmy-abbr") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue("([:punct:]\\d{{1,2}}{date_sep}[:alpha:]{{3}}{date_sep}\\d{{4}})"))
    }
    else if (format == "dmy-full") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue("([:punct:]\\d{{1,2}}{date_sep}[:alpha:]{{3,}}{date_sep}\\d{{4}})"))
    }
    else {
        stop("category must be one of 'num', 'mdy-abbr', 'mdy-full', 'dmy-abbr', or 'dmy-full'")
    }

    start_of_pattern <- position_of_pattern[1]
    string_extract <- stringr::str_sub(string = string,
                                       start = if (is.null(num_char)) {0} else {(start_of_pattern - num_char)},
                                       end = (start_of_pattern - 1) )
    return(string_extract)
}
