% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/str_extract_before.R
\name{str_extract_before}
\alias{str_extract_before}
\title{Extract characters in a string which occur before a specified pattern}
\usage{
str_extract_before(string, pattern, which = "first", num_char = NULL)
}
\arguments{
\item{string}{The string from which to extract.}

\item{pattern}{Pattern to look for.

The default interpretation is a regular expression, as described in stringi::stringi-search-regex. Control options with regex().

Match a fixed string (i.e. by comparing only bytes), using fixed(). This is fast, but approximate. Generally, for matching human text, you'll want coll() which respects character matching rules for the specified locale.

Match character, word, line and sentence boundaries with boundary(). An empty pattern, "", is equivalent to boundary("character").}

\item{which}{If there are multiple patterns, should the function bring back the "first" or "last" occurrence?}

\item{num_char}{The number of characters to return from before the pattern.  Leave NULL to return everything before the pattern.}
}
\value{
The part of the string before the pattern.
}
\description{
Vectorised over `string` and `pattern`.
}
\examples{
test_string <- 'url.com/string_before_pattern_after-another_string_with_pattern2/'
str_extract_before(string = test_string, pattern = '_pattern_')
str_extract_before(string = test_string, pattern = '_pattern_', num_char = 6)
str_extract_before(string = test_string, pattern = '_', which = "last")

}
