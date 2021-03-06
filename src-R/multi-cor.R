## Functions for Multiple Correlation
## Edward J. Xu
## April 30, 2020

#' Calculate the Residual Sum of Squares (RSS) of a LR Model
cal_rss <- function(mod){
  rss <- mod %>%
    {quiet(lmSupport::modelEffectSizes(.))} %>%
    {.$SSE}

  return(rss)
  }

#' Calculate Log Likelihood of a LR Model
cal_llk <- function(mod){
  llk <- mod %>%
    logLik() %>%
    as.numeric()

  return(llk)
  }


