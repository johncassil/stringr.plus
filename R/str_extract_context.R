#' Extract pattern from a string along with characters that occur before and after the pattern.
#'
#' @param string The string from which to extract.
#' @param pattern Pattern to look for.
#' @param window_size Number of characters to return before and after the pattern.
#'
#' @return A character vector with pattern matches and their context.
#' @export
#'
#' @examples
#' test_string <- 'To be or not to be, that is the question.'
#' str_extract_context(test_string, pattern = 'be', window_size = 4)
#'
str_extract_context <- function(string, pattern, window_size){

    positions_of_pattern <- as.data.frame(stringr::str_locate_all(string=string, pattern = pattern))

    string_extract_all <- rep(NA,nrow(positions_of_pattern))

    for(i in 1:nrow(positions_of_pattern)){
        start_of_pattern <- positions_of_pattern[i,"start"]
        end_of_pattern <- positions_of_pattern[i,"end"]

        string_extract <- stringr::str_sub(string = string,
                                           start = max(0, start_of_pattern - window_size),
                                           end = min(nchar(string),end_of_pattern + window_size)
        )

        string_extract_all[i] <- string_extract
    }

    return(string_extract_all)
}
