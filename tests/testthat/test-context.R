test_string <- 'URL.com/long_string_here_before_pattern_after_another_string_here_with_pattern2_there_and_date_here_2020_10_20_but_not_here/'

test_vector <- c(test_string, "another test before this one")

test_that("str_extract_context works", {

    expect_equal(str_extract_context(string = test_string, pattern = "before", window_size = 3),
                 "re_before_pa")

    expect_equal(str_extract_context(string = test_string, pattern = "string", window_size = 3),
                 c("ng_string_he...er_string_he"))

})



test_that("str_extract_context vectorization works", {
    expect_equal(
        str_extract_context(string = test_vector, pattern = c("here","test"), window_size = 5),
        c("ring_here_befo...ring_here_with...rn2_there_and_...date_here_2020..._not_here/", "ther test befo")
    )

})
