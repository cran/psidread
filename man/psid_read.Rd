% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/psid_read.R
\name{psid_read}
\alias{psid_read}
\title{Read PSID data from the packaged data file or customized data file}
\usage{
psid_read(indir, str_df, idvars = NA, type, filename = NA)
}
\arguments{
\item{indir}{A character value of the directory path where the user store the .rda data files. This value should be the same as the \code{exdir} in the \code{psid_unzip()}}

\item{str_df}{A data frame of the data structure, generated from the \code{psid_str()} function.}

\item{idvars}{A vector of character values, including the variables that do not change across years. Labelled as "ALL YEAR" in PSID website.}

\item{type}{The type of data that the user downloaded from PSID. Set to "package" if the user downloaded packaged dataset, "single" if the user downloaded selected data set.}

\item{filename}{A character value of the name of the file. You can use the filename value you used when you run \code{psid_unzip()}, or a filename without any file extension.}
}
\value{
A data frame with all the selected variables inside but name unchanged.
}
\description{
\code{psid_read()} is the core function which enables the user to read variables from multiple packaged PSID data files using just one line of code.
}
\details{
This function also offers the option to read a customized single data files with selected variables.
It is important to note that \code{psid_read()} does not change the original variable names as they are in the source data.
To execute it effectively, please make sure that:
\itemize{
\item \code{psid_str()} has been executed beforehand and the table of data structure has been in the environment.
\item \code{psid_unzip()} has been executed to prepare the data in \code{.rda} format.
}
}
\examples{
# Example 1: Read from multiple package data files (Whole procedure)
psid_varlist = c(" hh_age || [13]ER53017 [17]ER66017",
                            " p_age || [13]ER34204")
str_df <- psid_str(varlist = psid_varlist,
                   type = "separated")
# Below is the file path for the package test data, set this to your own directory
indir <- system.file(package = "psidread","extdata")
psid_read(indir = indir,
          str_df = str_df,
          idvars = c("ER30000"),
          type = "package",
          filename = NA)

# Example 2: Read from your customized data file (Whole procedure)
filename = "J327825.zip"
psid_read(indir = indir,
          str_df = str_df,
          idvars = c("ER30000"),
          type = "single",
          filename = filename)
}
