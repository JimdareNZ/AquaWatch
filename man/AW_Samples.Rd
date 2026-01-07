\name{AW_Samples}
\alias{AW_Samples}
\title{
Retrieve sample data from an AquaWatch device
}
\description{
Downloads time-filtered sample data from a specified AquaWatch device using the
\code{/samples} API endpoint.
}
\usage{
AW_Samples(
  eui,
  handle,
  limit = NULL,
  time_min = NULL,
  time_max = NULL,
  order = "desc",
  timezone = "etc/GMT-12"
)
}
\arguments{
  \item{eui}{
Character scalar. Device EUI (Extended Unique Identifier) used by the AquaWatch
API, for example \code{"350000000100263"}.
}
  \item{handle}{
A \code{curl_handle} object created with \code{Handle_Generator()}.
}
  \item{limit}{
Optional integer. Maximum number of samples to return.
}
  \item{time_min}{
Optional. Lower time bound for samples. May be a \code{POSIXct}, \code{Date},
or ISO-8601 character string. Maps to the API \code{after} parameter.
}
  \item{time_max}{
Optional. Upper time bound for samples. May be a \code{POSIXct}, \code{Date},
or ISO-8601 character string. Maps to the API \code{before} parameter.
}
  \item{order}{
Character scalar. Sort order for returned samples. Either \code{"asc"} or
\code{"desc"}.
}
  \item{timezone}{
Character scalar. Time zone used when converting \code{POSIXct} inputs to
ISO-8601 strings. Defaults to \code{"etc/GMT-12"}.
}
}
\details{
This function converts supplied time bounds into ISO-8601 format and forwards
them to the AquaWatch API as \code{after} and \code{before} query parameters.

Authentication is performed using the provided \code{handle}. The handle must
contain a valid \code{Authorization: Bearer <token>} header.
}
\value{
An R object parsed from the JSON response. Typically a data frame or list
containing sample measurements and associated timestamps.
}
\seealso{
\code{\link{AW_Get}},
\code{\link{AW_Sites}},
\code{\link{Handle_Generator}}
}
\examples{
\dontrun{
h <- Handle_Generator("YOUR_TOKEN")

# list sites to obtain EUIs
sites <- AW_Sites(handle = h)

# select a device EUI
eui <- sites$eui[1]

# latest samples
s1 <- AW_Samples(eui, handle = h, limit = 10)

# samples within a date range
s2 <- AW_Samples(
  eui,
  handle = h,
  time_min = as.Date("2023-05-01"),
  time_max = as.Date("2023-06-01"),
  order = "asc"
)
}
}
\keyword{utilities}
