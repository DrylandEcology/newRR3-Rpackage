% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Functions__ExternalDataImport.R
\name{import_gsu_template}
\alias{import_gsu_template}
\title{Import template raster with encoded gridded simulation units}
\usage{
import_gsu_template(
  dir_dataraw = file.path("..", "data-raw"),
  dir_mappingdata = file.path("..", "..", "0_Inputs", "Data_for_Mapping"),
  mask_set = c("sim", "rangelands", "combined"),
  version_inputs = NULL,
  method_to_import = c("symlink", "copy")
)
}
\description{
Import template raster with encoded gridded simulation units
}
