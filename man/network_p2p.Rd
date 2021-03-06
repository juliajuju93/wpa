% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/network_p2p.R
\name{network_p2p}
\alias{network_p2p}
\title{Create a network plot with the person-to-person query}
\usage{
network_p2p(
  data,
  hrvar,
  return = "pdf",
  path = "network_p2p",
  bg_fill = "#000000",
  font_col = "#FFFFFF",
  legend_pos = "bottom",
  palette = rainbow,
  ...
)
}
\arguments{
\item{data}{Data frame containing a person-to-person query.}

\item{hrvar}{String containing the label for the HR attribute.}

\item{return}{Character vector specifying what to return, defaults to "pdf".
Other valid inputs are "plot", "network" and "table". "network" returns the \code{network}
object used to generate the network plot. The "pdf" option is highly recommended over the "plot"
option as the PDF export format has significantly higher performance. The "plot" option is highly
computationally intensive and is not generally recommended.}

\item{path}{File path for saving the PDF output. Defaults to "network_p2p".}

\item{bg_fill}{String to specify background fill colour.}

\item{font_col}{String to specify font and link colour.}

\item{legend_pos}{String to specify position of legend. Defaults to "bottom". See \code{ggplot2::theme()}.}

\item{palette}{Function for generating a colour palette with a single argument \code{n}. Uses \code{rainbow()} by default.}

\item{...}{Additional arguments to pass to \code{GGally::ggnet2()}.
For instance, you may specify the argument \code{mode} to change the node placement algorithm.}
}
\description{
Pass a data frame containing a person-to-person query and save a network
plot as a PDF file.
}
\details{
For specifying the node placement algorithm, please see the \code{gplot.layout} documentation for the \strong{sna}
package, which provides a full list of the valid functions that can be passed into the \code{mode} argument.
}
