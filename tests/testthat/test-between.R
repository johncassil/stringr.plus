test_string <- 'URL.com/long_string_here_before_pattern_after_another_string_here_with_pattern2_there_and_date_here_2020_10_20_but_not_here/'

test_that("str_extract_between works", {

    expect_equal(str_extract_between(string = test_string, pattern1 = "_pattern_", pattern2 = "_pattern2"),
                 "after_another_string_here_with")

})
