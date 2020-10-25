test_string <- 'URL.com/long_string_here_before_pattern_after_another_string_here_with_pattern2_there_and_date_here_2020_10_20_but_not_here/'

test_that("str_extract_after works", {

    expect_equal(str_extract_after(string = test_string, pattern = '_pattern_'),
                 "after_another_string_here_with_pattern2_there_and_date_here_2020_10_20_but_not_here/")


    expect_equal(str_extract_after(string = test_string, pattern = '_pattern_', num_char = 5),
                 "after")

})


test_that("str_extract_after_date works", {

    expect_equal(str_extract_after_date(string = test_string, date_sep = '_'),
                 "but_not_here/")


    expect_equal(str_extract_after_date(string = test_string, date_sep = '_', num_char = 12),
                 "but_not_here")

})
