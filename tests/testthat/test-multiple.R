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
