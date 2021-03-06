# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Check a query to ensure that it is suitable for analysis
#'
#' @description
#' Prints diagnostic data about the data query to the R console, with information
#' such as date range, number of employees, HR attributes identified, etc.
#'
#' @details
#' This can be used with any person-level query, such as the standard person query,
#' collaboration assessment query, and the hourly collaboration query. When run,
#' this prints diagnostic data to the R console.
#'
#' @param data A person-level query in the form of a data frame, including the standard person query,
#' collaboration assessment query, and the hourly collaboration query.
#' @param return Character string to specify whether to return a console message ("message"),
#' a character string ("text"), or a data frame. Defaults to "message".
#' @param validation Logical value to specify whether to return a check used by the `validation_report()`.
#' Defaults to FALSE.
#'
#' @examples
#' check_query(sq_data)
#'
#' @family Data Validation
#'
#' @export
check_query <- function(data, return = "message", validation = FALSE){

  if(!is.data.frame(data)){
    stop("Input is not a data frame.")
  }

  if("PersonId" %in% names(data)){

    if(validation == FALSE){

      check_person_query(data = data, return = return)

    } else if(validation == TRUE){

      # Different displays required for validation_report()
      check_query_validation(data = data, return = return)

    }
  } else {
    message("Note: checks are currently unavailable for a non-Person query")
  }
}

#' @title Check a Person Query to ensure that it is suitable for analysis
#'
#' @description
#' Prints diagnostic data about the data query to the R console, with information
#' such as date range, number of employees, HR attributes identified, etc.
#'
#' @inheritParams check_query
#'
#' @details Used as part of `check_query()`.
#'
#'
check_person_query <- function(data, return){

  ## Query Type - Initialise
  ## Uses `identify_query()`
  main_chunk <- paste0("The data used is a ", identify_query(data), ".")

  ## PersonId
  if(!("PersonId" %in% names(data))){
    stop("There is no `PersonId` variable in the input.")
  } else {
    new_chunk <- paste("There are", dplyr::n_distinct(data$PersonId), "employees in this dataset.")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

  ## Date
  if(!("Date" %in% names(data))){
    stop("There is no `Date` variable in the input.")
  } else {
    data$Date <- as.Date(data$Date, "%m/%d/%Y")
    new_chunk <- paste0("Date ranges from ", min(data$Date), " to ", max(data$Date), ".")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

  ## HR Variables
  hr_chr <- extract_hr(data, max_unique = 200) %>% wrap(wrapper = "`")
  new_chunk <- paste("There are", length(hr_chr), "(estimated) HR attributes in the data:" )
  main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  new_chunk <- paste(hr_chr, collapse = ", ")
  main_chunk <- paste(main_chunk, new_chunk, sep = "\n")

  ## `IsActive` flag
  if(!("IsActive" %in% names(data))){
    new_chunk <- "The `IsActive` flag is not present in the data."
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n")
  } else {
    data$IsActive <- as.logical(data$IsActive) # Force to logical
    active_n <- dplyr::n_distinct(data[data$IsActive == TRUE, "PersonId"])
    new_chunk <- paste0("There are ", active_n, " active employees out of all in the dataset.")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

  ## Variable check header
  new_chunk <- "Variable name check:"
  main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")

  ## Collaboration_hours
  if(!("Collaboration_hours" %in% names(data)) &
     ("Collaboration_hrs" %in% names(data))){
    new_chunk <- "`Collaboration_hrs` is used instead of `Collaboration_hours` in the data."
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  } else if(!("Collaboration_hrs" %in% names(data)) &
            ("Collaboration_hours" %in% names(data))){
    new_chunk <- "`Collaboration_hours` is used instead of `Collaboration_hrs` in the data."
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  } else {
    new_chunk <- "No collaboration hour metric exists in the data."
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

  ## Instant_Message_hours
  if(!("Instant_message_hours" %in% names(data)) &
     ("Instant_Message_hours" %in% names(data))){
    new_chunk <- "`Instant_Message_hours` is used instead of `Instant_message_hours` in the data."
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  } else if(!("Instant_Message_hours" %in% names(data)) &
            ("Instant_message_hours" %in% names(data))){
    new_chunk <- "`Instant_message_hours` is used instead of `Instant_Message_hours` in the data."
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  } else {
    new_chunk <- "No instant message hour metric exists in the data."
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

  ## Return
  if(return == "message"){

    main_chunk <- paste("", main_chunk, sep = "\n")
    message(main_chunk)

  } else if(return == "text"){
    main_chunk
  } else {
    stop("Please check inputs for `return`")
  }
}

#' @title Perform a query check for the validation report
#'
#' @description
#' Prints diagnostic data about the data query to the R console, with information
#' such as date range, number of employees, HR attributes identified, etc.
#' Optimised for the `validation_report()`
#'
#' @inheritParams check_query
#'
#' @details Used as part of `check_query()`.
#'
check_query_validation <- function(data, return){
  ## Query Type - Initialise
  main_chunk <- ""

  ## PersonId
  if(!("PersonId" %in% names(data))){
    stop("There is no `PersonId` variable in the input.")
  } else {
    new_chunk <- paste("There are", dplyr::n_distinct(data$PersonId), "employees in this dataset.")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

  ## Date
  if(!("Date" %in% names(data))){
    stop("There is no `Date` variable in the input.")
  } else {
    data$Date <- as.Date(data$Date, "%m/%d/%Y")
    new_chunk <- paste0("Date ranges from ", min(data$Date), " to ", max(data$Date), ".")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

  ## HR Variables
  hr_chr <- extract_hr(data, max_unique = 200) %>% wrap(wrapper = "`")
  new_chunk <- paste("There are", length(hr_chr), "(estimated) HR attributes in the data:" )
  main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  new_chunk <- paste(hr_chr, collapse = ", ")
  main_chunk <- paste(main_chunk, new_chunk, sep = "\n")

  ## `IsActive` flag
  if(!("IsActive" %in% names(data))){
    new_chunk <- "The `IsActive` flag is not present in the data."
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n")
  } else {
    data$IsActive <- as.logical(data$IsActive) # Force to logical
    active_n <- dplyr::n_distinct(data[data$IsActive == TRUE, "PersonId"])
    new_chunk <- paste0("There are ", active_n, " active employees out of all in the dataset.")
    main_chunk <- paste(main_chunk, new_chunk, sep = "\n\n")
  }

  ## Return
  if(return == "message"){

    main_chunk <- paste("", main_chunk, sep = "\n")
    message(main_chunk)

  } else if(return == "text"){
    main_chunk
  } else {
    stop("Please check inputs for `return`")
  }
}
