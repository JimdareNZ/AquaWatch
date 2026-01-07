\name{AW_Sites}
\alias{AW_Sites}
\title{
List available AquaWatch sites
}
\description{
Retrieves the list of AquaWatch monitoring sites accessible to the authenticated
user.
}
\usage{
AW_Sites(handle)
}
\arguments{
  \item{handle}{
A \code{curl_handle} object created with \code{Handle_Generator()}.
}
}
\details{
This function is a thin wrapper around \code{AW_Get("sites", handle = handle)}.
It queries the \code{/sites} endpoint of the AquaWatch API and returns metadata
for each available device.

The returned object typically includes an \code{eui} field, which is the device
identifier used in other endpoints (for example \code{"/{eui}/samples"}).
}
\value{
An R object parsed from the JSON response. Typically a data frame containing
one row per site with associated metadata fields, including \code{eui}.
}
\seealso{
\code{\link{AW_Get}},
\code{\link{AW_Samples}},
\code{\link{Check_Credentials}}
}
\examples{
\dontrun{
h <- Handle_Generator("YOUR_TOKEN")

sites <- AW_Sites(handle = h)

# device identifier used by the API
eui <- sites$eui[1]

# retrieve samples for the first device
s <- AW_Samples(eui, handle = h, limit = 10)
}
}
\keyword{utilities}
