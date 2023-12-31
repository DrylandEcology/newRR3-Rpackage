% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Functions__Novelty.R
\name{novelty}
\alias{novelty}
\alias{train_NT2}
\alias{calc_NT2}
\alias{train_NT1}
\alias{calc_NT1}
\alias{calc_AOArdi}
\title{Multivariate novelty (extrapolation)}
\usage{
train_NT2(traindata, trimmed = NULL)

calc_NT2(newdata, traindata = NULL, trained = NULL, trimmed = NULL)

train_NT1(traindata, trimmed = NULL)

calc_NT1(newdata, traindata = NULL, trained = NULL, trimmed = NULL)

calc_AOArdi(newdata, trained, cl = NULL, weight = NA, trimmed = NULL)
}
\arguments{
\item{traindata}{A numerical matrix. The training data with
variables organized in columns.}

\item{trimmed}{\code{NULL} (don't trim data for threshold) or a representation
of a version number corresponding to how \code{CAST::trainDI()} applies trimming,
see \code{calc_AOArdi()} for details.}

\item{newdata}{A numerical matrix. The new data for which to calculate the
degree of novelty compared to \code{traindata}. Columns must
match those of \code{traindata}.}

\item{cl}{A optional cluster object,
e.g., created by \code{\link[parallel:makeCluster]{parallel::makeCluster()}};
utilized by \code{\link[CAST:aoa]{CAST::aoa()}} and obsolete with \code{CAST} \code{v0.7.1}.}

\item{weight}{An optional data frame with variable weights. The data frame
must contain one row of weights with columns
for each variable in \code{traindata}.}
}
\value{
A numerical vector corresponding to rows in \code{newdata}
where values larger than one identify novelty and values in \verb{[0, 1]}
represent absence of novelty (see \code{\link[=is_novel]{is_novel()}}.
\code{NA} are propagated from \code{newdata}(unlike \code{\link[CAST:aoa]{CAST::aoa()}}).
}
\description{
Multivariate novelty (extrapolation)
}
\section{\code{\link[=calc_NT1]{calc_NT1()}}}{

NT1 ranges from one to unbounded positive values, as defined here;
originally, NT1 ranged from zero to unbounded negative values.
NT1 values of one indicate similarity within the range of individual
covariates and NT1 values larger than one indicate novelty
outside the range of individual covariates."
(Mesgaran et al. 2014).

If the argument \code{trimmed} is a version number of \code{CAST}, then a modified
range is utilized as implemented in \code{\link[CAST:aoa]{CAST::aoa()}}, i.e.,
"outlier-removed" training minima and maxima; otherwise, the
original range is used, i.e., the training minima and maxima.
}

\section{\code{\link[=calc_NT2]{calc_NT2()}}}{

"NT2 can range from zero up to unbounded positive values. NT2 values
ranging from zero to one indicate similarity (in terms of both univariate
range and multivariate combination), with values closer to zero being more
similar. Values larger than one are indicative of novel combinations"
(Mesgaran et al. 2014).

Calculates the Mahalanobis distance of each observation to the environmental
center of the reference set for both the reference and the projection data
set and calculate the ratio between the two.

If the argument \code{trimmed} is a version number of \code{CAST}, then a modified
threshold is utilized as implemented in \code{\link[CAST:aoa]{CAST::aoa()}}, i.e.,
an "outlier-removed maximum training distance"; otherwise, the
original threshold is used, i.e., the maximum training distance.
}

\section{\code{\link[=calc_AOArdi]{calc_AOArdi()}}}{

Implemented as \code{\link[CAST:aoa]{CAST::aoa()}} but return value is \code{rdi = DI / threshold}
such that the area of applicability is identified by \code{rdi <= 1} and
areas of novelty by \code{rdi > 1}.

Currently, no weighting based on variable importance and no calibration
based on cross-validation of models is performed.

\code{NA} are propagated (unlike \code{\link[CAST:aoa]{CAST::aoa()}}).

\code{CAST} changed calculation of the threshold based on training data \code{di};
see \href{https://github.com/HannaMeyer/CAST/issues/46}{issue #46}:
\itemize{
\item \code{v0.7.0}: threshold is the value in \code{di} closest to, but not more than
\code{quantile(di, 0.75) + (1.5 * IQR(di))}
\item \code{v0.7.1}: threshold is \code{quantile(di, 0.75) + (1.5 * IQR(di))}
}
}

\examples{
n <- 100
v <- 40
offset <- 10
set.seed(234)

a <- c(
  # point cluster
  seq_len(n),
  # outliers
  c(-1.5, 0, 0, 1.5) * n
)
b <- c(
  # point cluster
  sample(x = v, size = n, replace = TRUE) + seq_len(n),
  # outliers
  c(n, -n / 2, 2 * n, n)
)
traindata <- data.frame(a = c(a, 1.5 * n + a), b = c(b, 0.5 * n + b))

newdata <- data.frame(
  a = sample(
    x = seq(min(traindata[[1L]]) - offset, max(traindata[[1L]]) + offset),
    size = 5 * n,
    replace = TRUE
  ),
  b = sample(
    x = seq(min(traindata[[2L]]) - offset, max(traindata[[2L]]) + offset),
    size = 5 * n,
    replace = TRUE
  )
)

trained_NT1 <- train_NT1(traindata = traindata)
trained_NT1mod <- train_NT1(traindata = traindata, trimmed = "0.7.0")
trained_NT2 <- train_NT2(traindata = traindata)
trained_NT2mod <- train_NT2(traindata = traindata, trimmed = "0.7.0")
trained_AOA <- CAST::trainDI(train = traindata)
trained_AOAw <- CAST::trainDI(
  train = traindata,
  weight = data.frame(a = 1, b = 10)
)

xnovel <- list(
  NT1 = calc_NT1(newdata = newdata, trained = trained_NT1),
  NT1mod070 = calc_NT1(newdata = newdata, trained = trained_NT1mod),
  NT2 = calc_NT2(newdata = newdata, trained = trained_NT2),
  NT2mod070 = calc_NT2(newdata = newdata, trained = trained_NT2mod),
  AOArdi070 =
    calc_AOArdi(newdata = newdata, trained = trained_AOA, trimmed = "0.7.0"),
  AOArdi071 = calc_AOArdi(newdata = newdata, trained = trained_AOA)
)

res <- lapply(
  seq_along(xnovel),
  function(k) {
    ids <- is_novel(xnovel[[k]])
    metric <- names(xnovel)[[k]]
    rbind(
      data.frame(
        metric = metric, type = "training",
        x = traindata[[1L]], y = traindata[[2L]]
      ),
      data.frame(
        metric = metric, type = "novel",
        x = newdata[[1L]][ids], y = newdata[[2L]][ids]
      ),
      data.frame(
        metric = metric, type = "not novel",
        x = newdata[[1L]][!ids], y = newdata[[2L]][!ids]
      )
    )
  }
)

res <- do.call(rbind, res)

if (interactive() && requireNamespace("ggplot2")) {
  ggplot2::ggplot(res) +
    ggplot2::aes(x = x, y = y, color = type, shape = type) +
    ggplot2::facet_wrap(ggplot2::vars(metric), ncol = 2L) +
    ggplot2::geom_point() +
    ggplot2::scale_color_discrete(type = newRR3::colors_okabeito()) +
    newRR3::ggplot2_clean_theme()
}

}
\references{
Mesgaran, M. B., R. D. Cousens, B. L. Webber, and J. Franklin.
2014. Here be dragons: a tool for quantifying novelty due to covariate
range and correlation change when projecting species distribution models.
Diversity and Distributions 20:1147-1159.
\doi{10.1111/ddi.12209}

Meyer, H., Pebesma, E. (2021) Predicting into unknown space?
Estimating the area of applicability of spatial prediction models.
Methods in Ecology and Evolution 12: 1620-1633.
\doi{10.1111/2041-210X.13650}
}
\seealso{
\code{\link[CAST:aoa]{CAST::aoa()}}
}
