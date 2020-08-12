
<!-- README.md is generated from README.Rmd. Please edit that file -->

# stringr.plus

<!-- badges: start -->

<!-- badges: end -->

stringr.plus provides some additional functions not found in stringr for
working with strings. Functions play quite nicely with the tidyverse.
The functions are especially useful for working with URLs and file path
data to extract specific text from strings.

## Installation

You can install the released version of stringr.plus from
[github](https://github.com) with:

``` r
# install.packages("devtools")
devtools::install_github("johncassil/stringr.plus")
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
#Finally, we often are interested in extracting text between two common patterns:
file_path <- "‪C/Users/johnpaulcassil/Downloads/a-very-poorly-named-file_08_09_2020.csv"
str_extract_between(string = file_path, pattern1 = '_', pattern2 = ".csv")
#> [1] "08_09_2020"
```

These functions inherit properties from and are based on
stringr::str\_extract, so patterns can be regular expressions. Consult
the documentation for more details.
