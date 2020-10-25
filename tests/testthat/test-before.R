test_string <- 'URL.com/long_string_here_before_pattern_after_another_string_here_with_pattern2_there_and_date_here_2020_10_20_but_not_here/'

test_vector <- c(test_string, test_string, test_string)

before_result <- "URL.com/long_string_here_before"

before_vector <- c(before_result, before_result, before_result)

test_that("str_extract_before works", {

    expect_equal(str_extract_before(string = test_string, pattern = '_pattern_'),
                 before_result)


    expect_equal(str_extract_before(string = test_string, pattern = '_pattern_', num_char = 6),
                 "before")

})



test_that("str_extract_before vectorization works", {

    expect_equal(str_extract_before(string = test_vector, pattern = '_pattern_'),
                 before_vector)


    expect_equal(str_extract_before(string = test_vector, pattern = '_pattern_', num_char = 6),
                 c("before", "before", "before"))

})





test_that("str_extract_before_date works", {

    expect_equal(str_extract_before_date(string = test_string, date_sep = "_"),
                 "URL.com/long_string_here_before_pattern_after_another_string_here_with_pattern2_there_and_date_here")


    expect_equal(str_extract_before_date(string = test_string, date_sep = "_", num_char = 9),
                 "date_here")

})
