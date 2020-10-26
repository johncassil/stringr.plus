test_string <- 'URL.com/long_string_here_before_pattern_after_another_string_here_with_pattern2_there_and_date_here_2020_10_20_but_not_here/'


test_that("str_extract_context works", {

    expect_equal(
        str_extract_context(string = test_string, pattern = "before", window_size = 3),
        "re_before_pa")

    expect_equal(
        str_extract_context(string = test_string, pattern = "string", window_size = 3),
        "ng_string_he")

})

test_data <- tibble::tribble(
    ~text, ~keyword, ~needed_context,
    "This is my first test string.", "first", 5,
    "This is a second one.", "second", 5,
    "This beef is incredible. I like all beef, but Angus beef is the best", "beef", 4,
    "I'm trying to become a vegetarian, though!", "vegetarian", 10)


##
test_that("str_extract_context vectorization works", {
    expect_equal(
        test_data %>%
            dplyr::mutate(context = str_extract_context(text, keyword, needed_context)) %>%
            dplyr::select(context),
        tibble::tribble(
            ~context,
            "s my first test",
            "is a second one.",
            "his beef is ",
            " become a vegetarian, though!")
    )
})


test_that("str_extract_context vectorization works with static window", {
    expect_equal(
        test_data %>%
            dplyr::mutate(context = str_extract_context(text, keyword, 5)) %>%
            dplyr::select(context),
        tibble::tribble(
            ~context,
            "s my first test",
            "is a second one.",
            "This beef is i",
            "me a vegetarian, tho")
    )
})



##
test_that("str_extract_context_all vectorization works", {
    expect_equal(
        test_data %>%
            dplyr::mutate(context =
                              str_extract_context_all(text, keyword, needed_context)) %>%
            dplyr::select(context),

        tibble::tribble(
            ~context,
            's my first test',
            'is a second one.',
            c("his beef is ", "all beef, bu", "gus beef is "),
            ' become a vegetarian, though!'
        )
    )
})

##
test_that("str_extract_context_all vectorization works with static window", {
    expect_equal(
        test_data %>%
            dplyr::mutate(context =
                              str_extract_context_all(text, keyword, 5)) %>%
            dplyr::select(context),

        tibble::tribble(
            ~context,
            's my first test',
            'is a second one.',
            c("This beef is i", " all beef, but", "ngus beef is t"),
            'me a vegetarian, tho'
        )
    )
})

