#' Extract pattern from a string along with characters that occur before and after the pattern.
#'
#'#' Vectorised over `string`, `pattern`, and `window_size`.
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
str_extract_context <- function(string, pattern, window_size = 10){

    positions_of_pattern <- stringr::str_locate(string = string, pattern = pattern)
    string_extract_all <- rep(character(0), nrow(positions_of_pattern))

    window_size <- if(length(window_size) == 1) {
        rep(window_size, length(positions_of_pattern))
    } else {
        window_size
    }


    for(i in 1:nrow(positions_of_pattern)){
        start_of_pattern <- positions_of_pattern[i,"start"]
        end_of_pattern <- positions_of_pattern[i,"end"]
        string_extract <- stringr::str_sub(string = string[i],
                                           start = max(0,
                                                       start_of_pattern - window_size[i]),
                                           end = min(nchar(string[i]),
                                                     end_of_pattern + window_size[i])
        )

        string_extract_all[i] <- string_extract
    }

    return(string_extract_all)
}
