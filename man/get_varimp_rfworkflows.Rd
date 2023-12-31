% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Functions__Novelty.R
\name{get_varimp_rfworkflows}
\alias{get_varimp_rfworkflows}
\title{Load and extract variable importance from fitted models for R&R}
\usage{
get_varimp_rfworkflows(fname_varimp_data, fnames_mrrrf, dir_dataraw)
}
\arguments{
\item{fname_varimp_data}{File name with path for the
extracted training data (stored as \code{"rds"} file).}

\item{fnames_mrrrf}{A named vector of length two with file names to the
fitted workflow objects for \code{"Resilience"} and \code{"Resistance"} stored as
\code{"rds"} files on disk. Only used if \code{fname_varimp_data} doesn't already
exist.}
}
\value{
A list with a data frame containing the variable importance for
each model.
}
\description{
Load variable importance if already extracted from fitted models for R&R;
otherwise, extract variable importance and write to disk.
}
