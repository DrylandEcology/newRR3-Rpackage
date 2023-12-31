% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Functions__ProjectDescription-newRR3.R
\name{get_levels}
\alias{get_levels}
\title{Find levels of a categorical variable}
\usage{
get_levels(vtag, vdesc, meta, return_labels = TRUE)
}
\description{
Find levels of a categorical variable
}
\examples{
meta <- newRR3::get_project_description(
  include_variables = TRUE,
  include_scenarios = TRUE,
  include_deltas = TRUE,
  include_summaries = TRUE,
  dir_data = system.file("extdata", "data-raw", package = "newRR3"),
  tag_prj = "newRR3",
  tag_sims = ""
)

get_levels("rr", "value-sim", meta)
get_levels("rr", "value-sim", meta, return_labels = FALSE)
get_levels("rr", "delta-acrmod-robust", meta)
get_levels("rr", "delta-acrmod", meta)
get_levels("rr", "simpledelta-acrmod", meta)
get_levels("rr", "robustdelta-acrmod", meta)
get_levels("rr", "robustsimpledelta-acrmod", meta)
get_levels("rr", "robust090delta-acrmod", meta)
get_levels("preds", "delta-acrmod", meta)

fn <- file.path("here", "RR__climate-projection__delta-acrmod.csv")
get_levels(
  vtag = standardize_vtags(
    extract_fname_element(fn, pos = 1L),
    tags = meta[["varsets"]][["tags"]]
  ),
  vdesc = extract_fname_element(fn, pos = 3L),
  meta = meta
)

}
\seealso{
\code{\link[=is_categorical]{is_categorical()}}
}
