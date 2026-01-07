\name{AW_Get}
\alias{AW_Get}
\title{
Perform a GET request to the AquaWatch API
}
\description{
Builds and executes an authenticated HTTP GET request to an AquaWatch API
endpoint and returns the parsed JSON response.
}
\usage{
AW_Get(path, query = NULL, handle)
}
\arguments{
  \item{path}{
Character scalar. API endpoint path appended to the AquaWatch base URL
(e.g. \code{"sites"} or \code{"350000000100263/samples"}).
}
  \item{query}{
Optional named list of query parameters to include in the request
(e.g. \code{list(limit = 10, after = "2023-05-01")}).
}
  \item{handle}{
A \code{curl_handle} object created with \code{Handle_Generator()}.
}
}
\details{
This function constructs the full request URL, appends query parameters if
supplied, and performs the request using the provided \code{handle}.

If the API returns a non-200 HTTP status code, the function stops with an error
and includes the response body in the message to aid debugging.
}
\value{
The parsed JSON response, returned as an R object. Where possible, JSON arrays
are simplified to vectors or data frames using
\code{jsonlite::fromJSON(simplifyVector = TRUE)}.
}
\seealso{
\code{\link{Handle_Generator}},
\code{\link{Check_Credentials}},
\code{\link[curl]{curl_fetch_memory}},
\code{\link[jsonlite]{fromJSON}}
}
\examples{
\dontrun{
h <- Handle_Generator("YOUR_TOKEN")

# list available sites
sites <- AW_Get("sites", handle = h)

# get latest samples for a device using its EUI
eui <- "350000000100263"
samples <- AW_Get(
  paste0(eui, "/samples"),
  query = list(limit = 10),
  handle = h
)
}
}
\keyword{utilities}
