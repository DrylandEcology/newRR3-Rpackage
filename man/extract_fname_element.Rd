% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Functions__ProjectDescription-newRR3.R
\name{extract_fname_element}
\alias{extract_fname_element}
\title{Extract file base name elements separated by \verb{__}}
\usage{
extract_fname_element(fnames, pos)
}
\arguments{
\item{fnames}{A vector of character strings representing file names.}

\item{pos}{An integer value identifying the nth-element.}
}
\value{
A vector of character strings with the \code{pos}-nth element of the
\code{basename()} of each \code{fnames} as separated by \verb{__}.
}
\description{
Extract file base name elements separated by \verb{__}
}
\examples{
extract_fname_element(
  file.path("here", "RR__climate-projection__delta-acrmod.csv"),
  pos = 1L
)
extract_fname_element(
  file.path("here", "RR__climate-projection__delta-acrmod.csv"),
  pos = 3L
)

}
