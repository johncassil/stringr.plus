test_string <- 'URL.com/long_string_here_before_pattern_after_another_string_here_with_pattern2_there_and_date_here_2020_10_20_but_not_here/'

test_that("str_extract_context works", {

    expect_equal(str_extract_context(string = test_string, pattern = "before", window_size = 3),
                 "re_before_pa")

    expect_equal(str_extract_context(string = test_string, pattern = "string", window_size = 3),
                 c("ng_string_he","er_string_he"))

})
