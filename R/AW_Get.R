AW_Get <- function(path, query = NULL, handle) {
  if (missing(handle)) stop("handle is required")

  url <- paste0(
    "https://us-central1-riverwatch-be1e4.cloudfunctions.net/api/alpha/",
    path
  )

  if (!is.null(query)) {
    qs <- paste(paste(names(query), query, sep = "="), collapse = "&")
    url <- paste0(url, "?", qs)
  }

  resp <- curl::curl_fetch_memory(url, handle = handle)

  if (resp$status_code != 200) {
    stop("HTTP ", resp$status_code, ": ", rawToChar(resp$content))
  }

  jsonlite::fromJSON(rawToChar(resp$content), simplifyVector = TRUE)
}
