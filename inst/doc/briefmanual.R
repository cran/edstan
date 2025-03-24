## ----include = FALSE----------------------------------------------------------
# Do not evaluate code if outputing to html in order to pass CRAN checks
is_html <- knitr::opts_knit$get("rmarkdown.pandoc.to") == "html"
knitr::opts_chunk$set(eval = !is_html)
set.seed(17)

## ----message = FALSE, results = 'hide'----------------------------------------
# # Load packages and set options
# library(edstan)
# options(mc.cores = parallel::detectCores())

## -----------------------------------------------------------------------------
# # Preview the spelling data
# spelling[sample(1:nrow(spelling), 6), ]

## -----------------------------------------------------------------------------
# # Make a data list
# simple_list <- irt_data(response_matrix = spelling[, -1])
# str(simple_list)

## -----------------------------------------------------------------------------
# # Make a data list with person covariates
# latent_reg_list <- irt_data(
#   response_matrix = spelling[, -1],
#   covariates = spelling,
#   formula = ~ rescale_binary(male)
# )
# 
# str(latent_reg_list)

## ----message=FALSE, results='hide'--------------------------------------------
# # Fit the Rasch model
# fit_rasch <- irt_stan(latent_reg_list, model = "rasch_latent_reg.stan",
#                       iter = 2000, chains = 4)

## ----fig.width=6--------------------------------------------------------------
# # View convergence statistics
# stan_columns_plot(fit_rasch)

## -----------------------------------------------------------------------------
# # View a summary of parameter posteriors					
# print_irt_stan(fit_rasch, latent_reg_list)

## -----------------------------------------------------------------------------
# edstan_model_code("rasch_latent_reg.stan")

## ----eval=FALSE---------------------------------------------------------------
# # Fit the Rasch model
# fit_rasch <- irt_stan(latent_reg_list, model = "2pl_latent_reg.stan",
#                       iter = 2000, chains = 4)

## -----------------------------------------------------------------------------
# # Preview the data
# head(aggression)

## -----------------------------------------------------------------------------
# # Make the data list
# agg_list <- irt_data(
#   y = aggression$poly,
#   ii = aggression$description,
#   jj = aggression$person,
#   covariates = aggression,
#   formula = ~ rescale_binary(male) * rescale_continuous(anger)
# )
# 
# str(agg_list)

## ----message=FALSE, results='hide'--------------------------------------------
# # Fit the generalized partial credit model
# fit_gpcm <- irt_stan(agg_list, model = "gpcm_latent_reg.stan",
#                      iter = 2000, chains = 4)

## ----fig.width=6--------------------------------------------------------------
# # View convergence statistics
# stan_columns_plot(fit_gpcm)

## -----------------------------------------------------------------------------
# # View a summary of parameter posteriors	
# print_irt_stan(fit_gpcm, agg_list)

