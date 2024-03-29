% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/str_extract_before_date.R
\name{str_extract_before_date}
\alias{str_extract_before_date}
\title{Extract characters in a string which occur before a date}
\usage{
str_extract_before_date(string, date_sep = "", format = "num", num_char = NULL)
}
\arguments{
\item{string}{The string from which to extract.}

\item{date_sep}{Character symbol seperating the components of the date.}

\item{format}{The format of the date in the string. Must be one of 'num' (year-month-day, month-day-year, or day-month-year with all numerical components), 'mdy-abbr' (month-day-year, abbreviated month name), 'dmy-abbr' (day-month-year, abbreviated month name), 'mdy-full' (month-day-year, full month name), or dmy-full' (day-month-year, full month name).}

\item{num_char}{The number of characters to return from before the pattern.  Leave NULL to return everything before the pattern.}
}
\value{
The part of the string before the pattern.
}
\description{
Vectorised over `string` and `date_sep`.
}
\examples{
test_string <- 'url.com/string_before_pattern_2020_08_01/index.html'
str_extract_before_date(string = test_string, date_sep = "_")
str_extract_before_date(string = test_string, date_sep = "_", num_char = 21)

test_string <- 'really-long-file-name-12-31-2020.csv'
str_extract_before_date(string = test_string, date_sep = "-")

test_string <- 'really-long-file-name-Mar-18-2018.csv'
str_extract_before_date(string = test_string, date_sep = "-", format = "mdy-abbr")

test_string <- 'really-long-file-name-March-18-2018.csv'
str_extract_before_date(string = test_string, date_sep = "-", format = "mdy-full")

test_string <- 'really-long-file-name-28-Mar-2018.csv'
str_extract_before_date(string = test_string, date_sep = "-", format = "dmy-abbr")

test_string <- 'really-long-file-name-28-March-2018.csv'
str_extract_before_date(string = test_string, date_sep = "-", format = "dmy-full")

}
