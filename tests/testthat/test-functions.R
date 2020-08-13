test_string <- 'URL.com/long_string_here_before_pattern_after_another_string_here_with_pattern2_there/'

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


multiple_test_string <- '1kadlkj raid.who .csv'

test_that("str_detect_multiple works", {

    #Bad method:
    expect_error(str_detect_multiple(multiple_test_string, patterns = 'ad', method = 'x'))

    #And
    expect_true(str_detect_multiple(multiple_test_string, patterns = c('csv', 'raid'), method = 'and'))
    expect_false(str_detect_multiple(multiple_test_string, patterns = c('csv', 'rakljh'), method = 'and'))
    expect_false(str_detect_multiple(multiple_test_string, patterns = c('csv32', 'raid'), method = 'and'))
    expect_false(str_detect_multiple(multiple_test_string, patterns = c('csv32', 'rakljh'), method = 'and'))

    #Or
    expect_true(str_detect_multiple(multiple_test_string, patterns = c('csv', 'rakljh'), method = 'or'))
    expect_true(str_detect_multiple(multiple_test_string, patterns = c('csv32', 'raid'), method = 'or'))
    expect_true(str_detect_multiple(multiple_test_string, patterns = c('csv', 'raid'), method = 'or'))
    expect_false(str_detect_multiple(multiple_test_string, patterns = c('csv32', 'rakljh'), method = 'or'))
})
