% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tm_clean.R
\name{tm_clean}
\alias{tm_clean}
\title{Clean subject line text prior to analysis}
\usage{
tm_clean(data, token = "words", stopwords = NULL)
}
\arguments{
\item{data}{A Meeting Query dataset in the form of a data frame.}

\item{token}{A character vector accepting either "words" or "ngram", determining
type of tokenisation to return.}

\item{stopwords}{A single-column data frame labelled 'word' containing custom stopwords to remove.}
}
\description{
This function processes the \code{Subject} column in a Meeting Query by
applying tokenisation using\code{tidytext::unnest_tokens()}, and removing
any stopwords supplied in a data frame (using the argument \code{stopwords}).
This is a sub-function that feeds into \code{tm_freq()}, \code{tm_cooc()}, and \code{tm_wordcloud()}.
The default is to return a data frame with tokenised counts of words or ngrams.
}
\seealso{
Other Text-mining: 
\code{\link{meeting_tm_report}()},
\code{\link{tm_cooc}()},
\code{\link{tm_freq}()},
\code{\link{tm_wordcloud}()}
}
\concept{Text-mining}
