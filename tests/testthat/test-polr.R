test_that("Ordered logistic regression works", {
  set.seed(1234)
  df <- data.frame(
    outcome = factor(rep(LETTERS[1:3], 100),
      levels = LETTERS[1:3],
      ordered = TRUE
    ),
    continuous_1 = rnorm(300, 100, 1),
    continuous_2 = rnorm(300, 50, 5)
  )

  model_polr <- MASS::polr(outcome ~ ., data = df, Hess = TRUE, method = "logistic")
  model_polr_probit <- MASS::polr(outcome ~ ., data = df, Hess = TRUE, method = "probit")

  # ordered logit builds correctly
  expect_snapshot_output(extract_eq(model_polr, wrap = FALSE))

  # ordered logit builds correctly in wrapped environment
  expect_snapshot_output(
    extract_eq(model_polr, wrap = TRUE, terms_per_line = 2)
  )

  # ordered probit builds correctly
  expect_snapshot_output(
    extract_eq(model_polr_probit, wrap = FALSE)
  )

  # ordered probit builds correctly in wrapped environment
  expect_snapshot_output(
    extract_eq(model_polr_probit, wrap = TRUE, terms_per_line = 2)
  )

  # ordered logit + coefs builds correctly
  expect_snapshot_output(extract_eq(model_polr, use_coefs = TRUE))
})
