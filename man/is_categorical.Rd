% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Functions__ProjectDescription-newRR3.R
\name{is_categorical}
\alias{is_categorical}
\title{Detects categorical variables based on hard-coded set of tags}
\usage{
is_categorical(
  x,
  tags_categorical = c("Resistance_response", "Resilience_response", "Resistance_mirrp",
    "Resilience_mirrp", "_(acrmodrobust$)|(acrmodrobust_)", "_isnovel"),
  tags_noncategorical = "acrmodagree"
)
}
\arguments{
\item{x}{A vector of character strings containing variable names.}

\item{tags_categorical}{A vector of character strings containing patterns
that identify categorical variables.}

\item{tags_noncategorical}{A vector of character strings containing patterns
that identify any variable as not categorical (overrules \code{tags_categorical}).}
}
\value{
A logical vector indicating whether each element of \code{x} is
categorical \code{TRUE} or not
(based on pattern matches against \code{tags_categorical} and
\code{tags_noncategorical}).
}
\description{
Detects categorical variables based on hard-coded set of tags
}
\section{Notes}{

\itemize{
\item Robustness (across models) of any variable is categorical;
however, if robustness is combined with the delta, then only already
categorical variables are categorical.
\item Agreement (across models) of any variable is numerical.
}
}

\examples{
## Expected outcome: FALSE
newRR3::is_categorical("cat")
## Expected outcome: TRUE
newRR3::is_categorical("cat", tags_categorical = "cat")
## Expected outcome: FALSE
newRR3::is_categorical("cat_acrmodagree", tags_categorical = "cat")
## Expected outcome: TRUE
newRR3::is_categorical("cat_acrmodrobust")
## Expected outcome: FALSE
newRR3::is_categorical("cat_acrmodrobust090delta")
## Expected outcome: TRUE
newRR3::is_categorical("cat_acrmodrobust090delta", tags_categorical = "cat")
## Expected outcome: FALSE, TRUE, FALSE, FALSE
newRR3::is_categorical(c("a", "a_acrmodrobust", "b", "b_nonrobust"))

}
