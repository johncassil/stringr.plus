
<!-- README.md is generated from README.Rmd. Please edit that file -->

# stringr.plus <a href='https://github.com/johncassil/stringr.plus'><img src='man/figures/logo.png' align="right" height="175" /></a>

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![R build
status](https://github.com/johncassil/stringr.plus/workflows/R-CMD-check/badge.svg)](https://github.com/johncassil/stringr.plus/actions)
<!-- badges: end -->

## Overview

stringr.plus provides some additional functions not found in stringr for
working with strings. Functions play quite nicely with the tidyverse.
The functions are especially useful for working with URLs and file path
data to extract specific text from strings.

## Installation

You can install the released version of stringr.plus from
[github](https://github.com) with:

``` r
# install.packages("remotes")
remotes::install_github("johncassil/stringr.plus")
```

## Examples

Quite frequently when working with urls or filepaths, one would like to
strip out everything before or after a pattern or symbol. Sometimes we
need to extract the text between patterns:

``` r
library(stringr.plus)

url <- 'www.carfax.com/vehicle/3GCPKTE77DG348900'

#What if we need just the base url?
str_extract_before(string = url, pattern = '/')
#> [1] "www.carfax.com"
```

``` r
#If we need just the 'slug' (the part after the base url), we can use:
str_extract_after(string = url, pattern = '/')
#> [1] "vehicle/3GCPKTE77DG348900"
```

``` r
#Or if we need just the last section (the VIN):
str_extract_after(string = url, pattern = 'vehicle/')
#> [1] "3GCPKTE77DG348900"
```

``` r
#Both functions have a num_char argument that can allow specificity for how many characters you want returned:
str_extract_after(string = url, pattern = 'vehicle/', num_char = 5)
#> [1] "3GCPK"
```

``` r
#Additionally, we often are interested in extracting text between two common patterns:
file_path <- "‪C:/Users/pingu/Downloads/a-very-poorly-named-file_08_09_2020.csv"
str_extract_between(string = file_path, pattern1 = '_', pattern2 = ".csv")
#> [1] "08_09_2020"
```

From time to time, it’s helpful to detect if a string contains more than
one pattern, typically for filtering purposes.

``` r
#str_detect_multiple with the "and" method ensures that all patterns must be found to return TRUE:
file_path <- "‪C:/Users/pingu/Downloads/a-very-poorly-named-file_08_09_2020.csv"
str_detect_multiple(string = file_path, patterns = c("pingu", "2020"), method = 'and')
#> [1] TRUE
#An easier alias for this is str_detect_multiple_and()
str_detect_multiple_and(string = file_path, patterns = c("Downloads", "csv"))
#> [1] TRUE
```

Likewise, it’s helpful to detect if a string contains any patterns from
a list of patterns.

``` r
#str_detect_multiple with the "or" method ensures at least one of patterns must be found to return TRUE:
file_path <- "‪C:/Users/pingu/Downloads/a-very-poorly-named-file_08_09_2020.csv"
str_detect_multiple(string = file_path, patterns = c("very", "purple"), method = 'or')
#> [1] TRUE
#It is also aliased with str_detect_multiple_or()
str_detect_multiple_or(string = file_path, patterns = c("large", "file"))
#> [1] TRUE
```

These functions inherit properties from and are based on
stringr::str\_extract(), so patterns can be regular expressions. Consult
the documentation for more details.
