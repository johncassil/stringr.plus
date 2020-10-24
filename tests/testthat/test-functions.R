test_string <- 'URL.com/long_string_here_before_pattern_after_another_string_here_with_pattern2_there_and_date_here_2020_10_20_but_not_here/'

test_that("str_extract_before works", {

    expect_equal(str_extract_before(string = test_string, pattern = '_pattern_'),
                 "URL.com/long_string_here_before")


    expect_equal(str_extract_before(string = test_string, pattern = '_pattern_', num_char = 6),
                 "before")

})

test_that("str_extract_before_date works", {

    expect_equal(str_extract_before_date(string = test_string, date_sep = "_"),
                 "URL.com/long_string_here_before_pattern_after_another_string_here_with_pattern2_there_and_date_here")


    expect_equal(str_extract_before_date(string = test_string, date_sep = "_", num_char = 9),
                 "date_here")

})


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



test_that("str_extract_between works", {

    expect_equal(str_extract_between(string = test_string, pattern1 = "_pattern_", pattern2 = "_pattern2"),
                 "after_another_string_here_with")

})

test_that("str_extract_context works", {

    expect_equal(str_extract_context(string = test_string, pattern = "before", window_size = 3),
                 "re_before_pa")

    expect_equal(str_extract_context(string = test_string, pattern = "string", window_size = 3),
                 c("ng_string_he","er_string_he"))

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
