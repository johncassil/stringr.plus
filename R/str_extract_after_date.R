#' Extract characters in a string which occur after a date
#'
#' Vectorised over `string` and `date_sep`.
#'
#' @param string The string from which to extract.
#' @param date_sep Character symbol seperating the components of the date.
#' @param format The format of the date in the string. Must be one of 'num' (year-month-day, month-day-year, or day-month-year with all numerical components), 'mdy-abbr' (month-day-year, abbreviated month name), 'dmy-abbr' (day-month-year, abbreviated month name), 'mdy-full' (month-day-year, full month name), or dmy-full' (day-month-year, full month name).
#' @param num_char The number of characters to return from after the pattern.  Leave NULL to return everything after the pattern.
#' @importFrom glue glue
#' @return The part of the string after the pattern.
#' @export str_extract_after_date
#' @examples
#' test_string <- 'url.com/string_before_pattern_2020_08_01/index.html'
#' str_extract_after_date(string = test_string, date_sep = "_")
#' str_extract_after_date(string = test_string, date_sep = "_", num_char = 6)
#'
#' test_string <- 'I-should-use-version-control-12-31-2020-final.csv'
#' str_extract_after_date(string = test_string, date_sep = "-")
#'
#' test_string <- 'I-should-use-version-control-Dec-31-2020-final.csv'
#' str_extract_after_date(string = test_string, date_sep = "-", format = "mdy-abbr")
#'
#' test_string <- 'I-should-use-version-control-December-31-2020-final.csv'
#' str_extract_after_date(string = test_string, date_sep = "-", format = "mdy-full")
#'
#' test_string <- 'I-should-use-version-control-31-Dec-2020-final.csv'
#' str_extract_after_date(string = test_string, date_sep = "-", format = "dmy-abbr")
#'
#' test_string <- 'I-should-use-version-control-31-December-2020-final.csv'
#' str_extract_after_date(string = test_string, date_sep = "-", format = "dmy-full")
#'
str_extract_after_date <- function(string, date_sep = "", format = "num", num_char = NULL){

    if (format == "num") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue::glue("[:punct:][0-9{date_sep}]{{8,}}"))
    }
    else if (format == "mdy-abbr") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue::glue("([:alpha:]{{3}}{date_sep}\\d{{1,2}}{date_sep}\\d{{4}}[:punct:])"))
    }
    else if (format == "mdy-full") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue::glue("([:alpha:]{{3,}}{date_sep}\\d{{1,2}}{date_sep}\\d{{4}}[:punct:])"))
    }
    else if (format == "dmy-abbr") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue::glue("(\\d{{1,2}}{date_sep}[:alpha:]{{3}}{date_sep}\\d{{4}}[:punct:])"))
    }
    else if (format == "dmy-full") {
        position_of_pattern <- stringr::str_locate(string=string, pattern = glue::glue("(\\d{{1,2}}{date_sep}[:alpha:]{{3,}}{date_sep}\\d{{4}}[:punct:])"))
    }
    else {
        stop("category must be one of 'num', 'mdy-abbr', 'mdy-full', 'dmy-abbr', or 'dmy-full'")
    }

    end_of_pattern <- position_of_pattern[,"end"]
    string_extract <- stringr::str_sub(string = string,
                                       start = (end_of_pattern + 1 ),
                                       end = if (is.null(num_char)) {nchar(string)} else {(end_of_pattern + num_char)})
    return(string_extract)
}
