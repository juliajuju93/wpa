% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/subject_validate.r
\name{subject_validate}
\alias{subject_validate}
\title{Scan meeting subject and highlight items for review}
\usage{
subject_validate(data, return = "text")
}
\arguments{
\item{data}{A meeting query in the form of a data frame.}

\item{return}{A string specifying what to return.
Returns a message in the console by default, where 'text' is passed in \code{return}.
When 'table' is passed, a summary table with common terms found is printed.
When 'data' is passed, a the original data with an additional flag column is returned as a data frame.}
}
\value{
Returns a message in the console by default, where 'text' is passed in \code{return}.
When 'table' is passed, a summary table with common terms found is printed.
When 'data' is passed, a the original data with an additional flag column is returned as a data frame.
}
\description{
This functions scans a meeting query and highlights meetings with subjects that include common exlusion terms. It is intended to be used by an analyst to validate raw data before conducting additional analysis.
Returns a summary in the console by default.
Additional option to return the underlying data with a flag of items for review.
}
\seealso{
Other Data Validation: 
\code{\link{check_query}()},
\code{\link{flag_ch_ratio}()},
\code{\link{flag_em_ratio}()},
\code{\link{flag_extreme}()},
\code{\link{flag_outlooktime}()},
\code{\link{hrvar_count_all}()},
\code{\link{hrvar_count}()},
\code{\link{identify_holidayweeks}()},
\code{\link{identify_inactiveweeks}()},
\code{\link{identify_nkw}()},
\code{\link{identify_outlier}()},
\code{\link{identify_privacythreshold}()},
\code{\link{identify_query}()},
\code{\link{identify_tenure}()},
\code{\link{remove_outliers}()},
\code{\link{subject_validate_report}()},
\code{\link{track_HR_change}()}
}
\concept{Data Validation}
