test_string <- 'URL.com/long_string_here_before_pattern_after_another_string_here_with_pattern2_there/'
str_extract_before(string = test_string, pattern = '_pattern_')




test_that("str_extract_before works", {

    expect_equal(str_extract_before(string = test_string, pattern = '_pattern_'),
                 "URL.com/long_string_here_before")


    expect_equal(str_extract_before(string = test_string, pattern = '_pattern_', num_char = 6),
                 "before")

})



test_that("str_extract_after works", {

    expect_equal(str_extract_after(string = test_string, pattern = '_pattern_'),
                 "after_another_string_here_with_pattern2_there/")


    expect_equal(str_extract_after(string = test_string, pattern = '_pattern_', num_char = 5),
                 "after")

})



test_that("str_extract_between works", {

    expect_equal(str_extract_between(string = test_string, pattern1 = "_pattern_", pattern2 = "_pattern2"),
                 "after_another_string_here_with")

})


